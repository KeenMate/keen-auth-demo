defmodule KeenAuthDemoWeb.PageController do
  use KeenAuthDemoWeb, :controller

  alias KeenAuth.Session

  def index(conn, _params) do
    render(conn, "index.html", current_user: Session.current_user(conn))
  end

  def sign_in(conn, _params) do
    if Session.current_user(conn) do
      redirect(conn, to: "/")
    else
      render(conn, "sign_in.html")
    end
  end
end
