require "cog/command"
require "heroku/auth"
require_relative "helpers"

class CogCmd::Heroku::App < Cog::Command
  include CogCmd::Heroku::Helpers

  def run_command
    case subcommand
    when "list", nil
      list
    when "info"
      info
    end
  end

  def list
    apps = Heroku::Auth.api.get_apps.body
    write_json(apps)
  end

  def info
    return write_string("You must pass an app of which to show the details") unless app_name

    apps = Heroku::Auth.api.get_apps.body
    app = apps.find { |app| app["name"] == app_name }
    write_json(app)
  end
end
