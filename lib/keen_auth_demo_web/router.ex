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

  pipeline :authentication do
    plug :fetch_session
    plug :put_root_layout, {KeenAuthDemoWeb.LayoutView, :root}
  end

  pipeline :authorization do
    plug :fetch_session
    plug KeenAuth.Plug.FetchUser
  end

  scope "/auth" do
    pipe_through :authentication

    KeenAuth.authentication_routes()
  end

  scope "/", KeenAuthDemoWeb do
    pipe_through :browser

    get "/sign-in", PageController, :sign_in
    get "/page2", PageController, :page2
    get "/page3", PageController, :page3

    resources "/user", UserController, except: [:delete, :edit, :update]

    scope "/" do
      pipe_through :authorization

      get "/protected", PageController, :protected
    end

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", KeenAuthDemoWeb do
  #   pipe_through :api
  # end
end
