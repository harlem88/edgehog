/*
  This file is part of Edgehog.

  Copyright 2021-2022 SECO Mind Srl

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
*/

import {
  Environment,
  FetchFunction,
  Network,
  RecordSource,
  Store,
  UploadableMap,
} from "relay-runtime";

import { AuthConfig, loadAuthConfig } from "contexts/Auth";

const applicationMetatag: HTMLElement = document.head.querySelector(
  "[name=application-name]"
)!;
const backendUrl = applicationMetatag.dataset?.backendUrl || "";

const fetchGraphQL = async (
  query: string | null | undefined,
  variables: Record<string, unknown>,
  authConfig: AuthConfig
) => {
  const userLanguage = navigator.language; // TODO allow users to overwrite this
  const apiUrl = new URL(`tenants/${authConfig.tenantSlug}/api`, backendUrl);
  const response = await fetch(apiUrl.toString(), {
    method: "POST",
    headers: {
      Authorization: `Bearer ${authConfig.authToken}`,
      "Content-Type": "application/json",
      "Accept-Language": userLanguage,
    },
    body: JSON.stringify({ query, variables }),
  });
  return await response.json();
};

const uploadGraphQL = async (
  query: string | null | undefined,
  variables: Record<string, unknown>,
  uploadables: UploadableMap,
  authConfig: AuthConfig
) => {
  const apiUrl = new URL(`tenants/${authConfig.tenantSlug}/api`, backendUrl);
  const request: RequestInit = {
    method: "POST",
    headers: {
      Authorization: `Bearer ${authConfig.authToken}`,
    },
  };
  const formData = new FormData();
  Object.entries(uploadables).forEach(([key, file]) => {
    formData.append(key, file);
  });
  formData.append("query", query!);
  formData.append("variables", JSON.stringify(variables));
  request.body = formData;
  const response = await fetch(apiUrl.toString(), request);
  return await response.json();
};

const extractUploadables = (
  initVariables: Record<string, any>
): { variables: Record<string, any>; uploadables?: Record<string, File> } => {
  let variables: Record<string, any> = {};
  let uploadables: Record<string, any> | undefined = undefined;
  Object.entries(initVariables).forEach(([key, value]) => {
    if (value instanceof File) {
      variables[key] = key;
      uploadables = {
        ...(uploadables || {}),
        [key]: value,
      };
    } else if (
      typeof value === "object" &&
      !Array.isArray(value) &&
      value !== null
    ) {
      const extracted = extractUploadables(value);
      variables[key] = extracted.variables;
      if (extracted.uploadables) {
        uploadables = {
          ...(uploadables || {}),
          ...extracted.uploadables,
        };
      }
    } else {
      variables[key] = value;
    }
  });
  return { variables, uploadables };
};

const fetchRelay: FetchFunction = async (
  operation,
  variables,
  cacheConfig,
  uploadables
) => {
  const authConfig = loadAuthConfig();
  if (!authConfig) {
    throw new Error(
      "Auth configuration not found, a tenant need to be selected."
    );
  }
  const extracted = extractUploadables(variables);
  return extracted.uploadables
    ? uploadGraphQL(
        operation.text,
        extracted.variables,
        extracted.uploadables,
        authConfig
      )
    : fetchGraphQL(operation.text, variables, authConfig);
};

const relayEnvironment = new Environment({
  network: Network.create(fetchRelay),
  store: new Store(new RecordSource()),
});

export { fetchGraphQL, relayEnvironment };
