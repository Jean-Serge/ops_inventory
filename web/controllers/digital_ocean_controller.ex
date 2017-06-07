defmodule OpsInventory.DigitalOceanController do
    use OpsInventory.Web, :controller

    import OpsInventory.DigitalOcean

    alias OpsInventory.Droplet

    @doc """
    Fetch all droplets from Digital Ocean API and upsert them into the database.
    """
    def synchronize(conn, _params) do
        list_droplets()
        |> Enum.map(&Droplet.upsert/1)

        json conn, %{ok: true}
    end

    @doc """
    Fetch the status of all droplet using the Digital Ocean API.

    TODO : Find a realtime way of tracking server downtime.
    """
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
            from d in Droplet,
            select: %{
                server_id: d.server_id,
                droplet_id: d.droplet_id
            }
        )
        |> Repo.all
        |> Enum.map(fn(droplet) ->
            IO.inspect droplet

            status = 
                Enum.find(droplets,
                    fn(%{ id: id }) -> id === droplet.droplet_id end
                ).status
            
            Map.put(droplet, :status, status)
        end)
    end
end