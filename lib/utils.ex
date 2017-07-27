defmodule OpsInventory.Utils do

    @moduledoc """
    Convert the given map to use keyword instead of string.
    """
    def string_to_atom(m) when is_map(m) do
        m
        |> Enum.map(&string_to_atom/1)
        |> Map.new # Build a new map
    end

    def string_to_atom(l) when is_list(l), do: Enum.map l, &string_to_atom/1
    def string_to_atom({k, v}), do: {String.to_atom(k), string_to_atom(v)}
    def string_to_atom(s), do: s
end
