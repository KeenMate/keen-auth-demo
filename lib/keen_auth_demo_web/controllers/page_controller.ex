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

  def pick_tenant(conn, _params) do
    conn
    |> put_root_layout({KeenAuthDemoWeb.LayoutView, "root_no_tenant.html"})
    |> render("pick_tenant.html")
  end

  plug KeenAuth.Plug.RequireRoles,
    [roles: ~w(superuser), handler: {__MODULE__, :forbidden_access}]
    when action == :protected

  def protected(conn, _params) do
    render(conn, "protected.html")
  end

  def forbidden_access(conn) do
    conn
    |> put_status(403)
    |> put_flash(:error, "You are not allowed to view this content")
    |> halt()
  end
end
