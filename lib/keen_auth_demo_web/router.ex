defmodule KeenAuthDemoWeb.Router do
  use KeenAuthDemoWeb, :router

  require KeenAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {KeenAuthDemoWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :auth do
    plug :fetch_session
    plug :put_root_layout, {KeenAuthDemoWeb.LayoutView, :root}
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/auth" do
    pipe_through :auth

    KeenAuth.authentication_routes()
  end

  scope "/", KeenAuthDemoWeb do
    pipe_through :browser

    get "/sign-in", PageController, :sign_in
    get "/page2", PageController, :page2
    get "/page3", PageController, :page3
    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", KeenAuthDemoWeb do
  #   pipe_through :api
  # end
end
