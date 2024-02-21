defmodule Billboard.Trip do
  @enforce_keys [:id, :title, :body, :description, :tags, :trip_type, :path]
  defstruct [:id, :title, :body, :description, :tags, :trip_type, :path]

  def build(filename, attrs, body) do
    path = Path.rootname(filename)
    [trip_type, id] = path |> Path.split() |> Enum.take(-2)
    struct!(__MODULE__, [id: id, body: body, trip_type: String.to_atom(trip_type), path: path <> ".html"] ++ Map.to_list(attrs))
  end
end
