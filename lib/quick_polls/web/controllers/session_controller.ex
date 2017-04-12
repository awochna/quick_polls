defmodule QuickPolls.Web.SessionController do
  use QuickPolls.Web, :controller
  import Doorman.Login.Session

  def create(conn, %{"session" => %{"email" => email, "password" => password}}) do
    if user = Doorman.authenticate(email, password) do
      conn
      |> login(user)
      |> put_flash(:notice, "Successfully logged in")
      |> redirect(to: "/")
    else
      conn
      |> put_flash(:error, "That email/password combination doesn't match our records")
      |> render("new.html")
    end
  end

  def new(conn, _params) do
    if Doorman.logged_in?(conn) do
      conn
      |> put_flash(:notice, "You're already logged in.")
      |> redirect(to: "/")
    else
      render(conn, "new.html")
    end
  end

  def delete(conn, _params) do
    conn
    |> logout
    |> redirect(to: "/")
  end
end
