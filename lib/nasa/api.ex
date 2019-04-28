defmodule Nasa.Api do
  @host "https://api.nasa.gov"
  @api_key "0Oh58q6T7fVu0KG1RmZUuBcrkCAuHLbdhfIh3lTx"

  require Logger

  def picture_of_the_day do
    make_request("planetary/apod")
  end

  def make_request(path, method \\ :get) do
    url = make_url(path)

    headers = headers()
    http_response = HTTPoison.request(method, url, "", headers, [])

    case http_response do
      {:ok, %{body: body}} ->
        Logger.info("Request Succes!")
        {:ok, body}

      {:error, reason} ->
        Logger.error("Failed Process Request")
        Logger.warn("Error reason \n" <> inspect(reason))
        {:error, "Sorry :( Unable to serve you \n Please Try again"}
    end
  end

  def headers do
    []
  end

  def make_url(path) do
    Path.join(@host, [path, "?api_key=#{@api_key}"])
  end
end
