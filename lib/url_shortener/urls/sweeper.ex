defmodule UrlShortener.Urls.Sweeper do
  use GenServer

  def child_spec(opts) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, [opts]}
    }
  end

  def start_link(opts) do
    GenServer.start_link(__MODULE__, [opts], opts)
  end

  def init(opts) do
    schedule_sweep(opts)
    {:ok, opts}
  end

  def handle_info(:sweep, opts) do
    UrlShortener.Urls.delete_expired()
    schedule_sweep(opts)
    {:noreply, opts}
  end

  defp schedule_sweep(opts) do
    sweep_every = (opts[:sweep_every] || Application.fetch_env!(:url_shortener, :sweep_every)) * 1000
    Process.send_after(self(), :sweep, sweep_every)
  end
end
