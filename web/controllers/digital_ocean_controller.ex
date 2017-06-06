defmodule OpsInventory.DigitalOceanController do
    use OpsInventory.Web, :controller

    import OpsInventory.DigitalOcean

    alias OpsInventory.Server

    def synchronize_droplets(conn, _params) do
        list_droplets()
        |> Enum.map(fn(droplet) ->
            Server.insert_or_update_droplet(%{
                name: droplet.name,
                id_digital_ocean: droplet.id,
                ip_address: List.first(droplet.networks.v4).ip_address
            })
        end)

        json conn, %{ok: true}
    end

    def check_droplet_availability do
        droplets =
            list_droplets()
            |> Enum.map(fn(droplet) ->
                %{
                    id: droplet.id,
                    status: droplet.status
                }
            end)

        (
            from s in Server,
            where: not is_nil(s.id_digital_ocean),
            select: %{
                id: s.id,
                id_digital_ocean: s.id_digital_ocean
            }
        )
        |> Repo.all
        |> Enum.map(fn(server = %{ id_digital_ocean: id_digital_ocean }) ->
            status = 
                Enum.find(droplets,
                    fn(%{ id: id }) -> id === id_digital_ocean end
                ).status
            
            Map.put(server, :status, status)
        end)
    end
end