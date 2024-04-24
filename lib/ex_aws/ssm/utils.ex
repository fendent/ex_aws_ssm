defmodule ExAws.SSM.Utils do
  import ExAws.Utils, only: [camelize_keys: 1]

  def maybe_add_max_results(query_params, input_params) do
    if input_params[:max_results],
      do: Map.put(query_params, "MaxResults", input_params[:max_results]),
      else: query_params
  end

  def maybe_add_next_token(query_params, input_params) do
    if input_params[:next_token],
      do: Map.put(query_params, "NextToken", input_params[:next_token]),
      else: query_params
  end

  def maybe_add_key_id(query_params, input_params) do
    if input_params[:key_id],
      do: Map.put(query_params, "KeyId", input_params[:key_id]),
      else: query_params
  end

  def merge_opts(data, opts) do
    opts
    |> normalize_opts()
    |> Map.merge(data)
  end

  def normalize_opts({k, v}, acc) do
    Map.put(acc, to_lower_camel_case(k), v)
  end

  def normalize_opts(opts) do
    opts
    |> Enum.into(%{})
    |> camelize_keys()
    |> Enum.reduce(%{}, &normalize_opts/2)
  end

  def to_lower_camel_case(string) do
    {first, rest} = String.split_at(string, 1)

    String.downcase(first) <> rest
  end
end
