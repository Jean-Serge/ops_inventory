defmodule OpsInventory.DigitalOceanController do
    use OpsInventory.Web, :controller

    alias OpsInventory.{
        Droplet,
        ApiDroplet
    }

    @doc """
    Fetch all droplets from Digital Ocean API and upsert them into the database.
    """
    def synchronize(conn, _params) do
        Droplet.synchronize()

        json conn, %{ok: true}
    end

    @doc """
    Fetch the status of all droplet using the Digital Ocean API.

    TODO : Find a realtime way of tracking server downtime.
    """
    def check_droplet_availability do
        status_list = ApiDroplet.all_status

        Droplet.all_status
        |> Enum.map(fn(droplet) ->
            status = 
                Enum.find(status_list,
                    fn(%{ id: id }) -> id === droplet.droplet_id end
                ).status
            
            payload = Map.put(droplet, :status, status)
            OpsInventory.Endpoint.broadcast("droplets:status", "new_status", payload)
        end)
    end
end
