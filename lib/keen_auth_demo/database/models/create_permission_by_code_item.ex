# This code has been auto-generated
# Changes to this file will be lost on next generation

defmodule KeenAuthDemo.Database.Models.CreatePermissionByCodeItem do
  @fields [
    :created,
    :created_by,
    :modified,
    :modified_by,
    :permission_id,
    :is_assignable,
    :title,
    :code,
    :full_code,
    :node_path,
    :has_children,
    :full_title
  ]

  @enforce_keys @fields

  defstruct @fields

  @type t() :: %KeenAuthDemo.Database.Models.CreatePermissionByCodeItem{}
end