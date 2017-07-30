defmodule OpsInventory.Server do
  @moduledoc """
  Represents a Server.

  It is the base entity in this application.
  """

  use OpsInventory.Web, :model

  alias OpsInventory.{
    Server,
    Droplet,
    Repo
  }

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

  def all do
    Repo.all (
      from s in Server,
      join: d in assoc(s, :droplet),
      preload: [droplet: d]
    )
  end
end
