defmodule OpsInventory.Droplet do
    use OpsInventory.Web, :model

    alias OpsInventory.{
        Repo,
        Server,
        Droplet,
        ApiDroplet
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

    def synchronize do
        ApiDroplet.to_insert()
        |> Enum.map(&upsert/1)
    end

    def create_from_server(server, droplet_id) do
        %Droplet{
            droplet_id: droplet_id,
            server_id: server.id
        }
        |> changeset
        |> Repo.insert!
    end

    def upsert(%{ name: name, id: id, ip_address: ip_address}) do
        server = %{
            name: name,
            ip_address: ip_address
        }

        case Repo.get_by(Droplet, droplet_id: id) do
            nil     ->
                struct(Server, server)
                |> Server.changeset
                |> Repo.insert!
                |> Droplet.create_from_server(id)
            result  ->
                Repo.get!(Server, result.server_id)
                |> Server.changeset(server)
                |> Repo.update!
        end
    end

    def all_status do
        (
            from d in Droplet,
            select: %{
                server_id: d.server_id,
                droplet_id: d.droplet_id
            }
        )
        |> Repo.all
    end
end