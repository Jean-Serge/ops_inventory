defmodule OpsInventory.Repo.Migrations.CreateServer do
  use Ecto.Migration

  def change do
    create table(:servers) do
      add :name, :string
      add :ip_address, :string

      timestamps()
    end

  end
end
