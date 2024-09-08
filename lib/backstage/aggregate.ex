defprotocol Backstage.Aggregate do
  @moduledoc """
  An entity used to enforce business rules and ensure consistent state.

  When implementing an `Aggregate`, consider what rules are important to the business for the given entity. For example, this is where you may enforce email uniqueness or age restrictions for users if it is important to your business.
  """
  alias Backstage.Command

  @type aggregate :: struct()
  @type event :: struct()

  @doc """
  Validates the incoming command meets business requirements, if any.

  Returns an event struct or an error tuple.
  """
  @spec handle_command(command :: Command.t(), state :: term()) :: event() | {:error, term()}
  def handle_command(command, state)

  @doc """
  Modifies `Aggregate` state based on some or all data from the event.

  Returns an updated aggregate struct.
  """
  @spec handle_event(event :: struct(), state :: term()) :: aggregate()
  def handle_event(event, state)
end
