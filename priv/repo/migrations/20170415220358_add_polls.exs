defmodule QuickPolls.Repo.Migrations.AddPolls do
  use Ecto.Migration

  def change do
    create table(:polls) do
      add :name, :string
      add :user_id, references(:users)

      timestamps()
    end
  end
end
