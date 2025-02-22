/* tslint:disable */
/* eslint-disable */
// @ts-nocheck

import { ConcreteRequest } from "relay-runtime";

export type SystemModelCreate_getDefaultTenantLocale_QueryVariables = {};
export type SystemModelCreate_getDefaultTenantLocale_QueryResponse = {
    readonly tenantInfo: {
        readonly defaultLocale: string;
    };
};
export type SystemModelCreate_getDefaultTenantLocale_Query = {
    readonly response: SystemModelCreate_getDefaultTenantLocale_QueryResponse;
    readonly variables: SystemModelCreate_getDefaultTenantLocale_QueryVariables;
};



/*
query SystemModelCreate_getDefaultTenantLocale_Query {
  tenantInfo {
    defaultLocale
  }
}
*/

const node: ConcreteRequest = (function(){
var v0 = [
  {
    "alias": null,
    "args": null,
    "concreteType": "TenantInfo",
    "kind": "LinkedField",
    "name": "tenantInfo",
    "plural": false,
    "selections": [
      {
        "alias": null,
        "args": null,
        "kind": "ScalarField",
        "name": "defaultLocale",
        "storageKey": null
      }
    ],
    "storageKey": null
  }
];
return {
  "fragment": {
    "argumentDefinitions": [],
    "kind": "Fragment",
    "metadata": null,
    "name": "SystemModelCreate_getDefaultTenantLocale_Query",
    "selections": (v0/*: any*/),
    "type": "RootQueryType",
    "abstractKey": null
  },
  "kind": "Request",
  "operation": {
    "argumentDefinitions": [],
    "kind": "Operation",
    "name": "SystemModelCreate_getDefaultTenantLocale_Query",
    "selections": (v0/*: any*/)
  },
  "params": {
    "cacheID": "22c5ab295ab3e055d600075bbc525f42",
    "id": null,
    "metadata": {},
    "name": "SystemModelCreate_getDefaultTenantLocale_Query",
    "operationKind": "query",
    "text": "query SystemModelCreate_getDefaultTenantLocale_Query {\n  tenantInfo {\n    defaultLocale\n  }\n}\n"
  }
};
})();
(node as any).hash = '3744e831f6fc97c695deab11c612030f';
export default node;
