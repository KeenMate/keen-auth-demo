defmodule KeenAuthDemoWeb.Auth.Processor do
  @behaviour KeenAuth.Processor

  alias KeenAuthPermissions.Processor, as: PermissionsProcessor

  import Plug.Conn, only: [put_session: 3]

  require Logger

  @impl true
  def process(conn, provider, response) do
    Logger.debug("Processing OAuth response for #{provider}", response: inspect response)

    {:ok, conn, response} = PermissionsProcessor.process(conn, provider, response)

    {:ok, put_session(conn, :oauth_response, response), response}
  end
end
