use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :ops_inventory, OpsInventory.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :ops_inventory, OpsInventory.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "test",
  password: "test",
  database: "ops_inventory_test",
  hostname: "localhost",
  port: 5554,
  pool: Ecto.Adapters.SQL.Sandbox
