defmodule KeenAuthDemo.NewUser do
  use Ecto.Schema
  import Ecto.Changeset

  import KeenAuthDemo.ChangesetHelpers

  @primary_key false

  embedded_schema do
    field :username
    field :password
    field :display_name
    field :email
    field :birthdate, :date
  end

  @allowed_fields [:username, :password, :display_name, :email, :birthdate]

  def new_changeset(new_user, params \\ %{}) do
    cast(new_user, params, @allowed_fields)
  end

  def validate_changeset(new_user, params) do
    new_changeset(new_user, params)
    |> validate_password()
    |> validate_atleast_one_required([:username, :email])
  end

  defp validate_password(changeset) do
    changeset
    |> validate_required(:password)
    |> validate_length(:password, min: 6)
  end
end
