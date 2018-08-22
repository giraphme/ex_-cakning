defmodule ExCakning.Config do
  @type t :: %__MODULE__{
          base_url: String.t(),
          api_key: String.t()
        }

  defstruct [
    :base_url,
    :api_key
  ]

  @spec new() :: __MODULE__.t()
  def new do
    %__MODULE__{}
    |> put_base_url()
    |> put_api_key()
  end

  @default_base_url "https://api.cakning.com/"
  defp put_base_url(%__MODULE__{} = config) do
    put_in(
      config.base_url,
      case Application.get_env(:ex_cakning, :base_url) do
        nil -> @default_base_url
        {:system, env_name} -> System.get_env(env_name)
        base_url when is_binary(base_url) -> base_url
      end
    )
  end

  defp put_api_key(%__MODULE__{} = config) do
    put_in(
      config.api_key,
      case Application.get_env(:ex_cakning, :api_key) do
        {:system, env_name} -> System.get_env(env_name)
        api_key when is_binary(api_key) -> api_key
      end
    )
  end
end
