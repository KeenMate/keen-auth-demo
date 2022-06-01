defmodule KeenAuthDemoWeb.Auth.Mappers.AzureAD do
  @behaviour KeenAuth.UserMapper

  @impl true
  def map(:aad, user) do
    %KeenAuth.User{
      id: user["oid"],
      username: user["preferred_username"],
      display_name: user["name"],
      email: user["preferred_username"]
    }
  end
end
