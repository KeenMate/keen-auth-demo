# This code has been auto-generated
# Changes to this file will be lost on next generation

defmodule KeenAuthDemo.Database.Models.GetJournalMsgsItem do
  @fields [
    :journal_id,
    :created,
    :created_by,
    :data_group,
    :data_object_id,
    :user_id,
    :msg
  ]

  @enforce_keys @fields

  defstruct @fields

  @type t() :: %KeenAuthDemo.Database.Models.GetJournalMsgsItem{}
end