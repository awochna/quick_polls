defmodule QuickPolls.Web.UserControllerTest do
  use QuickPolls.Web.ConnCase, async: true

  alias QuickPolls.Repo
  alias QuickPolls.User

  @valid_attrs %{name: "Todrick", email: "todrick@example.com", password: "some secret"}
  @no_password %{name: "Todrick", email: "todrick@example.com"}
  @invalid_attrs %{}

  test "new/2 displays signup form", %{conn: conn} do
    conn = get conn, user_path(conn, :new)
    assert html_response(conn, 200) =~ "Sign up"
  end

  describe "create/2" do
    test "Create a new user if attributes are valid", %{conn: conn} do
      conn = post conn, user_path(conn, :create), user: @valid_attrs
      assert redirected_to(conn) == page_path(conn, :index)
      assert html_response(conn, 302)
      assert Repo.get_by(User, %{email: @valid_attrs.email})
    end

    test "Does not create user if attributes are invalid", %{conn: conn} do
      conn = post conn, user_path(conn, :create), user: @invalid_attrs
      assert html_response(conn, 200) =~ "Sign up"
    end

    test "Does not create user if missing password", %{conn: conn} do
      conn = post conn, user_path(conn, :create), user: @no_password
      assert html_response(conn, 200) =~ "Sign up"
      refute Repo.get_by(User, %{email: @no_password.email})
    end

    test "Does not create a user if using a duplicate email address", %{conn: conn} do
      changeset = User.create_changeset(%User{}, @valid_attrs)
      Repo.insert!(changeset)
      conn = post conn, user_path(conn, :create), user: @valid_attrs
      assert html_response(conn, 200) =~ "has already been taken"
    end
  end

  describe "edit/2" do
    @tag skip: "update accounts"
    test "displays edit form if signed in"
    @tag skip: "update accounts"
    test "redirects to index if not signed in"
  end

  describe "update/2" do
    @tag skip: "update accounts"
    test "can change name, without requiring password"
    @tag skip: "update accounts"
    test "can change email, if unique"
    @tag skip: "update accounts"
    test "can change password"
  end
end
