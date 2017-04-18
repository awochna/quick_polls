defmodule QuickPolls.Web.PollControllerTest do
  use QuickPolls.Web.ConnCase, async: true
  import QuickPolls.TestHelpers

  alias QuickPolls.Poll

  @valid_attrs %{"name" => "Glasses"}
  @invalid_attrs %{}

  setup do
    user = insert_user()
    [user: user]
  end

  test "index/2 lists recent polls", %{conn: conn} do
    Enum.each(1..5, fn(_) -> insert_poll(@valid_attrs) end)
    conn = get conn, poll_path(conn, :index)
    assert html_response(conn, 200) =~ @valid_attrs["name"]
  end

  test "show/2 shows details for a single poll", %{conn: conn} do
    poll = insert_poll(@valid_attrs)
    conn = get conn, poll_path(conn, :show, poll)
    assert html_response(conn, 200) =~ @valid_attrs["name"]
  end

  test "logged out, new/2 redirects to login page", %{conn: conn} do
    conn = get conn, poll_path(conn, :new)
    assert redirected_to(conn) =~ session_path(conn, :new)
  end

  @tag :logged_in
  test "logged in, new/2 provides form for polls", %{conn: conn, user: user} do
    conn = assign(conn, :current_user, user.id)
    conn = get conn, poll_path(conn, :new)
    assert html_response(conn, 200) =~ "Create a new poll"
    assert html_response(conn, 200) =~ "Name"
  end

  describe "create/2" do
    test "logged out, with valid attributes, redirects to login", %{conn: conn} do
      conn = post conn, poll_path(conn, :create), poll: @valid_attrs
      assert redirected_to(conn, 302) =~ "sessions"
    end
    test "logged in, with valid attributes, creates poll", %{conn: conn, user: user} do
      conn = assign(conn, :current_user, user)
      conn = post conn, poll_path(conn, :create), poll: @valid_attrs
      assert redirected_to(conn, 302) =~ "polls"
      assert Enum.count(QuickPolls.Repo.all(Poll)) == 1
    end
    test "logged in, with invalid attributes, doesn't create poll", %{conn: conn, user: user} do
      conn = assign(conn, :current_user, user)
      conn = post conn, poll_path(conn, :create), poll: @invalid_attrs
      assert html_response(conn, 200) =~ "Oops"
      assert Enum.count(QuickPolls.Repo.all(Poll)) == 0
    end
  end

  describe "edit/3" do
    test "when owner, provides form for editing", %{conn: conn, user: user} do
      conn = assign(conn, :current_user, user)
      poll = insert_poll(%{"user" => user})
      conn = get conn, poll_path(conn, :edit, poll)
      assert html_response(conn, 200) =~ "Name"
    end
    test "when not owner, redirects to index", %{conn: conn, user: user} do
      poll = insert_poll()
      conn = assign(conn, :current_user, user.id)
      conn = get conn, poll_path(conn, :edit, poll)
      assert redirected_to(conn) == poll_path(conn, :index)
    end
    @tag :skip
    test "when not logged in, redirects to login form"
  end
  describe "update/3" do
    @tag :skip
    test "when owner, with valid attrs, updates"
    @tag :skip
    test "when owner, with invalid attrs, doesn't update"
    @tag :skip
    test "when not owner, refuses"
  end
  describe "delete/3" do
    @tag :skip
    test "when owner, deletes"
    @tag :skip
    test "when not owner, doesn't delete"
  end
end
