defmodule OpsInventory.Server do
  use OpsInventory.Web, :model

  schema "servers" do
    field :name, :string
    field :ip_address, :string

    has_one :droplet, Droplet

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :ip_address])
    |> validate_required([:name, :ip_address])
  end
end
