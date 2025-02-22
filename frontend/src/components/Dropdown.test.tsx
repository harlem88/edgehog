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
import { render, screen, waitFor } from "@testing-library/react";
import userEvent from "@testing-library/user-event";

import Dropdown from "./Dropdown";

it("renders and toggles correctly", async () => {
  render(
    <Dropdown toggle={<button />}>
      <Dropdown.Item>
        <div data-testid="dropdown-item" />
      </Dropdown.Item>
      <Dropdown.Divider />
    </Dropdown>
  );
  expect(screen.queryByTestId("dropdown-item")).not.toBeInTheDocument();
  userEvent.click(screen.getByRole("button"));
  await waitFor(() =>
    expect(screen.queryByTestId("dropdown-item")).toBeInTheDocument()
  );
});
