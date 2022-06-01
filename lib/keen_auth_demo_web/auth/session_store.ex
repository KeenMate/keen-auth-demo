defmodule KeenAuthDemoWeb.Auth.SessionStore do
  @behaviour KeenAuth.Storage

  alias KeenAuth.Storage.Session

  import Plug.Conn, only: [put_session: 3, delete_session: 2]

  @impl true
  def store(conn, provider, %{user: user, token: tokens} = oauth_response) do
    {:ok, conn} = Session.store(conn, provider, oauth_response)

    conn =
      conn
      |> put_refresh_token(tokens["refresh_token"])

    {:ok, conn}
  end

  @impl true
  def current_user(conn) do
    Session.current_user(conn)
  end

  @impl true
  def delete(conn) do
    conn
    |> Session.delete()
    |> put_refresh_token()
  end

  def put_refresh_token(conn, refresh_token \\ nil)

  def put_refresh_token(conn, nil) do
    delete_session(conn, :refresh_token)
  end

  def put_refresh_token(conn, refresh_token) do
    put_session(conn, :refresh_token, refresh_token)
  end
end
