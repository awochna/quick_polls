defmodule QuickPolls.Web.PageController do
  use QuickPolls.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
