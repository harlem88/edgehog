/* tslint:disable */
/* eslint-disable */
// @ts-nocheck

import { ReaderFragment } from "relay-runtime";

import { FragmentRefs } from "relay-runtime";
export type OtaOperationStatus = "DONE" | "ERROR" | "IN_PROGRESS" | "PENDING" | "%future added value";
export type Device_otaOperations = {
    readonly id: string;
    readonly otaOperations: ReadonlyArray<{
        readonly id: string;
        readonly baseImageUrl: string;
        readonly status: OtaOperationStatus;
    }>;
    readonly " $fragmentRefs": FragmentRefs<"OperationTable_otaOperations">;
    readonly " $refType": "Device_otaOperations";
};
export type Device_otaOperations$data = Device_otaOperations;
export type Device_otaOperations$key = {
    readonly " $data"?: Device_otaOperations$data | undefined;
    readonly " $fragmentRefs": FragmentRefs<"Device_otaOperations">;
};



const node: ReaderFragment = (function(){
var v0 = {
  "alias": null,
  "args": null,
  "kind": "ScalarField",
  "name": "id",
  "storageKey": null
};
return {
  "argumentDefinitions": [],
  "kind": "Fragment",
  "metadata": null,
  "name": "Device_otaOperations",
  "selections": [
    (v0/*: any*/),
    {
      "alias": null,
      "args": null,
      "concreteType": "OtaOperation",
      "kind": "LinkedField",
      "name": "otaOperations",
      "plural": true,
      "selections": [
        (v0/*: any*/),
        {
          "alias": null,
          "args": null,
          "kind": "ScalarField",
          "name": "baseImageUrl",
          "storageKey": null
        },
        {
          "alias": null,
          "args": null,
          "kind": "ScalarField",
          "name": "status",
          "storageKey": null
        }
      ],
      "storageKey": null
    },
    {
      "args": null,
      "kind": "FragmentSpread",
      "name": "OperationTable_otaOperations"
    }
  ],
  "type": "Device",
  "abstractKey": null
};
})();
(node as any).hash = '2f353b925a526bae9772035ab80c4cb1';
export default node;
