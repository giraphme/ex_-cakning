defmodule ExCakning.QueryTest do
  use ExUnit.Case
  alias ExCakning.{Query, Config}

  describe "ExCakning.Query.put_api_key/1" do
    test "It sholuld change to string" do
      assert Query.put_api_key(%{}) === %{token: Config.api_key()}
    end
  end

  describe "ExCakning.Query.encode/1" do
    test "It sholuld change to string" do
      assert Query.encode(%{
               name: "sample item=",
               page: 1,
               courier: [1, "POS INDONESIA"],
               some_map: %{a: "value value", b: 1}
             }) ==
               "courier[]=1&courier[]=POS+INDONESIA&name=sample+item%3D&page=1&some_map[a]=value+value&some_map[b]=1"
    end
  end
end
