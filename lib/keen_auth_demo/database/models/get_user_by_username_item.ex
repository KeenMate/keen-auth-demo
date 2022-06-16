# This code has been auto-generated
# Changes to this file will be lost on next generation

defmodule KeenAuthDemo.Database.Models.GetUserByUsernameItem do
  @fields [
    :user_id,
    :code,
    :uuid,
    :username,
    :email,
    :display_name,
    :roles,
    :permissions
  ]

  @enforce_keys @fields

  defstruct @fields

  @type t() :: %KeenAuthDemo.Database.Models.GetUserByUsernameItem{}
end