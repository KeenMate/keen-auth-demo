defmodule KeenAuthDemo.KeenUser do
  alias Ecto.Changeset

  import KeenAuthDemo.ChangesetHelpers

  @keys [:id, :username, :display_name, :email, :birthdate]

  @changeset_fields %{
    id: :string,
    username: :string,
    display_name: :string,
    email: :string,
    birthdate: :date
  }

  defstruct @keys

  def new(params \\ %{}) do
    {%__MODULE__{}, @changeset_fields}
    |> Changeset.cast(params, @keys)
  end

  @spec validate(Ecto.Changeset.t()) :: Ecto.Changeset.t()
  def validate(changeset) do
    changeset
    |> validate_atleast_one_required([:username, :email])
  end
end
