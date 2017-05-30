# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :ops_inventory,
  ecto_repos: [OpsInventory.Repo]

# Configures the endpoint
config :ops_inventory, OpsInventory.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "oTl8nWl/mC1S9WXTx1RVbrplAvfnZ7fBJdn+jsgqxQz8pQv1OsWb6dk+ZBs6l5yr",
  render_errors: [view: OpsInventory.ErrorView, accepts: ~w(html json)],
  pubsub: [name: OpsInventory.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
