defmodule ExCakning.Response.Product do
  @types %{
    id: :integer,
    slug: :string,
    name: :string,
    description: :string,
    vendor_name: :string,
    category_name: :string,
    variants: :any,
    total_sell: :integer,
    total_stock: :integer,
    image: :string,
    province_name: :string,
    city_name: :string,
    fav_count: :integer,
    unit: :string,
    weight: :integer,
    price: :integer,
    price_formated: :string,
    sku: :string,
    sku_live: :string,
    status: :string,
    not_warranty: :string,
    warranty_months: :integer,
    warranty_status: :integer,
    warranty_type: :string
  }

  defstruct Map.keys(@types)

  def cast(rows) when is_list(rows), do: Enum.map(rows, &cast/1)
  def cast(row) when is_map(row), do: do_cast(row)

  defp do_cast(row) do
    Enum.reduce(@types, %__MODULE__{}, fn {key, type}, product ->
      %{product | key => cast_field(type, row[to_string(key)])}
    end)
  end

  defp cast_field(type, value)
  defp cast_field(:string, value), do: to_string(value)
  defp cast_field(:integer, value) when is_binary(value), do: String.to_integer(value)
  defp cast_field(:integer, value), do: value
  defp cast_field(:any, value), do: value
end
