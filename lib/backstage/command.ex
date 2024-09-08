defmodule Backstage.Command do
  @moduledoc """
  A mechanism for ensuring consistent validation, dispatching, and testing of command structs.

  ## Right-Sizing Commands

  One challenge with the CQRS pattern is knowing how much data to put into a command. Coming from CRUD, it may be tempting to include dozens of fields with commands that mirror `create` & `update` operations. In CQRS, a good practice is to think about how data changes in more granular terms.

  ### Example

  Let's think of a `User` schema in a traditional CRUD application with the following fields:

  - `id`
  - `username`
  - `email`
  - `status`
  - `confirmed_at`
  - `inserted_by`
  - `updated_by`
  - `has_one:preferences`

  With CRUD, we would pass `username`, `email`, and `inserted_by` fields to `Users.create/1`, and let the application or database generate the `id` and `status` fields. To update the user, we may pass several of the fields to `Users.update/2`.

  If we're only updating the `username`, though, we may find that we're reusing a single changeset that performs validation on multiple fields which have not changed, or we may opt to create several changesets for this type of granular change. Not to mention, we have to contend with associations and embedded schemas.

  In the world of CQRS, we tend to break changes into smaller - sometimes much smaller - collections of data.

  ```
  %AddUser{username: "janet", email: "janet@example.com"}
  %ChangeUserUsername{user_id: "user-1", username: "queenjanet"}
  %ActivateUser{user_id: "user-1"}
  %SetUserGithub{user_id: "queenjanetcodez"}
  %LockUser{user_id: "user-1"}
  %DeleteUser{user_id: "user-1"}
  ```

  These granular changes can be connected directly to smaller user actions at the interface layer. Instead of presenting a large form, potentially with several parts spread over tabs or pages, we can enable per-field editing where it makes sense. Users can trigger these commands simply by changing a field on a page, or by clicking a `save` button after making a change.

  Finding the right balance of data for any given command can be a challenge. When in doubt, collaborate with stakeholders to make an informed decision that will serve the business.  In the real world, an application may contain some commands which are larger than others, all based on the business and technical requirements determined by the team.
  """

  @typedoc """
  A struct containing data required by a `Backstage.Aggregate`.
  """
  @type t :: struct()

  @doc """
  Performs data validation before building a command struct and dispatching to the router.
  """
  @callback dispatch(params :: map()) :: term()

  @doc """
  Performs data validation before building a command without dispatching to the router.

  This is useful for providing real-time feedback to users on web interfaces, for example. `Ecto.Changeset` is useful for performing these validations.

  ## What to Validate

  In traditional CRUD applications, an Ecto Changeset sometimes performs database checks for uniqueness and may even include some business requirements. When validating a command, it's best to cast data to expected types and leave business rule checks to the `Backstage.Aggregate`.
  """
  @callback validate(params :: map()) :: {:ok, struct()} | {:error, term()}

  @doc """
  Supports testing with example data to support unit, property, and other tests. A factory implementation also provides a layer of documentation for other developers.

  These factories may be implemented alongside the command struct code or in the `:test` environment depending on your team's preferences.
  """
  @callback factory(params :: Keyword.t()) :: struct()
end
