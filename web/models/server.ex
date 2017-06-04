defmodule OpsInventory.Server do
  use OpsInventory.Web, :model

  alias OpsInventory.{
    Server,
    Repo
  }

  # defstruct %{}

  schema "servers" do
    field :name, :string
    field :ip_address, :string
    field :id_digital_ocean, :integer, unique: true

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :ip_address, :id_digital_ocean])
    |> validate_required([:name, :ip_address])
    |> unique_constraint(:id_digital_ocean)
  end

  def insert_or_update_droplet(droplet) do
    case Repo.get_by(Server, id_digital_ocean: droplet.id_digital_ocean) do
      nil     ->   struct(Server, droplet)
      server  -> server
    end
    |> Server.changeset
    |> Repo.insert_or_update!
  end
end
