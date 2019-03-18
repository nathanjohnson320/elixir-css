defmodule Css.MixProject do
  use Mix.Project

  def project do
    [
      app: :css,
      description: description(),
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      elixirc_paths: elixirc_paths(Mix.env()),
      package: package()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:xxhash, "~> 0.2.1"},
      {:css_colors, "~> 0.2.0"}
    ]
  end

  def description() do
    "An elm-css like package for elixir that helps with styling/updating Phoenix Live Views"
  end

  defp package() do
    [
      name: "elixir-css",
      files: ~w(lib priv .formatter.exs mix.exs README* readme* LICENSE*
                license* CHANGELOG* changelog* src),
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/nathanjohnson320/elixir-css"}
    ]
  end
end
