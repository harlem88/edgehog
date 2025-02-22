#
# This file is part of Edgehog.
#
# Copyright 2021 SECO Mind Srl
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

defmodule EdgehogWeb.Schema.Query.SystemModelTest do
  use EdgehogWeb.ConnCase

  import Edgehog.DevicesFixtures

  alias Edgehog.Devices.{
    SystemModel,
    SystemModelPartNumber
  }

  describe "systemModel field" do
    @query """
    query ($id: ID!) {
      systemModel(id: $id) {
        name
        handle
        partNumbers
        hardwareType {
          name
        }
        description {
          locale
          text
        }
      }
    }
    """
    test "returns system model if present", %{conn: conn, api_path: api_path} do
      hardware_type = hardware_type_fixture()

      %SystemModel{
        id: id,
        name: name,
        handle: handle,
        part_numbers: [%SystemModelPartNumber{part_number: part_number}]
      } = system_model_fixture(hardware_type)

      variables = %{id: Absinthe.Relay.Node.to_global_id(:system_model, id, EdgehogWeb.Schema)}

      conn = get(conn, api_path, query: @query, variables: variables)

      assert json_response(conn, 200) == %{
               "data" => %{
                 "systemModel" => %{
                   "name" => name,
                   "handle" => handle,
                   "partNumbers" => [part_number],
                   "hardwareType" => %{
                     "name" => hardware_type.name
                   },
                   "description" => nil
                 }
               }
             }
    end

    test "returns not found if non existing", %{conn: conn, api_path: api_path} do
      variables = %{id: Absinthe.Relay.Node.to_global_id(:system_model, 1, EdgehogWeb.Schema)}

      conn = get(conn, api_path, query: @query, variables: variables)

      assert %{
               "data" => %{"systemModel" => nil},
               "errors" => [%{"code" => "not_found", "status_code" => 404}]
             } = json_response(conn, 200)
    end

    test "returns the default locale description", %{
      conn: conn,
      api_path: api_path,
      tenant: tenant
    } do
      hardware_type = hardware_type_fixture()

      default_locale = tenant.default_locale

      descriptions = [
        %{locale: default_locale, text: "A system model"},
        %{locale: "it-IT", text: "Un modello di sistema"}
      ]

      %SystemModel{id: id} = system_model_fixture(hardware_type, descriptions: descriptions)

      variables = %{id: Absinthe.Relay.Node.to_global_id(:system_model, id, EdgehogWeb.Schema)}

      conn = get(conn, api_path, query: @query, variables: variables)

      assert %{
               "data" => %{
                 "systemModel" => %{
                   "description" => %{
                     "locale" => ^default_locale,
                     "text" => "A system model"
                   }
                 }
               }
             } = json_response(conn, 200)
    end

    test "returns the explicit locale description", %{
      conn: conn,
      api_path: api_path,
      tenant: tenant
    } do
      hardware_type = hardware_type_fixture()

      default_locale = tenant.default_locale

      descriptions = [
        %{locale: default_locale, text: "A system model"},
        %{locale: "it-IT", text: "Un modello di sistema"}
      ]

      %SystemModel{id: id} = system_model_fixture(hardware_type, descriptions: descriptions)

      variables = %{id: Absinthe.Relay.Node.to_global_id(:system_model, id, EdgehogWeb.Schema)}

      conn =
        conn
        |> put_req_header("accept-language", "it-IT")
        |> get(api_path, query: @query, variables: variables)

      assert %{
               "data" => %{
                 "systemModel" => %{
                   "description" => %{
                     "locale" => "it-IT",
                     "text" => "Un modello di sistema"
                   }
                 }
               }
             } = json_response(conn, 200)
    end

    test "returns empty description for not existing locale", %{
      conn: conn,
      api_path: api_path,
      tenant: tenant
    } do
      hardware_type = hardware_type_fixture()

      default_locale = tenant.default_locale

      descriptions = [
        %{locale: default_locale, text: "A system model"},
        %{locale: "it-IT", text: "Un modello di sistema"}
      ]

      %SystemModel{id: id} = system_model_fixture(hardware_type, descriptions: descriptions)

      variables = %{id: Absinthe.Relay.Node.to_global_id(:system_model, id, EdgehogWeb.Schema)}

      conn =
        conn
        |> put_req_header("accept-language", "fr-FR")
        |> get(api_path, query: @query, variables: variables)

      assert %{
               "data" => %{
                 "systemModel" => %{
                   "description" => nil
                 }
               }
             } = json_response(conn, 200)
    end
  end
end
