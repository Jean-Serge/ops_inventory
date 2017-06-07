defmodule OpsInventory.Droplet do
    use OpsInventory.Web, :model

    alias OpsInventory.{
        Repo,
        Server,
        Droplet
    }

    schema "droplets" do
        field :droplet_id, :integer, unique: true

        belongs_to :server, Server

        timestamps()
    end

    def changeset(struct, params \\ %{}) do
        struct
        |> cast(params, [:droplet_id, :server_id])
        |> validate_required([:droplet_id, :server_id])
        |> unique_constraint(:droplet_id)
        |> unique_constraint(:server_id)
    end

    def create_from_server(server, droplet_id) do
        %Droplet{
            droplet_id: droplet_id,
            server_id: server.id
        }
        |> changeset
        |> Repo.insert!
    end

    def upsert(droplet) do
        server = %{
            name: droplet.name,
            ip_address: List.first(droplet.networks.v4).ip_address
        }

        case Repo.get_by(Droplet, droplet_id: droplet.id) do
            nil     ->
                struct(Server, server)
                |> Server.changeset
                |> Repo.insert!
                |> Droplet.create_from_server(droplet.id)
            result  ->
                Repo.get!(Server, result.server_id)
                |> Server.changeset(server)
                |> Repo.update!
        end
    end
end