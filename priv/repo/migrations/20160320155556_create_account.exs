defmodule GameOfCats.Repo.Migrations.CreateAccount do
  use Ecto.Migration

  def change do
    create table(:accounts) do
      add :name, :string
      add :encrypted_password, :string

      timestamps
    end

    create unique_index(:accounts, [:name])
  end
end
