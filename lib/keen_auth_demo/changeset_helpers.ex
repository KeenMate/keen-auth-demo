defmodule KeenAuthDemo.ChangesetHelpers do
  import Ecto.Changeset

  @spec validate_atleast_one_required(Ecto.Changeset.t(), [atom()]) :: Ecto.Changeset.t()
  def validate_atleast_one_required(changeset, fields) do
    satisfied =
      fields
      |> Stream.map(&get_field(changeset, &1))
      |> Stream.filter(fn val -> val not in [nil, 0, ""] end)
      |> Enum.any?()

    if satisfied do
      changeset
    else
      Enum.reduce(fields, changeset, fn field, changeset ->
        other_fields = Enum.filter(fields, & &1 != field)
        add_error(changeset, field, "This or other fields: (#{Enum.join(other_fields, ", ")})")
      end)
    end
  end
end
