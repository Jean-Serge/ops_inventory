defmodule OpsInventory.Utils do

    defmacrop is_enum(x) do
        quote do: is_map(unquote(x)) or is_list(unquote(x))
    end

    def string_to_atom(s) when (not is_enum(s)), do: s
    def string_to_atom(l) when is_list(l) do
        Enum.map l, fn(elt) -> string_to_atom(elt) end
    end

    @doc """
    Convert the given map to use keyword instead of string.
    """
    def string_to_atom(map) do
        Enum.map(map, fn(elt) ->
            case elt do
                {k, v} -> {String.to_atom(k), string_to_atom(v)}
                x      -> string_to_atom(x)
            end
        end)
        |> Map.new # Build a new map
    end
end