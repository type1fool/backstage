defmodule Backstage.EventProducer do
  require Logger
  use GenStage

  def start_link(opts \\ []) do
    opts = Keyword.put_new(opts, :name, __MODULE__)
    GenStage.start_link(__MODULE__, opts)
  end

  @impl GenStage
  def init(enum) do
    {:producer, Stream.cycle(enum)}
  end

  @impl GenStage
  def handle_demand(demand, stream) do
    events = Stream.take(stream, demand) |> Enum.to_list()

    if Enum.empty?(events) do
      GenStage.async_info(self(), :stop)

      {
        :noreply,
        [],
        stream,
        :hibernate
      }
    else
      {
        :noreply,
        events,
        Stream.drop(stream, demand)
      }
    end
  end

  @impl GenStage
  def handle_info(:stop, state) do
    Logger.warning(stopping_event_producer: {__MODULE__, state})
    {:stop, :normal, state}
  end
end
