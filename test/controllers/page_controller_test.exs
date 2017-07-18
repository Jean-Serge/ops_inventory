defmodule OpsInventory.PageControllerTest do
  use OpsInventory.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Hello OpsInventory!"
  end
end
