defmodule KeenAuthDemoWeb.PageController do
  use KeenAuthDemoWeb, :controller

  alias KeenAuth.Storage

  def index(conn, _params) do
    render(conn, "index.html",
      current_user: Storage.get_store().current_user(conn),
      oauth_response: get_session(conn, :oauth_response)
    )
  end

  def sign_in(conn, _params) do
    if Storage.get_store().current_user(conn) do
      redirect(conn, to: "/")
    else
      render(conn, "sign_in.html")
    end
  end
end
