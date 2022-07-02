defmodule KeenAuthDemoWeb.PageController do
  use KeenAuthDemoWeb, :controller

  alias KeenAuth.Storage
  alias KeenAuthDemoWeb.Context

  def index(conn, _params) do
    render(conn, "index.html",
      current_user: Storage.current_user(conn),
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

  plug KeenAuth.Plug.RequireAuthenticated when action == :admin

  def admin(conn, _params) do
    file =
      conn
      |> create_socket_auth_token()
      |> get_admin_html_file()

    html(conn, file)
  end

  plug KeenAuth.Plug.RequireRoles,[roles: ~w(superuser)] when action == :protected

  def protected(conn, _params) do
    render(conn, "protected.html")
  end

  defp get_admin_html_file(auth_token) do
    max_inactivity = Application.fetch_env!(:dhl_start_web, :session) |> Keyword.fetch!(:cache_ttl)

    :dhl_start_web
    |> :code.priv_dir()
    |> Path.join("static/admin/index.html")
    |> File.read!()
    |> String.replace("{ADMIN_SOCKET_TOKEN}", auth_token)
    |> String.replace("{SESSION_TIMEOUT}", Integer.to_string(max_inactivity))
  end

  defp create_socket_auth_token(conn) do
    current_user = KeenAuth.current_user(conn)
    ctx = Context.user_ctx(conn, current_user)

    # %{user_id: user.user_id, username: user.username}
    Phoenix.Token.encrypt(DhlStartWeb.Endpoint, "admin_socket", :erlang.term_to_binary(%{ctx: ctx}))
  end
end
