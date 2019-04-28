defmodule Nasa do
  use Application
  require Logger

  def start(_type, _args) do
    children = [
       ExGram, # This will setup the Registry.ExGram,
  {Nasa.Bot, [method: :polling, token: "849042187:AAFpkn3wFEDW-ZchIEbNJXToRtHLr373W4A"]}
    ]

    opts = [strategy: :one_for_one, name: Nasa]
    case Supervisor.start_link(children, opts) do
      {:ok, _} = ok -> 
        Logger.info("Starting NasaBot")
        ok
      error -> 
        Logger.error("Error Starting NasaBot")
        error
    end
  end
end
