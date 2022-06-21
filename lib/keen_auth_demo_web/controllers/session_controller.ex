defmodule KeenAuthDemoWeb.SessionController do
  use KeenAuthDemoWeb, :controller

  alias KeenAuth.Config
  alias KeenAuthDemo.KeenUser

  def new(conn, _params) do
    if Config.get_storage().current_user(conn) do
      redirect(conn, to: "/")
    else
      render(conn, "new.html")
    end
  end

  def create(conn, %{"username" => username, "password" => password}) do
    # todo: verify user login params
    case verify_user(username, password) do
      {:ok, user} ->
        conn
        |> Config.get_storage().store(:email, %{user: user})
        |> redirect(to: "/")

      {:error, :invalid_password} ->
        conn
        |> put_status(401)
        |> put_flash(:error, :invalid_password)
        |> render("new.html")
    end
  end

  def delete(conn, _params) do
    conn
    |> Config.get_storage().delete()
    |> redirect(to: "/")
  end

  defp verify_user(username, _password) do
    user =
      %KeenUser{
        username: username,
        display_name: username
      }

    {:ok, user}
  end
end
