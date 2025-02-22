#
# This file is part of Edgehog.
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

defmodule Edgehog.Mocks.Astarte.Device.RuntimeInfo do
  @behaviour Edgehog.Astarte.Device.RuntimeInfo.Behaviour

  alias Astarte.Client.AppEngine
  alias Edgehog.Astarte.Device.RuntimeInfo

  @impl true
  def get(%AppEngine{} = _client, _device_id) do
    runtime_info = %RuntimeInfo{
      name: "edgehog-esp32-device",
      version: "0.1.0",
      environment: "esp-idf v4.3",
      url: "https://github.com/edgehog-device-manager/edgehog-esp32-device"
    }

    {:ok, runtime_info}
  end
end
