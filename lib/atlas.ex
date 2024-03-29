defmodule Billboard.Atlas do
  use NimblePublisher,
    build: Billboard.Trip, from: "./atlas/**/*.md", as: :trips,
    highlighters: [:makeup_elixir, :makeup_erlang]

  def trips, do: @trips
  def walks, do: by_trip_type(:walks)
  def drives, do: by_trip_type(:drives)

  defp by_trip_type(trip_type) do
    @trips
    |> Enum.filter(& &1.trip_type == trip_type)
    |> Enum.sort_by(& &1.id)
  end
end
