defprotocol Backstage.Interface.Authorization do
  @moduledoc """
  A mechanism for controlling access to some or all commands in an application.

  # Order of Operations

  Authorization checks should be performed before dispatching commands.

  1. An actor submits a form or presses a button via a Web or API interface.
  2. The application confirms the user is allowed to trigger the command.
  3. If allowed, the command is dispatched upon successful validation.

  # Authorization Types

  This protocol supports a wide variety of access controls. An application may perform checks based on the actor's role, a relation to another entity affected by the command, permissions assigned to the actor, and any logic that can be written into a function.

  | Authorization Type | Supported? |
  | --- | --- |
  | Global Role-Based Access Control | Yes |
  | Organization-Level Role-Based Access Control | Yes |
  | Relationship-Based Access Control | Yes |
  | Attribute-Based Access Control | Yes |
  """
  alias Backstage.Command

  @type response :: :yes | {:no, term()}

  @doc """
  For a given command, perform any necessary checks to provide a response.
  """
  @spec allow?(command :: Command.t(), actor :: struct(), opts :: Keyword.t()) :: response()
  def allow?(command, actor, opts)
end
