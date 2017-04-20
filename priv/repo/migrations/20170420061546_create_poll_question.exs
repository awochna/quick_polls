defmodule QuickPolls.Repo.Migrations.CreateQuickPolls.Poll.Question do
  use Ecto.Migration

  def change do
    create table(:questions, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :text, :text
      add :choices, {:array, :text}
      add :poll_id, references(:polls, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:questions, [:poll_id])
  end
end
