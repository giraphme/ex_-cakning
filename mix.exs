defmodule ExCakning.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex_cakning,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      description: "API wrapper of cakning.com for Elixir.",
      package: [
        maintainers: ["Tamaki Maeda"],
        licenses: ["MIT"],
        links: %{
          "Cakning" => "https://cakning.com/pusat-bantuan/dokumentasi-api"
        }
      ],
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger, :httpoison]
    ]
  end

  defp deps do
    [
      {:httpoison, "~> 1.2"},
      {:jason, "~> 1.1"},
      {:power_assert, "~> 0.1.1", only: :test},
      {:mix_test_watch, "~> 0.5", only: :dev, runtime: false},
      {:dialyxir, "~> 1.0.0-rc.3", only: :dev, runtime: false},
      {:ex_doc, "~> 0.16", only: :dev, runtime: false}
    ]
  end
end
