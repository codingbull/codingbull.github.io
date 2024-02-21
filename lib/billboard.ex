defmodule Billboard do
  use Phoenix.Component
  import Phoenix.HTML
  alias Billboard.Atlas

  def trip(assigns) do
    ~H"""
    <.layout>
      <%= raw @trip.body %>
    </.layout>
    """
  end

  def index(assigns) do
    ~H"""
    <.layout>
      <h1>Scott Went There</h1>
      <h2>Walks</h2>
      <ul>
        <li :for={walk <- @walks}>
          <a href={walk.path}> <%= walk.title %> </a>
        </li>
      </ul>
      <h2>Drives</h2>
      <ul>
        <li :for={drive <- @drives}>
          <a href={drive.path}> <%= drive.title %> </a>
        </li>
      </ul>
    </.layout>
    """
  end

  def layout(assigns) do
    ~H"""
    <html>
      <body>
        <%= render_slot(@inner_block) %>
      </body>
    </html>
    """
  end

  @output_dir "./docs"
  File.mkdir_p!(@output_dir)

  def build() do
    walks = Atlas.walks()
    drives = Atlas.drives()

    render_file("index.html", index(%{walks: walks, drives: drives}))

    for trip <- Atlas.trips do
      dir = Path.dirname(trip.path)
      if dir != "." do
        File.mkdir_p!(Path.join([@output_dir, dir]))
      end
      render_file(trip.path, trip(%{trip: trip}))
    end

    :ok
  end

  def render_file(path, rendered) do
    safe = Phoenix.HTML.Safe.to_iodata(rendered)
    output = Path.join([@output_dir, path])
    File.write!(output, safe)
  end

end
