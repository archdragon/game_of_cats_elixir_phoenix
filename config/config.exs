# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :game_of_cats, GameOfCats.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base: "lzeqp7u/C59jRAAZQSoxKdr7j1A9NAo6jeKn920/9njcqzzIktdCqhtGrx4d+wIW",
  render_errors: [accepts: ~w(html json)],
  pubsub: [name: GameOfCats.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# Configure phoenix generators
config :phoenix, :generators,
  migration: true,
  binary_id: false

config :phoenix, :template_engines,
  slim: PhoenixSlime.Engine,
  slime: PhoenixSlime.Engine

config :guardian, Guardian,
  issuer: "GmeOfCats",
  ttl: { 30, :days },
  secret_key: "y/Zr+SozkIiyEZxI1YXReWpblJn+LGQAIJpqRHOmHUCIPHBRWvNUI7lBLdYlUU1t",
  serializer: GameOfCats.GuardianSerializer
