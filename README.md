- [Backstage](#backstage)
- [Goals](#goals)
- [CQRWho?](#cqrwho)
  - [The Script](#the-script)
- [Architecture](#architecture)
- [TODO](#todo)
- [Installation](#installation)

> On Broadway, the backstage is buzzing with activity.
>
> The actors are stepping onto the stage.
>
> The crew is pulling the curtains, aiming the lights.
>
> The band is moving air.
>
> The director is observant and diligent.
>
> The audience is transfixed.
>
> The show must go on, even when mistakes are made.

# Backstage

Backstage is a [CQRS & Event Sourcing](#cqrwho) framework optimized for Elixir applications to take advantage of concurrency and parallelism on the BEAM.

# Goals

1. Make Event Sourcing more approachable for CRUD developers.
2. Leverage battle-tested packages from the Elixir ecosystem for maximum performance.
3. Establish strong patterns for busy development teams.

# CQRWho?

**Command & Query Responsibility Segregation**, or CQRS, is a pattern for separating how data is written to and read from a system. The benefits of this pattern include:

- More control over database performance based on an application's read/write demands
- Richer data history, useful for auditing, debugging, and AI model training
- Clearer boundaries for data as it propagates through a system

## The Script

For developers familiar with the **Create Read Update Delete** pattern, or CRUD, CQRS may be intimidating at first. We're already seeing new terms and acronyms, which may be unfamiliar. To understand the value of Event Sourcing and CQRS without digging into the specifics, let's think about a script for a Broadway play.

Whether it's authored by a single person or a result of collaboration, a script describes

# Architecture

Backstage uses the [Broadway](https://hexdocs.pm/broadway/introduction.html) package to run highly concurrent and robust data pipelines.

| Component     | Description                                                |
| ------------- | ---------------------------------------------------------- |
| Command       | Instructs system to change its state                       |
| Event         | Represents a historical change in the system's state       |
| Router        | Routes commands to aggregates                              |
| Aggregate     | Performs business logic, updates state for a system entity |
| Event Handler | Executes custom code for matching events                   |
| Projection    | Persists system state to a readable format                 |

# TODO

- [ ] Investigate Broadway as an Event Broker
- [ ] Build EventProducer
- [ ] Investigate protocols for commands, events, and other components

# Installation

TODO
