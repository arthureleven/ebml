# ebml
Keyword-based parser for ebml data

#### Table of contents
* [Installation](#installation)
* [Usage](#usage)

## Installation
```elixir
def deps do
  [{:ebml, "~> 0.1"}]
end
```

## Usage
```elixir
elements =
  File.read!("path/to/file")
  |> EBML.decode() # This will return a list of keywords
```

To access a specific element in the list, use `Keyword.get/3`. To access multiple elements, use `Keyword.get_values/2`:
```elixir
segment = Keyword.get(elements, :Segment) # Returns Segment Information
blocks =
  segment
  |> Keyword.get(:Cluster)
  |> Keyword.get_values(:SimpleBlock) # Returns all SimpleBlock values
```

Technical information is available [here](https://www.matroska.org/technical/elements.html).