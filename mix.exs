defmodule EBML.MixProject do
  use Mix.Project

  def project do
    [
      app: :ebml,
      version: "0.1.0",
      elixir: "~> 1.17",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      name: "ebml",
      description: "Keyword-based parser for ebml data",
      source_url: "https://github.com/arthureleven/ebml",
      homepage_url: "https://github.com/arthureleven/ebml",
      package: package(),
      deps: deps()
    ]
  end

  def package do
    [
      name: :ebml,
      licenses: ["MIT"],
      files: [
        "lib",
        "README*",
        "LICENSE*",
        ".formatter.exs",
        "mix.exs"
      ],
      maintainers: ["Arthur da Costa"],
      links: %{
        "GitHub" => "https://github.com/arthureleven/ebml"
      }
    ]
  end

  defp deps do
    [
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false}
    ]
  end
end
