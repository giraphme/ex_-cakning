defmodule ExCakning do
  alias ExCakning.Request

  def products_all(params \\ []) do
    Request.fetch(:get, "products_all", params)
  end

  def products(params \\ []) do
    Request.fetch(:post, "products", params)
  end

  def product_detail(id, params \\ []) do
    Request.fetch(:post, "product_detail", params ++ [id: id])
  end
end
