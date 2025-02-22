/*
  This file is part of Edgehog.

  Copyright 2021 SECO Mind Srl

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

import React from "react";
import { FormattedMessage } from "react-intl";

import Table from "components/Table";
import type { Column } from "components/Table";
import { Link, Route } from "Navigation";

type SystemModelProps = {
  id: string;
  handle: string;
  name: string;
  hardwareType: {
    name: string;
  };
  partNumbers: string[];
};

const columns: Column<SystemModelProps>[] = [
  {
    accessor: "name",
    Header: (
      <FormattedMessage
        id="components.SystemModelsTable.nameTitle"
        defaultMessage="System Model Name"
      />
    ),
    Cell: ({ row, value }) => (
      <Link
        route={Route.systemModelsEdit}
        params={{ systemModelId: row.original.id }}
      >
        {value}
      </Link>
    ),
  },
  {
    accessor: "handle",
    Header: (
      <FormattedMessage
        id="components.SystemModelsTable.handleTitle"
        defaultMessage="Handle"
      />
    ),
    Cell: ({ value }) => <span className="text-nowrap">{value}</span>,
  },
  {
    id: "hardwareType",
    accessor: (row) => row.hardwareType.name,
    Header: (
      <FormattedMessage
        id="components.SystemModelsTable.hardwareType"
        defaultMessage="Hardware Type"
      />
    ),
    Cell: ({ value }: { value: string }) => (
      <span className="text-nowrap">{value}</span>
    ),
  },
  {
    accessor: "partNumbers",
    Header: (
      <FormattedMessage
        id="components.SystemModelsTable.partNumbersTitle"
        defaultMessage="Part Numbers"
      />
    ),
    Cell: ({ value }) =>
      value.map((partNumber, index) => (
        <React.Fragment key={partNumber}>
          {index > 0 && ", "}
          <span className="text-nowrap">{partNumber}</span>
        </React.Fragment>
      )),
    disableSortBy: true,
  },
];

interface Props {
  className?: string;
  data: SystemModelProps[];
}

const SystemModelsTable = ({ className, data }: Props) => {
  return <Table className={className} columns={columns} data={data} />;
};

export type { SystemModelProps };

export default SystemModelsTable;
