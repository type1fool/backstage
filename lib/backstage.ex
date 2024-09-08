defmodule Backstage do
  use Broadway
  alias Backstage.EventProducer
  alias Broadway.Message

  @default_config [
    name: __MODULE__,
    producer: [
      module: {EventProducer, []},
      transformer: {__MODULE__, :transform, []}
    ],
    processors: [
      default: [concurrency: 10]
    ],
    batchers: [
      default: [concurrency: 2, batch_size: 5]
    ]
  ]

  def start_link(opts \\ []) do
    Broadway.start_link(__MODULE__, Keyword.merge(@default_config, opts))
  end

  def transform(event, _opts) do
    %Message{
      data: event,
      acknowledger: {__MODULE__, :ack_id, :ack_data}
    }
  end

  @impl Broadway
  def handle_message(_processor, message, _context) do
    message
  end

  @impl Broadway
  def handle_batch(_batcher, messages, _batch_info, _context) do
    messages
  end

  @impl Broadway
  def handle_failed(messages, _context) do
    messages
  end

  def ack(:ack_id, _successful, _failed) do
    :ok
  end
end
