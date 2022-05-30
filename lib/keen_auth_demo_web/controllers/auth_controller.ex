defmodule KeenAuthDemoWeb.AuthController do
  use KeenAuth.AuthController

  alias KeenAuth.Session

  @impl true
  def callback(conn, %{"provider" => provider} = opts) do
    {_, params} = Map.split(opts, ["provider"])

    with {:ok, %{user: user, token: token} = result} <- KeenAuth.AuthController.make_callback(String.to_existing_atom(provider), params, get_session(conn, :session_params)) do
      conn
      |> Session.new(KeenAuth.AuthController.normalize(conn, user), token)
      |> put_session(:oauth_response, result)
      |> redirect(to: "/")
    end
  end
end
