defmodule KeenAuthDemoWeb.UserController do
  use KeenAuthDemoWeb, :controller

  alias KeenAuthDemo.KeenUser
  alias KeenAuthDemo.Database.DbContext

  require Logger

  def new(conn, _params) do
    changeset = KeenUser.new()

    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"tenant_id" => _tenant_id} = params) do
    changeset =
      KeenUser.new()
      |> KeenUser.change(params["changeset"])
      |> KeenUser.validate()

    if changeset.valid? do
      Logger.info("TODO: Register new user")
      # todo: create user
      redirect_after_register(conn)
    else
      render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"tenant_id" => tenant_id, "id" => username}) do
    with {:ok, [user]} <- DbContext.get_user_by_username(tenant_id, username) do
      render(conn, "show.html", changeset: KeenUser.new(user))
    end
  end

  def edit(conn, %{"tenant_id" => tenant_id, "id" => username}) do
    with {:ok, [user]} <- DbContext.get_user_by_username(tenant_id, username) do
      render(conn, "edit.html", changeset: KeenUser.new(user))
    end
  end

  def update(conn, %{"tenant_id" => _tenant_id} = params) do
    changeset =
      KeenUser.new()
      |> KeenUser.change(params["changeset"])
      |> KeenUser.validate()

    if changeset.valid? do
      Logger.info("TODO: Update existing user")
      # todo: create user
      render(conn, "edit.html", changeset: KeenUser.new(params["changeset"]))
    else
      render(conn, "edit.html", changeset: changeset)
    end
  end

  def redirect_after_register(conn) do
    requested_path = get_session(conn, :requested_url)
    conn = delete_session(conn, :requested_url)

    redirect(conn, to: requested_path || Routes.page_path(conn, :page1))
  end
end
