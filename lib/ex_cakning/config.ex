defmodule ExCakning.Config do
  @spec base_url() :: String.t()
  @default_base_url "https://cakning.com/"
  def base_url() do
    case Application.get_env(:ex_cakning, :base_url) || @default_base_url do
      {:system, env_name} -> System.get_env(env_name)
      base_url when is_binary(base_url) -> base_url
    end
  end

  @spec api_key() :: String.t()
  @default_api_key {:system, "CAKNING_API_KEY"}
  def api_key() do
    case Application.get_env(:ex_cakning, :api_key) || @default_api_key do
      {:system, env_name} -> System.get_env(env_name)
      api_key when is_binary(api_key) -> api_key
    end
  end
end
