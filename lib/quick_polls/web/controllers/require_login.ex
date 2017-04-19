defmodule QuickPolls.Web.RequireLogin do
  import Plug.Conn
  import Phoenix.Controller, only: [redirect: 2]

  alias QuickPolls.Web.Router.Helpers

  def init(opts), do: opts

  def call(conn, _opts) do
    if Doorman.logged_in?(conn) do
      conn
    else
      conn
      |> redirect(to: Helpers.session_path(conn, :new))
      |> halt
    end
  end
end
