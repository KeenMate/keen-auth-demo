defmodule KeenAuthDemoWeb.Auth.SessionStore do
  @behaviour KeenAuth.Storage

  alias KeenAuth.Storage.Session

  import Plug.Conn, only: [put_session: 3, delete_session: 2]

  @impl true
  def get_roles(conn) do

  end

  @impl true
  defdelegate store(conn, provider, oauth_response), to: Session

  @impl true
  defdelegate current_user(conn), to: Session

  @impl true
  defdelegate authenticated?(conn), to: Session

  @impl true
  defdelegate get_access_token(conn), to: Session

  @impl true
  defdelegate get_id_token(conn), to: Session

  @impl true
  defdelegate get_refresh_token(conn), to: Session

  @impl true
  defdelegate delete(conn), to: Session

end
