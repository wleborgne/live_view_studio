defmodule LiveViewStudioWeb.LightLive do
  use LiveViewStudioWeb, :live_view

  def mount(_params, _session, socket) do
    socket = assign(socket, :brightness, 10)

    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
    <h1>Front Porch Light</h1>
      <div id="light">
        <div class="meter">
          <span style="width: <%= @brightness %>%">
            <%= @brightness %>%
          </span>
        </div>

        <button phx-click="off">
          <img src="images/light-off.svg">
        </button>

        <button phx-click="down">
          <img src="images/down.svg">
        </button>

        <button phx-click="up">
          <img src="images/up.svg">
        </button>

        <button phx-click="on">
          <img src="images/light-on.svg">
        </button>

        <button phx-click="random">
          Light Me Up!
        </button>
      </div>
    """
  end

  def handle_event("on", _metadata, socket) do
    socket = assign(socket, :brightness, 100)

    {:noreply, socket}
  end

  def handle_event("off", _metadata, socket) do
    socket = assign(socket, :brightness, 0)

    {:noreply, socket}
  end

  def handle_event("up", _metadata, socket) do
    socket = update(socket, :brightness, &min(&1 + 10, 100))

    {:noreply, socket}
  end

  def handle_event("down", _metadata, socket) do
    socket = update(socket, :brightness, &max(&1 - 10, 0))

    {:noreply, socket}
  end

  def handle_event("random", _metadata, socket) do
    socket = update(socket, :brightness, fn _ -> :rand.uniform(100) end)

    {:noreply, socket}
  end
end
