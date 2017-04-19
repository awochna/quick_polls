defmodule QuickPolls.Web.PollController do
  use QuickPolls.Web, :controller

  alias QuickPolls.Repo
  alias QuickPolls.Poll
  alias QuickPolls.Web.RequireLogin

  plug RequireLogin when action in [:new, :create, :edit, :update, :delete]

  def index(conn, _params) do
    render conn, "index.html", polls: Repo.all(Poll)
  end

  def show(conn, %{"id" => poll_id}) do
    poll = Repo.get(Poll, poll_id)
    if poll do
      render conn, "show.html", poll: poll
    else
      render conn, 404
    end
  end

  def new(conn, _params) do
    render conn, "new.html", changeset: Poll.new_changeset(%Poll{})
  end

  def create(conn, %{"poll" => poll_params}) do
    user = conn.assigns.current_user
    poll_params = Map.put(poll_params, "user", user)
    changeset = Poll.create_changeset(%Poll{}, poll_params)

    case Repo.insert(changeset) do
      {:ok, poll} ->
        conn
        |> put_flash(:success, "Poll created")
        |> redirect(to: poll_path(conn, :show, poll))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"id" => poll_id}) do
    poll = Repo.preload(Repo.get(Poll, poll_id), :user)
    user = conn.assigns.current_user
    if poll.user == user do
      render conn, "edit.html", changeset: Poll.edit_changeset(poll), poll: poll
    else
      conn
      |> put_flash(:warn, "You don't own that poll")
      |> redirect(to: poll_path(conn, :index))
    end
  end
end
