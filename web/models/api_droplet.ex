defmodule OpsInventory.ApiDroplet do
    import OpsInventory.DigitalOcean

    def to_insert do
        list_droplets()
        |> Enum.map(fn(droplet) ->
            %{
                id: droplet.id,
                name: droplet.name,
                ip_address: List.first(droplet.networks.v4).ip_address
            }
        end)        
    end

    def all_status do
        list_droplets()
        |> Enum.map(fn(droplet) ->
            %{
                id: droplet.id,
                status: droplet.status
            }
        end)
    end
end