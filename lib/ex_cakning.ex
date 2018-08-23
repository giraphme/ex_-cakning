defmodule ExCakning do
  alias ExCakning.Request

  @spec products_all(list(any)) :: {:ok, String.t()} | {:error, String.t()}
  def products_all(params \\ []) do
    Request.fetch(:get, "products_all", params)
  end

  @spec products(list(any)) :: {:ok, String.t()} | {:error, String.t()}
  def products(params \\ []) do
    Request.fetch(:post, "products", params)
  end

  @spec product_detail(integer, list(any)) :: {:ok, String.t()} | {:error, String.t()}
  def product_detail(id, params \\ []) do
    Request.fetch(:post, "product_detail", params ++ [id: id])
  end
end
