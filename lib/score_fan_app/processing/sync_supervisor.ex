defmodule ScoreFan.SyncSupervisor do
  use Supervisor

  def start_link(arg) do
    Supervisor.start_link(__MODULE__, arg, name: __MODULE__)
  end

  @impl true
  def init(_arg) do
    children =
      case Application.get_env(:score_fan_app, :env) do
        :test ->
          []

        _ ->
          [
            {ScoreFan.SyncProcessor, []}
          ]
      end

    Supervisor.init(children, strategy: :one_for_one)
  end
end
