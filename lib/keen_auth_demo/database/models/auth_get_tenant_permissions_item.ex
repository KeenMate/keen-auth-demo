# This code has been auto-generated
# Changes to this file will be lost on next generation

defmodule KeenAuthDemo.Database.Models.AuthGetTenantPermissionsItem do
  @fields [
    :user_id,
    :groups,
    :permissions
  ]

  @enforce_keys @fields

  defstruct @fields

  @type t() :: %KeenAuthDemo.Database.Models.AuthGetTenantPermissionsItem{}
end