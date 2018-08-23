defmodule ExCakning.Query do
  alias ExCakning.Config

  def put_api_key(params) when is_map(params) do
    params
    |> Enum.into(%{})
    |> Map.merge(%{token: Config.api_key()})
  end

  @spec encode(nil) :: nil
  def encode(nil), do: nil

  @spec encode(list(any)) :: String.t()
  def encode(params) when is_list(params) do
    params
    |> Enum.into(%{})
    |> encode()
  end

  @spec encode(map()) :: String.t()
  def encode(params) when is_map(params) do
    params
    |> Enum.map(fn
      {k, v} when is_list(v) or is_map(v) -> encode_nested([k], v)
      {k, v} -> encode_kv(k, v)
    end)
    |> List.flatten()
    |> Enum.join("&")
  end

  defp encode_nested(keys, value) do
    value
    |> Enum.map(fn
      {k, v} when is_list(v) or is_map(v) -> encode_nested(keys ++ [k], v)
      {k, v} -> encode_kv(keys ++ [k], v)
      v when is_list(v) or is_map(v) -> encode_nested(keys ++ [nil], v)
      v -> encode_kv(keys ++ [nil], v)
    end)
  end

  defp encode_kv(keys, value) when is_list(keys), do: "#{encode_key(keys)}=#{to_url_safe(value)}"

  defp encode_kv(key, value), do: "#{to_url_safe(key)}=#{to_url_safe(value)}"

  defp encode_key(keys) when is_list(keys) do
    [head | tail] = Enum.map(keys, &to_url_safe/1)
    children = tail |> Enum.map(&"[#{&1}]") |> Enum.join()
    "#{head}#{children}"
  end

  defp to_url_safe(str) when is_binary(str), do: URI.encode_www_form(str)
  defp to_url_safe(str) when is_binary(str), do: URI.encode_www_form(str)
  defp to_url_safe(str), do: str |> to_string() |> URI.encode_www_form()
end
