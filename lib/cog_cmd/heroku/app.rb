require "cog/command"
require "heroku/auth"

class CogCmd::Heroku::App < Cog::Command
  def run_command
    apps = Heroku::Auth.api.get_apps.body
    response.content = apps
    return response
  end
end
