defmodule OpsInventory.DigitalOceanControllerTest do
    use OpsInventory.ConnCase

    test "Synchronize droplets", %{conn: conn} do
        conn = patch conn, "/api/synchronize_droplets"
        assert json_response(conn, 200) === %{"ok" => true}
    end
end