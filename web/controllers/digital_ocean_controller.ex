defmodule OpsInventory.DigitalOceanController do
    use OpsInventory.Web, :controller

    import OpsInventory.DigitalOcean

    alias OpsInventory.Server

    def synchronize_servers do
        list_droplets()
        |> Enum.map(fn(droplet) ->
            Server.insert_or_update_droplet(%{
                name: droplet.name,
                id_digital_ocean: droplet.id,
                ip_address: List.first(droplet.networks.v4).ip_address
            })
        end)
    end
end