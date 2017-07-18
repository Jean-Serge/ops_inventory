defmodule OpsInventory.UtilsTest do
    use ExUnit.Case, async: true

    import OpsInventory.Utils

    test "convert simple map" do
        assert string_to_atom(%{ "name" => "toto" }) === %{ name: "toto" }
    end

    test "convert simple list" do
        before = ["toto", "tata"]
        expected = before

        assert string_to_atom(before) === expected
    end

    test "convert nested map" do
        before = %{ "name" => %{ "real_name" => "toto" }}
        expected = %{ name: %{ real_name: "toto" }}

        assert string_to_atom(before) === expected
    end
    
end