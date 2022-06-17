defmodule KeenAuthDemoWeb.UserController do
  use KeenAuthDemoWeb, :controller

  alias KeenAuthDemo.KeenUser

  require Logger

  def new(conn, _params) do
    changeset = KeenUser.new()

    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, params) do
    changeset =
      params["changeset"]
      |> KeenUser.new()
      |> KeenUser.validate()

    if changeset.valid? do
      Logger.info("Registering new user")
      # todo: create user
      redirect_after_register(conn)
    else
      render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    render(conn, "show.html", KeenUser.new(%{id: id}))
  end

  def redirect_after_register(conn) do
    requested_path = get_session(conn, :requested_url)
    conn = delete_session(conn, :requested_url)

    redirect(conn, to: requested_path || Routes.page_path(conn, :page1))
  end
end
