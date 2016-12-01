# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :faq,
  home_name: System.get_env("FAQ_APP_NAME") || "FAQ",
  ecto_repos: [Faq.Repo]

# Configures the endpoint
config :faq, Faq.Endpoint,
  url: [host: "localhost"],
  secret_key_base: System.get_env("APP_SECRET"),
  render_errors: [view: Faq.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Faq.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# %% Coherence Configuration %%   Don't remove this line
#
config :coherence,
  user_schema: Faq.User,
  repo: Faq.Repo,
  module: Faq,
  logged_out_url: "/",
  email_from_name: System.get_env["FAQ_APP_ADMINISTRATOR_NAME"],
  email_from_email: System.get_env["FAQ_APP_ADMINISTRATOR_EMAIL"],
  opts: [:authenticatable, :recoverable, :trackable, :unlockable_with_token, :registerable]

config :coherence, Faq.Coherence.Mailer,
  adapter: Swoosh.Adapters.Mailgun,
  api_key: System.get_env['MAILGUN_API_KEY']

# %% End Coherence Configuration %%
