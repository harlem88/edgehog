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

defmodule Edgehog.Geolocation.Providers.GoogleGeocoding do
  @behaviour Edgehog.Geolocation.GeocodingProvider

  alias Edgehog.Config
  alias Edgehog.Geolocation.Coordinates
  use Tesla

  plug Tesla.Middleware.BaseUrl, "https://maps.googleapis.com/maps/api/geocode/json"
  plug Tesla.Middleware.JSON

  @impl Edgehog.Geolocation.GeocodingProvider
  def reverse_geocode(%Coordinates{latitude: latitude, longitude: longitude}) do
    with {:ok, api_key} <- Config.google_geocoding_api_key(),
         query_params = [key: api_key, latlng: "#{latitude},#{longitude}"],
         {:ok, response} <- get("", query: query_params) do
      results = Map.get(response.body, "results", [])

      if Enum.empty?(results) do
        {:error, :address_not_found}
      else
        address =
          results
          |> List.first()
          |> Map.get("formatted_address")

        {:ok, address}
      end
    end
  end
end
