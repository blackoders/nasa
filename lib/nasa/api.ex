defmodule Nasa.Api do
  @host "https://api.nasa.gov"
  @api_key Application.get_env(:nasa, :nasa_api_key)

  require Logger

  def make_request(url, method \\ :get) do
    IO.inspect(url)
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
    [{"ConentType", "application/json"}]
  end

  def append_api(path) do
    Path.join(@host, [path, "?api_key=#{@api_key}"])
  end

  def append_today(url) do
    today = Date.utc_today()
    "#{url}&date=#{today}"
  end

  def append_start_date(url, start_date) do
    "#{url}&start_date=#{start_date}"
  end

  def append_end_date(url, end_date) do
    "#{url}&end_date=#{end_date}"
  end

  def append_lat(url, latitude) do
    "#{url}&lat= #{latitude}"
  end

  def append_lon(url, longitude) do
    "#{url}&lon=#{longitude}"
  end

  def picture_of_the_day do
    path = "planetary/apod"
    url = append_api(path)
    make_request(url)
  end

  def asteroids(start_date, end_date) do
    path = "neo/rest/v1/feed"

    url =
      path
      |> append_api()
      |> append_start_date(start_date)
      |> append_end_date(end_date)

    make_request(url)
  end

  def asteroid_stats do
    path = "neo/rest/v1/neo/"
    url = append_api(path)
    make_request(url)
  end

  # def closest_asteroids do
  #   path =
  #   url = append_api(path)
  #   make_request(url)
  #
  # end
  # def eonet_categories do
  #   path=
  #   url = append_api(path)
  #   make_request(url)
  #
  # end
  # def eonet_events do
  #   path=
  #   url = append_api(path)
  #   make_request(url)
  #
  # end
  # def eonet_layers do
  #   path=
  #   url = append_api(path)
  #   make_request(url)
  #
  # end
  def earth_assets do
    path = "planetary/earth/assets "
    url = append_api(path)
    make_request(url)
  end

  # def mars_rover_photos do
  #
  # end
  def earth_imagery(latitude, longitude) do
    path = "planetary/earth/imagery "

    url =
      path
      |> append_api()
      |> append_lat(latitude)
      |> append_lon(longitude)
      |> append_today()

    IO.inspect(url)
    make_request(url)
  end
end
