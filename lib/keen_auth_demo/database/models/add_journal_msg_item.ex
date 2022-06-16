# This code has been auto-generated
# Changes to this file will be lost on next generation

defmodule KeenAuthDemo.Database.Models.AddJournalMsgItem do
  @fields [
    :created,
    :created_by,
    :journal_id,
    :tenant_id,
    :data_group,
    :data_object_id,
    :event_id,
    :user_id,
    :message,
    :data_payload
  ]

  @enforce_keys @fields

  defstruct @fields

  @type t() :: %KeenAuthDemo.Database.Models.AddJournalMsgItem{}
end