defmodule OpsInventory.Scheduler do
    use GenServer

    import OpsInventory.DigitalOceanController, only: [check_droplet_availability: 0]

    def start_link, do: GenServer.start_link(__MODULE__, %{})

    def init(state) do
        schedule_droplets_status()
        {:ok, state}
    end

    def handle_info(:droplet_status, state) do
        check_droplet_availability()
        schedule_droplets_status()
        {:noreply, state}
    end
    
    defp schedule_droplets_status do
        Process.send_after(self(), :droplet_status, 10 * 1000)
    end
end