defmodule QuickPolls.Web.PageControllerTest do
  use QuickPolls.Web.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Make fun polls"
  end
end
