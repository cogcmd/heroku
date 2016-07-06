require "cog/command"
require "heroku/auth"
require_relative "helpers"

class CogCmd::Heroku::Release < Cog::Command
  include CogCmd::Heroku::Helpers

  def run_command
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
    write_json(releases)
  end

  def info
    release = Heroku::Auth.api.get_release(app, release_version).body
    write_json(release)
  end

  def rollback
    release = Heroku::Auth.api.post_release(app, release_version).body
    write_string("Rollback back to release \"#{release_version}\"")
  end

  private

  def release_version
    request.args[1]
  end
end
