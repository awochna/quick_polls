defmodule QuickPolls.Web.PollControllerTest do
  use QuickPolls.Web.ConnCase, async: true
  import QuickPolls.TestHelpers

  @user %{name: "todrick", email: "todrick@example.com", password: "some secret"}
  @valid_attrs %{name: "Glasses"}
  @invalid_attrs %{}

  setup context do
    if context[:logged_in] do
      user = insert_user(@user)
      conn = Plug.Conn.assign(context.conn, :user_id, user.id)
      [conn: conn]
    end
    :ok
  end

  test "index/2 lists recent polls", %{conn: conn} do
    Enum.each(1..5, fn(_) -> insert_poll(@valid_attrs) end)
    conn = get conn, poll_path(conn, :index)
    assert html_response(conn, 200) =~ @valid_attrs.name
  end

  test "show/2 shows details for a single poll", %{conn: conn} do
    poll = insert_poll(@valid_attrs)
    conn = get conn, poll_path(conn, :show, poll)
    assert html_response(conn, 200) =~ @valid_attrs.name
  end

  test "logged out, new/2 redirects to login page", %{conn: conn} do
    conn = get conn, poll_path(conn, :new)
    assert redirected_to(conn) =~ session_path(conn, :new)
  end

  @tag :logged_in
  @tag :skip
  test "logged in, new/2 provides form for polls", %{conn: conn} do
    conn = get conn, poll_path(conn, :new)
    assert html_response(conn, 200) =~ "Create a new poll"
    assert html_response(conn, 200) =~ "Name"
  end

  describe "create/2" do
    @tag :skip
    test "with valid attributes, creates poll", %{conn: conn} do
      conn = post conn, poll_path(conn, :create), poll: @valid_attrs
      assert html_response(conn, 302)
    end
    @tag :skip
    test "with invalid attributes, doesn't create poll"
  end
  describe "delete/3" do
    @tag :skip
    test "when owner, deletes"
    @tag :skip
    test "when not owner, doesn't delete"
  end
  describe "edit/3" do
    @tag :skip
    test "when owner, provides form for editing"
    @tag :skip
    test "when not owner, provides no form"
  end
  describe "update/3" do
    @tag :skip
    test "when owner, with valid attrs, updates"
    @tag :skip
    test "when owner, with invalid attrs, doesn't update"
    @tag :skip
    test "when not owner, refuses"
  end
end
