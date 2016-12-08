defmodule Coherence.LayoutView do
  # use Faq.Coherence.Web, :view
  # https://github.com/smpallen99/coherence#customizing-layout

  use Phoenix.View, root: "web/templates"
  # Import convenience functions from controllers
  import Phoenix.Controller, only: [get_csrf_token: 0, get_flash: 2, view_module: 1]

  # Use all HTML functionality (forms, tags, etc)
  use Phoenix.HTML

  import Faq.Router.Helpers
  import Faq.ErrorHelpers
  import Faq.Gettext
  import Faq.Coherence.ViewHelpers

  import Faq.RoleHelper
end
