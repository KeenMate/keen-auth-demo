defmodule TestKeenAuthWeb.Router do
  use TestKeenAuthWeb, :router

  require KeenAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {TestKeenAuthWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/auth" do
    pipe_through :browser

    KeenAuth.authentication_routes()
  end

  scope "/", TestKeenAuthWeb do
    pipe_through :browser

    get "/sign-in", PageController, :sign_in
    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", TestKeenAuthWeb do
  #   pipe_through :api
  # end
end
