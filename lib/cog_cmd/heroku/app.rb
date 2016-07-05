require "cog/command"
require "heroku/auth"

class CogCmd::Heroku::App < Cog::Command
  def run_command
    subcommand = request.args.first

    case subcommand
    when "list", nil
      list
    when "info"
      info
    end
  end

  def list
    apps = Heroku::Auth.api.get_apps.body

    render(apps)
  end

  def info
    return error("You must pass an app of which to show the details") if request.args.length < 2

    app_name = request.args[1]
    apps = Heroku::Auth.api.get_apps.body
    app = apps.find { |app| app["name"] == app_name }

    render(app)
  end

  def render(content)
    response.content = content
    response
  end

  def error(message)
    response["body"] = message
    response
  end
end
