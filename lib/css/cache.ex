defmodule Css.Cache do
  use GenServer

  # Callbacks
  def start_link(default) do
    GenServer.start_link(__MODULE__, default, name: Css.Cache)
  end

  @impl true
  def init(stack) do
    {:ok, stack}
  end

  @impl true
  def handle_call({:get_or_set, key, value}, _from, state) do
    result = case GenServer.call(self(), {:get, key}) do
      nil ->
        GenServer.cast(self(), {:set, key, value})
        value

      value ->
        value
    end

    {:reply, result, state}
  end

  @impl true
  def handle_call({:get, key}, _from, state) do
    {:reply, Map.get(state, key), state}
  end

  @impl true
  def handle_cast({:set, key, item}, state) do
    {:noreply, Map.put(state, key, item)}
  end
end
