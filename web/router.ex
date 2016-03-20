defmodule GameOfCats.Router do
  use GameOfCats.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", GameOfCats do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/session", GameOfCats do
    pipe_through :browser # Use the default browser stack
    get "/", SessionController, :new
    post "/", SessionController, :create
  end

  # Other scopes may use custom stacks.
  # scope "/api", GameOfCats do
  #   pipe_through :api
  # end
end
