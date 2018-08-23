defmodule ExCakningTest do
  use ExUnit.Case
  alias ExCakning.Response

  describe "ExCakning.products_all" do
    test "It should return {:ok, %ExCakning.Response{}}" do
      assert {:ok, %Response{}} = ExCakning.products_all()
    end
  end

  describe "ExCakning.products" do
    test "It should return {:ok, %ExCakning.Response{}}" do
      assert {:ok, %Response{}} = ExCakning.products()
    end
  end

  @sample_product_id 29766
  describe "ExCakning.product_detail" do
    test "It should return {:ok, %ExCakning.Response{}}" do
      assert {:ok, %Response{}} = ExCakning.product_detail(@sample_product_id)
    end
  end
end
