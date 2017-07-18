defmodule OpsInventory.Repo.Migrations.CreateDropletTable do
  use Ecto.Migration

  def change do
    create table(:droplets) do
      add :droplet_id, :integer, null: false
      add :server_id, references(:servers, on_delete: :delete_all)

      timestamps()
    end

    # Drop the column will drop all associated index
    alter table(:servers) do
      remove :id_digital_ocean
    end

    create unique_index(:droplets, [:droplet_id])
    create unique_index(:droplets, [:server_id])
  end
end