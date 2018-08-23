defmodule ExCakning.Response do
  defstruct [:total, :rows, :raw_response]

  def cast({:ok, %_{status_code: 200, body: %{} = body} = response}) do
    case cast_body(body) do
      {:ok, %{total: total, rows: rows}} ->
        {:ok, %__MODULE__{total: total, rows: rows, raw_response: response}}

      {:error, message} ->
        to_error(status_code: 200, message: message, raw_response: response)
    end
  end

  def cast({_, %_{status_code: status_code, body: body} = response}) do
    to_error(status_code: status_code, message: body, raw_response: response)
  end

  defp cast_body(%{"status" => "error", "message" => message}) do
    {:error, message}
  end

  # TODO: cast rows to Product struct
  defp cast_body(%{"rows" => rows, "total" => total}) when is_list(rows) do
    {:ok, %{total: total, rows: __MODULE__.Product.cast(rows)}}
  end

  # TODO: check single product response and cast to struct
  defp cast_body(row) when is_map(row) do
    {:ok, %{total: 1, rows: __MODULE__.Product.cast(row)}}
  end

  defp to_error(args \\ []) do
    {:error, struct(__MODULE__.Error, Enum.into(args, %{}))}
  end
end
