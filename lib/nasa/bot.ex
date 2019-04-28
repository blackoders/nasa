defmodule Nasa.Bot do
  @bot_name :nasaapi_bot

  import Nasa.Api
  alias ExGram, as: Bot
  use ExGram.Bot, name: @bot_name
  require Logger

  middleware(ExGram.Middleware.IgnoreUsername)

  def handle({:command, "echo", %{text: t}}, cnt) do
    answer(cnt, t)
  end

  def handle({:command, "picture_of_the_day", %{chat: %{id: chat_id}}}, cnt) do
    Bot.send_message(chat_id, "Processing...")
    case picture_of_the_day() do
      {:ok, picture_data} -> 
        %{title: title, date: date, explanation: explanation, url: image} = Jason.decode!(picture_data, keys: :atoms)
        IO.inspect image, label: "THE IMAGE"
      image = HTTPoison.get!(image)
      Bot.send_photo(cnt, {:file, image})
      {:error, error_message} ->
          answer(cnt, error_message)
    end

  end

  def handle({:command, "start", _}, cnt) do
    answer(cnt, "Welcome to NasaApiBot")
  end

  def handle({:bot_message, from, msg}, %{name: name}) do
    Logger.info("Message from bot #{inspect(from)} to #{inspect(name)}  : #{inspect(msg)}")
    :hi
  end

  def handle(msg, _) do
    Logger.warn("Unknown message #{inspect(msg)}")
  end

  def handle({:command, "help", _}, cnt) do
    commands = """
      /start - welcome NASA BOT. Happy to serve :)

      /echo - Just an echo use like /echo I LOVE YOU

      /asteroid_stats - Get the Near Earth Object data set totals.

      /asteroids - Retieve a paginated list of Near Earth Objects.

      /closest_asteroids - Retrieve a list of Asteroids based on their closest approach date to Earth.

      /eonet_categories - EONET (Earth Observatory Natural Event Tracker) categories.

      /eonet_events - Most recent EONET (Earth Observatory Natural Event Tracker) events.

      /eonet_layers - A reference to a specific web service (e.g., WMS, WMTS) that can be used to produce imagery of a particular NASA data parameter. Layers are mapped to categories within EONET in order to provide a category-specific list of layers (e.g., the 'Volcanoes' category is mapped to layers that can provide imagery in true color, SO2, aerosols, etc.).  epic_earth_imagery - Retrieve a paginated list of Near Earth Objects.

      /earth_assets - The date-times and asset names for available imagery for a supplied location.

      /earth_imagery - The Landsat 8 image for the supplied location and date. The response will include the date and URL to the image that is closest to the supplied date.

      /mars_rover_photos - Image data gathered by NASA's Curiosity, Opportunity, and Spirit rovers on Mars and make it more easily available to other developers, educators, and citizen scientists.

      /picture_of_the_day - The APOD imagery and associated metadata so that it can be repurposed for other applications. In addition, if the concept_tags parameter is set to True, then keywords derived from the image explanation are returned.  single_asteroid - Lookup a specific Asteroid based on its NASA JPL small body (SPK-ID) ID.

    """

    answer(cnt, commands)
  end

end
