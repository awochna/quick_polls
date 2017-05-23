defmodule QuickPolls.Poll.Question do
  use Ecto.Schema

  alias Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "questions" do
    field :choices, {:array, :string}
    field :text, :string
    field :poll_id, :binary_id

    timestamps()
  end

  def create_changeset(struct, params \\ %{}) do
    struct
    |> Changeset.cast(params, ~w(text choices))
    |> Changeset.validate_required([:text, :choices])
  end
end
