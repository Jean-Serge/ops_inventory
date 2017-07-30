defmodule OpsInventory.DigitalOcean do
    @moduledoc """
    Wrapper around Digital Ocean API.
    """

    use HTTPoison.Base

    alias OpsInventory.Utils

    @endpoint Application.get_env(:ops_inventory, DigitalOcean)[:endpoint]
    @token Application.get_env(:ops_inventory, DigitalOcean)[:token]

    defp process_url(url), do: @endpoint <> url

    defp process_request_headers(headers) do
        [
            {"Content-Type",  "application/json"},
            {"Authorization", "Bearer #{@token}"} | headers
        ]
    end

    defp process_response_body(body) do
        body
        |> Poison.decode!
        |> Utils.string_to_atom
    end

    @doc """
    Fetch the list of all existing Droplets.

    Return the list of all droplet's name.
    """
    def list_droplets do
        case get("/droplets") do
            {:ok, response} ->
                response.body.droplets
            {:error, _}     ->
                []
        end
    end

    @doc """
    Fetch a specific droplet given its ID.

    Return the requested droplet.
    """
    def get_by_id(id) do
        case get("/droplets/#{id}") do
            {:ok, response} ->
                response.body.droplet
            {:error, _}     ->
                %{}
        end
    end
end
