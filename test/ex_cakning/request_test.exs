defmodule ExCakning.RequestTest do
  use ExUnit.Case
  alias ExCakning.Request

  describe "ExCakning.Request.process_url/1" do
    test "It sholuld use Config.base_url()" do
      assert Request.process_url("some_endpoint") === "https://cakning.com/some_endpoint"
    end
  end

  describe "ExCakning.Request.process_request_headers/1" do
    test "It sholuld add Content-Type: application/json" do
      assert Request.process_request_headers([]) === ["Content-Type": "application/json"]
    end
  end

  describe "ExCakning.Request.process_response_body/1" do
    test "It sholuld parse response to a map" do
      assert Request.process_response_body("{\"key\": \"value\"}") === %{"key" => "value"}
    end
  end
end
