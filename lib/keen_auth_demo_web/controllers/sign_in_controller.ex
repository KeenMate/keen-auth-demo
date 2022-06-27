defmodule KeenAuthDemoWeb.SignInController do
  use KeenAuthDemoWeb, :controller

  alias KeenAuth.Config
  alias KeenAuthDemo.KeenUser
  alias KeenAuthDemo.Database.DbContext

  require Logger

  def get(conn, _params) do
    if Config.get_storage().current_user(conn) do
      redirect(conn, to: "/")
    else
      render(conn, "new.html")
    end
  end

  def post(conn, %{"tenant_code" => tenant_code, "username" => username, "password" => password}) do
    # todo: verify user login params
    case verify_user(tenant_code, username, password) do
      {:ok, user} ->
        with {:ok, conn} <- Config.get_storage().store(conn, :email, %{user: user, token: %{}}) do
          redirect(conn, to: default_redirect_path(conn, tenant_code))
        end

      {:error, :invalid_combination} ->
        conn
        |> put_status(401)
        |> put_flash(:error, "Invalid username/password combination")
        |> render("new.html")
    end
  end

  def sign_out(conn, %{"tenant_code" => tenant_code}) do
    conn
    |> Config.get_storage().delete()
    |> redirect(to: default_redirect_path(conn, tenant_code))
  end

  defp verify_user(tenant_code, username, password) do
    with {:ok, [user]} <- DbContext.get_user_verification(tenant_code, username) do
      if Bcrypt.verify_pass(password, user.password_hash) do
        {:ok, KeenUser.from_user(user)}
      else
        {:error, :invalid_combination}
      end
    else
      {:ok, []} ->
        Bcrypt.no_user_verify()
        {:error, :invalid_combination}
      error ->
        Bcrypt.no_user_verify()
        error
    end
  end

  def default_redirect_path(conn, tenant_code) do
    Routes.page_path(conn, :index, tenant_code)
  end
end
