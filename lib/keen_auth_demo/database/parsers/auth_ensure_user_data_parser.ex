# This code has been auto-generated
# Changes to this file will be lost on next generation

defmodule KeenAuthDemo.Database.Parsers.AuthEnsureUserDataParser do
  @moduledoc """
  This module contains functions to parse output from db's stored procedure's calls
  """

  require Logger

  @spec parse_auth_ensure_user_data_result({:ok, Postgrex.Result.t()} | {:error, any()}) ::
          {:ok,
           [
             KeenAuthDemo.Database.Models.AuthEnsureUserDataItem.t()
           ]}
          | {:error, any()}
  def parse_auth_ensure_user_data_result({:error, reason} = err) do
    Logger.error("Error occured while calling stored procedure",
      procedure: "auth_ensure_user_data",
      reason: inspect(reason)
    )

    err
  end

  def parse_auth_ensure_user_data_result({:ok, %Postgrex.Result{rows: rows}}) do
    Logger.debug("Parsing successful response from database")

    parsed_results =
      rows
      |> Enum.map(&parse_auth_ensure_user_data_result_row/1)

    # todo: Handle rows that could not be parsed

    successful_results =
      parsed_results
      |> Enum.filter(&(elem(&1, 0) == :ok))
      |> Enum.map(&elem(&1, 1))

    Logger.debug("Parsed response")

    {:ok, successful_results}
  end

  def parse_auth_ensure_user_data_result_row([user_id, user_data_id]) do
    {
      :ok,
      %KeenAuthDemo.Database.Models.AuthEnsureUserDataItem{
        user_id: user_id,
        user_data_id: user_data_id
      }
    }
  end

  def parse_auth_ensure_user_data_result_row(_unknown_row) do
    Logger.warn("Found result row that does not have valid number of columns")

    {:error, :einv_columns}
  end
end