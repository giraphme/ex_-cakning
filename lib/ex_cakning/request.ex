defmodule ExCakning.Request do
  use HTTPotion.Base
  alias ExCakning.Config

  def process_url(url) do
    Config.base_url() <> url
  end

  def process_request_headers(headers) do
    headers
    |> Keyword.put(:"Content-Type", "application/json")
  end

  def process_response_body(body) do
    Jason.decode!(body)
  end
end
