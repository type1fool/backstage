defmodule Backstage.MixProject do
  use Mix.Project

  def project do
    [
      app: :backstage,
      version: "0.0.1",
      elixir: "~> 1.17",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      dialyzer: dialyzer(),
      description: description(),
      docs: docs(),
      license: "Apache-2.0",
      source_url: "https://github.com/type1fool/backstage"
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:broadway, "~> 1.1"},
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.4", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.34.2", only: [:dev], runtime: false}
    ]
  end

  defp description do
    """
    Backstage is a CQRS & Event Sourcing framework optimized for Elixir applications to take advantage of concurrency and parallelism on the BEAM.
    """
  end

  defp dialyzer do
    [
      plt_file: {:no_warn, "priv/plts/backstage.plt"}
    ]
  end

  defp docs do
    [
      main: "Backstage",
      extras: ~w(README.md)
    ]
  end
end
