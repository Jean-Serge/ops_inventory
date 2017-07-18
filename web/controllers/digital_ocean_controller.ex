defmodule OpsInventory.DigitalOceanController do
    use OpsInventory.Web, :controller
    
    require Logger

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
        |> Enum.each(fn(droplet) ->
            match = Enum.find(status_list, fn(%{id: id}) -> id === droplet.droplet_id end)
            
            case match do
                nil ->
                    Logger.info "No droplet matching id #{droplet.droplet_id} on Digital Ocean account"
                %{ status: s} ->
                    Logger.info "Status found for droplet #{droplet.droplet_id}"
                    payload = Map.put(droplet, :status, s)
                    OpsInventory.Endpoint.broadcast("droplets:status", "new_status", payload)
            end
        end)
    end
end