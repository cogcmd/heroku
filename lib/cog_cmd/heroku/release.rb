require "cog/command"
require "heroku/auth"

class CogCmd::Heroku::Release < Cog::Command
  def run_command
    subcommand = request.args.first

    case subcommand
    when "list", nil
      list
    when "info"
      info
    when "rollback"
      rollback
    end
  end

  def list
    releases = Heroku::Auth.api.get_releases(app).body
    render(releases)
  end

  def info
    release_version = request.args[1]
    release = Heroku::Auth.api.get_release(app, release_version).body
    render(release)
  end

  def rollback
    release_version = request.args[1]
    release = Heroku::Auth.api.post_release(app, release_version).body
    output("Rollback back to release \"#{release_version}\"")
  end

  def app
    request.options["app"]
  end

  def render(content)
    response.content = content
    response
  end

  def output(message)
    response["body"] = message
    response
  end
end
