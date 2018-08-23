# ExCakning

[API documentation of Cakning](https://cakning.com/pusat-bantuan/dokumentasi-api)  
[hexdocs.pm](https://hexdocs.pm/ex_cakning)

## Installation

In your `mix.exs`

```elixir
def deps do
  [
    {:ex_cakning, "~> 0.1.0"}
  ]
end
```

In your `config/config.exs`

```elixir
config :ex_cakning, :api_key, "PUT YOUR API KEY"

# OR

config :ex_cakning, :api_key, {:system, "CAKNING_API_KEY"}
```

## Usage

```elixir
iex > ExCakning.products_all()
{:ok, %ExCakning.Response{...}}
iex > ExCakning.products()
{:ok, %ExCakning.Response{...}}
iex > ExCakning.product_detail(123)
{:ok, %ExCakning.Response{...}}
```

## License

This project is licensed under the terms of the MIT license, see LICENSE.
