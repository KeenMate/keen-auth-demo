defmodule KeenAuthDemoWeb.UserController do
  use KeenAuthDemoWeb, :controller

  alias KeenAuth.Config
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
      |> KeenUser.change(params["user"])
      |> KeenUser.validate()

    if changeset.valid? do
      Logger.info("TODO: Register new user")
      # todo: create user
      conn
      |> Config.get_storage().store(:email, %{user: changeset.data})
      |> redirect_after_register()
    else
      render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"tenant_id" => tenant_id, "id" => username}) do
    with {:ok, [user]} <- DbContext.get_user_by_username(tenant_id, username) do
      changeset = KeenUser.change(KeenUser.new(), user)
      render(conn, "show.html", changeset: changeset)
    end
  end

  def edit(conn, %{"tenant_id" => tenant_id, "id" => username}) do
    with {:ok, [user]} <- DbContext.get_user_by_username(tenant_id, username) do
      changeset = KeenUser.change(KeenUser.new(), user)
      render(conn, "edit.html", changeset: changeset)
    end
  end

  def update(conn, %{"tenant_id" => _tenant_id} = params) do
    changeset =
      KeenUser.new()
      |> KeenUser.change(params["user"])
      |> KeenUser.validate()

    if changeset.valid? do
      Logger.info("TODO: Update existing user")
      # todo: update user
      changeset = KeenUser.change(KeenUser.new(), params["user"])
      render(conn, "edit.html", changeset: changeset)
    else
      render(conn, "edit.html", changeset: changeset)
    end
  end

  def redirect_after_register(conn) do
    requested_path = get_session(conn, :requested_url)
    conn = delete_session(conn, :requested_url)

    redirect(conn, to: requested_path || Routes.page_path(conn, :index, tenant_id(conn)))
  end
end
