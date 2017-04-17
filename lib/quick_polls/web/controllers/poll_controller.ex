defmodule QuickPolls.Web.PollController do
  use QuickPolls.Web, :controller

  alias Doorman.Login.Session
  alias QuickPolls.Poll
  alias QuickPolls.Repo

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
    if Doorman.logged_in?(conn) do
      render conn, "new.html", changeset: Poll.new_changeset(%Poll{})
    else
      conn
      |> put_flash(:warn, "You have to log in first")
      |> redirect(to: session_path(conn, :new))
    end
  end

  def create(conn, %{"poll" => poll_params}) do
    if Doorman.logged_in?(conn) do
      poll_params = Map.put(poll_params, "user", Session.get_current_user(conn))
      changeset = Poll.create_changeset(%Poll{}, poll_params)

      case Repo.insert(changeset) do
        {:ok, poll} ->
          conn
          |> put_flash(:success, "Poll created")
          |> redirect(to: poll_path(conn, :show, poll))
        {:error, changeset} ->
          render(conn, "new.html", changeset: changeset)
      end
    else
      conn
      |> put_flash(:warn, "You have to log in first")
      |> redirect(to: session_path(conn, :new))
    end
  end
end
