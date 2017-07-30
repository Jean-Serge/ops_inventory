defmodule OpsInventory.DropletChannel do
    @moduledoc """
    Channel definition for communication about droplets.
    """

    use OpsInventory.Web, :channel

    intercept ["new_status"]

    def join("droplets:status", _msg, socket), do: {:ok, socket}
    def join("droplets:" <> _room, _msg, _s), do: {:error, %{reason: "unauthorized"}}

    def handle_in("new_status", payload, socket), do: broadcast! socket, "new_status", payload
    def handle_out("new_status", payload, socket) do
        push socket, "new_status", payload
        {:noreply, socket}
    end
end
