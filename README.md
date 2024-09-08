- [🚧 Backstage 🚧](#-backstage-)
- [Goals](#goals)
- [CQRWho?](#cqrwho)
  - [The Script](#the-script)
  - [Business Value](#business-value)
- [Architecture](#architecture)
- [TODO](#todo)
- [Installation](#installation)

---

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

---

# 🚧 Backstage 🚧

Backstage is a [CQRS & Event Sourcing](#cqrwho) framework optimized for Elixir applications to take advantage of concurrency and parallelism on the BEAM.

> 👨‍🎤 This repository is currently in an **experimentation phase**. It is not intended to be used in any critical production systems.
>
> See [hex.pm](https://hex.pm/packages?search=cqrs&sort=recent_downloads) for a list of available CQRS packages.

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

Whether it's authored by a single person or a result of collaboration, a script provides an order of operations for a play. This includes scene-setting and context, lines for characters, music cues, stage direction, and other technical details. This metaphor illustrates how a script provide a repeatable set of written instructions for recreating a performance.

Imagine we only had the last page of a script.

- What would we know?
- What questions could we answer?

With traditional CRUD database models, we effectively find ourselves with the last page of the script. Our understanding of the system is limited to the data available in its current state. We have limited ability to answer questions which were not anticipated as the data model was designed or as it evolved. While external tools like logging and tracing allow engineers to perform debugging, these tools are not intended nor ideal for business data analysis.

## Business Value

The greatest value delivered by Event Sourcing & CQRS patterns may be its ability to provide answers to unforeseen questions as a business grows and evolves in surprising ways. For engineers focussed on developer operations, these patterns allow more granular control over write and read performance since incoming data (events) is stored separately from data used by application queries (projections).

# Architecture

Backstage uses the [Broadway](https://hexdocs.pm/broadway/introduction.html) package to run highly concurrent and robust data pipelines.

| Component     | Description                                                | Example                 |
| ------------- | ---------------------------------------------------------- | ----------------------- |
| Command       | Instructs system to change its state                       | `%AddTicket{}` struct   |
| Event         | Represents a historical change in the system's state       | `%TicketAdded{}` struct |
| Router        | Routes commands to aggregates                              | `TicketRouter` module   |
| Aggregate     | Performs business logic, updates state for a system entity | `Tickets` module        |
| Event Handler | Executes custom code for matching events                   | `TicketHandler` module  |
| Projection    | Persists system state to a readable format                 | `tickets` DB table      |

# TODO

- [ ] Investigate Broadway as an Event Broker
- [ ] Build EventProducer
- [ ] Investigate protocols for commands, events, and other components

# Installation

TODO
