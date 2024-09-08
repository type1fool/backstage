defprotocol Backstage.Command do
  @moduledoc """
  A mechanism for ensuring consistent validation and dispatching of command structs.
  """

  @doc """
  Performs data validation before building a command struct and dispatching to the router.
  """
  @spec dispatch(params :: map()) :: term()
  def dispatch(params)

  @doc """
  Performs data validation before building a command without dispatching to the router.

  This is useful for providing real-time feedback to users on web interfaces, for example. `Ecto.Changeset` is useful for performing these validations.

  ## What to Validate

  In traditional CRUD applications, an Ecto Changeset sometimes performs database checks for uniqueness and may even include some business requirements. When validating a command, it's best to cast data to expected types and leave business rule checks to the `Backstage.Aggregate`.
  """
  @spec validate(params :: map()) :: {:ok, struct()} | {:error, term()}
  def validate(params)

  @doc """
  Supports testing with example data to support unit, property, and other tests. A factory implementation also provides a layer of documentation for other developers.

  These factories may be implemented alongside the command struct code or in the `:test` environment depending on your team's preferences.
  """
  @spec factory(params :: Keyword.t()) :: struct()
  def factory(params)
end
