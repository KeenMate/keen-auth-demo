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
    # plug :fetch_session
    plug KeenAuth.Plug.FetchUser
    plug KeenAuth.Plug.RequireAuthenticated
    plug KeenAuthPermissions.Plug.FetchTenantPermissions
  end

  scope "/:tenant_code" do
    scope "/auth" do
      pipe_through :authentication

      KeenAuth.authentication_routes()
    end

    scope "/", KeenAuthDemoWeb do
      pipe_through :browser

      get "/page2", PageController, :page2
      get "/page3", PageController, :page3

      get "/sign-up", SignUpController, :get
      post "/sign-up", SignUpController, :post

      # resources "/session", SessionController, only: [:new, :create]
      get "/sign-in", SignInController, :get
      post "/sign-in", SignInController, :post
      get "/sign-out", SignInController, :sign_out

      scope "/" do
        pipe_through :authorization

        get "/protected", PageController, :protected
      end

      get "/", PageController, :index
    end
  end

  scope "/", KeenAuthDemoWeb do
    pipe_through :browser

    get "/", PageController, :pick_tenant
  end

  # Other scopes may use custom stacks.
  # scope "/api", KeenAuthDemoWeb do
  #   pipe_through :api
  # end
end
