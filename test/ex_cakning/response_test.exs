defmodule ExCakning.ResponseTest do
  use ExUnit.Case
  alias ExCakning.Response

  @module HTTPoison.Response
  @mock_product %{
    "category_name" => "Some cateogry",
    "city_name" => "Kota Makassar",
    "description" => "Product description",
    "fav_count" => 10,
    "id" => 29766,
    "image" => "https://image.cakning.com//media/products/omv-****.png",
    "name" => "Some product name",
    "not_warranty" => nil,
    "price" => 12000,
    "price_formated" => "Rp.12.000",
    "province_name" => "Sulawesi Selatan",
    "sku" => "VCSM100",
    "sku_live" => "2018-07-06 11:01:34",
    "slug" => "this-is-a-good-item",
    "status" => "publish",
    "total_sell" => 0,
    "total_stock" => 1000,
    "unit" => "PCS",
    "variants" => [],
    "vendor_name" => "Good vendor",
    "warranty_months" => 0,
    "warranty_status" => 0,
    "warranty_type" => "toko",
    "weight" => 100
  }

  describe "ExCakning.Response.cast/1" do
    test "It should return {:ok, %ExCakning.Response{}} when receive a response of products" do
      assert {:ok, %Response{} = response} =
               Response.cast(
                 {:ok,
                  %@module{
                    status_code: 200,
                    body: %{"total" => 1, "rows" => [@mock_product]}
                  }}
               )

      assert response.total == 1
      assert [%Response.Product{} = product] = response.rows
      assert product.id == @mock_product["id"]
    end

    test "It should return {:error, %EkCaking.Response.Error{}} when request failure" do
      assert {:error, %Response.Error{}} =
               Response.cast({:error, %@module{status_code: 403, body: "Forbidden"}})
    end

    test "It should return {:error, %EkCaking.Response.Error{}} when request was success but response has a error" do
      assert {:error, %Response.Error{}} =
               Response.cast(
                 {:ok,
                  %@module{
                    status_code: 200,
                    body: %{"status" => "error", "message" => "The product is not found"}
                  }}
               )
    end
  end
end
