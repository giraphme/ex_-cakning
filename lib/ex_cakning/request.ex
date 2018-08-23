defmodule ExCakning.Request do
  use HTTPoison.Base
  alias ExCakning.{Config, Query, Response}

  def fetch(method, url, params \\ [])

  def fetch(:get, url, params) do
    query_string =
      params
      |> Enum.into(%{})
      |> Query.put_api_key()
      |> Query.encode()

    "#{url}?#{query_string}"
    |> get()
    |> Response.cast()
  end

  def fetch(method, url, params) do
    # Unfortunately, we have to use query string even if we use POST method :(
    # On top of that we have to put API token on query string. >-<
    query_string =
      params
      |> Enum.into(%{})
      |> Query.put_api_key()
      |> Query.encode()

    method
    |> request("#{url}?#{query_string}")
    |> Response.cast()
  end

  def process_url(url) do
    Config.base_url() <> url
  end

  def process_request_headers(headers) do
    headers
    |> Keyword.put(:"Content-Type", "application/json")
  end

  def process_request_body(body) when is_map(body) or is_list(body) do
    Jason.encode!(body)
  end

  def process_request_body(body), do: body

  def process_response_body(body) do
    case Jason.decode(body) do
      {:ok, json} -> json
      {:error, _} -> body
    end
  end
end
