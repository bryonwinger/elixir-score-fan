defmodule ScoreFan.SyncProcessor do
  use GenServer
  require Logger

  @schedule_ms Application.get_env(:score_fan_app, :sync_seconds) * 1000

  def start_link(state) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  @impl true
  def init(state) do
    schedule_work()
    {:ok, state}
  end

  @impl true
  def handle_info(:perform_sync, state) do
    Logger.debug(fn -> "#{__MODULE__} beginning new data sync" end)

    # Refresh the database with any new information from the data source APIs
    _teams = ScoreFan.ExternalAPI.NBA.reload_teams()

    # Reschedule self
    schedule_work()
    {:noreply, state}
  end

  defp schedule_work do
    Process.send_after(self(), :perform_sync, @schedule_ms)
  end
end
