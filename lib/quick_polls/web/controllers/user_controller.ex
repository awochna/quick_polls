defmodule QuickPolls.Web.UserController do
  use QuickPolls.Web, :controller

  alias QuickPolls.Repo
  alias QuickPolls.User

  def new(conn, _params) do
    render conn, "new.html", changeset: User.create_changeset(%User{})
  end

  def create(conn, %{"user" => user_params}) do
    changeset = User.create_changeset(%User{}, user_params)

    case Repo.insert(changeset) do
      {:ok, user} ->
        redirect(conn, to: page_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
