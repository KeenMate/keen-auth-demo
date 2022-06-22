defmodule KeenAuthDemo.NewUser do
  use Ecto.Schema
  import Ecto.Changeset

  import KeenAuthDemo.ChangesetHelpers

  embedded_schema do
    field :id
    field :username
    field :password
    field :display_name
    field :email
    field :birthdate, type: :date
  end

  @allowed_fields [:id, :username, :password, :display_name, :email, :birthdate]

  # defstruct @keys

  def new_changeset(new_user, params \\ %{}) do
    {new_user, @changeset_fields}
    |> cast(params, @allowed_fields)
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
