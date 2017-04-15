defmodule QuickPolls.Web.PollControllerTest do
  use QuickPolls.Web.ConnCase, async: true
  import QuickPolls.TestHelpers

  @valid_attrs %{name: "Glasses"}
  @invalid_attrs %{}

  test "index/2 lists recent polls", %{conn: conn} do
    Enum.each(1..5, fn(_) -> insert_poll(@valid_attrs) end)
    conn = get conn, poll_path(conn, :index)
    assert html_response(conn, 200) =~ @valid_attrs.name
  end

  test "new/2 provides form for polls", %{conn: conn} do
    conn = get conn, poll_path(conn, :new)
    assert html_response(conn, 200) =~ "Create a new poll"
    assert html_response(conn, 200) =~ "Name"
  end

  describe "create/2" do
    test "with valid attributes, creates poll"
    test "with invalid attributes, doesn't create poll"
  end
  describe "delete/3" do
    test "when owner, deletes"
    test "when not owner, doesn't delete"
  end
  describe "edit/3" do
    test "when owner, provides form for editing"
    test "when not owner, provides no form"
  end
  describe "update/3" do
    test "when owner, with valid attrs, updates"
    test "when owner, with invalid attrs, doesn't update"
    test "when not owner, refuses"
  end
end
