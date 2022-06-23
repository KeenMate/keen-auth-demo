defmodule KeenAuthDemo.KeenUser do
  use Ecto.Schema

  # import KeenAuthDemo.ChangesetHelpers
  # import Ecto.Changeset

  # @keys [:id, :username, :display_name, :email, :birthdate]

  embedded_schema do
    field :user_id
    field :username
    field :code
    field :uuid
    field :display_name
    field :email
    field :birthdate, :date
  end

  def from_new_user(new_user) do
    %__MODULE__{
      user_id: new_user.user_id,
      username: new_user.username,
      code: new_user.code,
      uuid: new_user.uuid,
      display_name: new_user.display_name,
      email: new_user.email
    }
  end
end
