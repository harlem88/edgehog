#
# This file is part of Astarte.
#
# Copyright 2022 SECO Mind Srl
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

defmodule EdgehogWeb.Auth.Token do
  use Guardian, otp_app: :edgehog

  # This is used only when signing tokens, and we just want to verify them
  # However, we want to be able to generate tokens in tests, so we provide
  # an implementation only for the test env
  if Mix.env() == :test do
    def subject_for_token(_resource, _claims) do
      {:ok, "test"}
    end
  else
    def subject_for_token(_resource, _claims) do
      {:error, :cannot_sign}
    end
  end

  def resource_from_claims(claims) do
    # TODO: for now we just check that some e_tga claims are encoded in the token,
    # and we don't care about their value
    # e_tga = Edgehog Tenant GraphQL API
    case Map.fetch(claims, "e_tga") do
      {:ok, claims} ->
        {:ok, %{claims: claims}}

      :error ->
        {:error, :no_valid_claims}
    end
  end
end
