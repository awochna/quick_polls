defmodule QuickPolls.Web.SessionControllerTest do
  use QuickPolls.Web.ConnCase, async: true

  alias QuickPolls.User
  alias QuickPolls.Repo

  @user %{name: "todrick", email: "todrick@example.com", password: "some secret"}
  @valid_creds %{email: @user.email, password: @user.password}
  @invalid_creds %{email: @user.email, password: "another secret"}

  setup %{conn: conn} do
    changeset = User.create_changeset(%User{}, @user)
    Repo.insert!(changeset)

    {:ok, %{conn: conn}}
  end

  test "signing in with the right password", %{conn: conn} do
    conn = post conn, session_path(conn, :create), session: @valid_creds
    assert redirected_to(conn) == "/"
  end

  test "signing in with the wrong password", %{conn: conn} do
    conn = post conn, session_path(conn, :create), session: @invalid_creds
    assert html_response(conn, 200) =~ "Log in"
  end

  test "viewing login page when already signed in redirects to index", %{conn: conn} do
    conn = post conn, session_path(conn, :create), session: @valid_creds
    assert redirected_to(conn) == "/"
    conn = get conn, session_path(conn, :new)
    assert redirected_to(conn) == "/"
  end

  test "can log out after logging in", %{conn: conn} do
    conn = post conn, session_path(conn, :create), session: @valid_creds
    conn = delete conn, session_path(conn, :delete, :session)
    assert redirected_to(conn) == "/"
    conn = get conn, session_path(conn, :new)
    assert html_response(conn, 200) =~ "Log in"
  end

  test "logging out if not logged in does nothing", %{conn: conn} do
    conn = delete conn, session_path(conn, :delete, :session)
    assert redirected_to(conn) == "/"
  end
end
