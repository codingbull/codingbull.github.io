defmodule Billboard do
  use Phoenix.Component
  import Phoenix.HTML

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
      <h2>Trips</h2>
      <ul>
        <li :for={trip <- @trips}>
          <a href={trip.path}> <%= trip.title %> </a>
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
end
