defmodule QuickPolls.Web.PollController do
  use QuickPolls.Web, :controller

  alias Doorman.Login.Session
  alias QuickPolls.Poll

  def new(conn, _params) do
    render conn, "new.html", changeset: Poll.new_changeset(%Poll{})
  end
end
