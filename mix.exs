defmodule Nasa.MixProject do
  use Mix.Project

  def project do
    [
      app: :nasa,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Nasa, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
      {:ex_gram, "~> 0.6.0"},
      {:httpoison, "~> 1.5"},
      {:jason, "~> 1.1"}
    ]
  end
end
