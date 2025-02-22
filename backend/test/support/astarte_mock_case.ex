#
# This file is part of Edgehog.
#
# Copyright 2021-2022 SECO Mind Srl
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

defmodule Edgehog.AstarteMockCase do
  @moduledoc """
  This module defines the setup for tests requiring
  access to the application's data layer.

  You may define functions here to be used as helpers in
  your tests.

  Finally, if the test case interacts with the database,
  we enable the SQL sandbox, so changes done to the database
  are reverted at the end of every test. If you are using
  PostgreSQL, you can even run database tests asynchronously
  by setting `use Edgehog.DataCase, async: true`, although
  this option is not recommended for other databases.
  """

  use ExUnit.CaseTemplate

  using do
    quote do
      import Mox
      import Edgehog.AstarteMockCase
    end
  end

  import Mox

  setup :verify_on_exit!

  setup do
    Mox.stub_with(
      Edgehog.Astarte.Device.DeviceStatusMock,
      Edgehog.Mocks.Astarte.Device.DeviceStatus
    )

    Mox.stub_with(
      Edgehog.Astarte.Device.BaseImageMock,
      Edgehog.Mocks.Astarte.Device.BaseImage
    )

    Mox.stub_with(
      Edgehog.Astarte.Device.OSInfoMock,
      Edgehog.Mocks.Astarte.Device.OSInfo
    )

    Mox.stub_with(
      Edgehog.Astarte.Device.OTARequestMock,
      Edgehog.Mocks.Astarte.Device.OTARequest
    )

    Mox.stub_with(
      Edgehog.Astarte.Device.StorageUsageMock,
      Edgehog.Mocks.Astarte.Device.StorageUsage
    )

    Mox.stub_with(
      Edgehog.Astarte.Device.SystemStatusMock,
      Edgehog.Mocks.Astarte.Device.SystemStatus
    )

    Mox.stub_with(
      Edgehog.Astarte.Device.WiFiScanResultMock,
      Edgehog.Mocks.Astarte.Device.WiFiScanResult
    )

    Mox.stub_with(
      Edgehog.Astarte.Device.BatteryStatusMock,
      Edgehog.Mocks.Astarte.Device.BatteryStatus
    )

    Mox.stub_with(
      Edgehog.Astarte.Device.CellularConnectionMock,
      Edgehog.Mocks.Astarte.Device.CellularConnection
    )

    Mox.stub_with(
      Edgehog.Astarte.Device.RuntimeInfoMock,
      Edgehog.Mocks.Astarte.Device.RuntimeInfo
    )

    Mox.stub_with(
      Edgehog.Astarte.Device.LedBehaviorMock,
      Edgehog.Mocks.Astarte.Device.LedBehavior
    )

    :ok
  end
end
