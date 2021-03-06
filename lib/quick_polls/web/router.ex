defmodule QuickPolls.Web.Router do
  use QuickPolls.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Doorman.Login.Session
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", QuickPolls.Web do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/users", UserController
    resources "/sessions", SessionController, singleton: true
    resources "/polls", PollController
  end

  # Other scopes may use custom stacks.
  # scope "/api", QuickPolls.Web do
  #   pipe_through :api
  # end
end
