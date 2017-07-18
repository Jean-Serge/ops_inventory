defmodule OpsInventory.Utils do
    
    @doc """
    Convert the given map to use keyword instead of string.
    """
    def string_to_atom(m) when is_map(m) do
        Enum.map(m, fn(elt) ->
            case elt do
                {k, v} -> {String.to_atom(k), string_to_atom(v)}
                x      -> string_to_atom(x)
            end
        end)
        |> Map.new # Build a new map
    end

    def string_to_atom(l) when is_list(l), do: Enum.map l, &string_to_atom/1
    def string_to_atom(s), do: s
end