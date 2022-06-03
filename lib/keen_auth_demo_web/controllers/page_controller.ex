defmodule KeenAuthDemoWeb.PageController do
  use KeenAuthDemoWeb, :controller

  alias KeenAuth.Config

  def index(conn, _params) do
    render(conn, "index.html",
      current_user: Config.get_storage().current_user(conn),
      oauth_response: get_session(conn, :oauth_response)
    )
  end

  def page2(conn, _params) do
    render(conn, "page2.html")
  end

  def page3(conn, _params) do
    render(conn, "page3.html")
  end

  def sign_in(conn, _params) do
    if Config.get_storage().current_user(conn) do
      redirect(conn, to: "/")
    else
      render(conn, "sign_in.html")
    end
  end

  plug KeenAuth.Plug.RequireRoles, [roles: ~w(superuser)] when action == :protected

  def protected(conn, _params) do
    render(conn, "protected.html")
  end
end
