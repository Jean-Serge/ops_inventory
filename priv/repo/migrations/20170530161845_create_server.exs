defmodule OpsInventory.Repo.Migrations.CreateServer do
  use Ecto.Migration

  def change do
    create table(:servers) do
      add :name, :string
      add :ip_address, :string
      add :id_digital_ocean, :integer, unique: true

      timestamps()
    end

    create unique_index(:servers, [:id_digital_ocean])
  end
end
