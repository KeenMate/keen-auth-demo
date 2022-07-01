# This code has been auto-generated
# Changes to this file will be lost on next generation

defmodule KeenAuthDemo.Database.Models.UpdateUserGroupItem do
  @fields [
    :group_id,
    :title,
    :is_active,
    :is_assignable,
    :modified,
    :modified_by
  ]

  @enforce_keys @fields

  defstruct @fields

  @type t() :: %KeenAuthDemo.Database.Models.UpdateUserGroupItem{}
end