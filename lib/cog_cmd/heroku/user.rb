require "cog/command"
require "heroku/auth"
require_relative "helpers"

class CogCmd::Heroku::User < Cog::Command
  include CogCmd::Heroku::Helpers

  def run_command
    case subcommand
    when "list", nil
      list
    when "add"
      add
    when "remove"
      remove
    end
  end

  def list
    users = Heroku::Auth.api.get_collaborators(app).body
    write_json(users)
  end

  def add
    Heroku::Auth.api.post_collaborator(app, email)
    write_string("Added user with email \"#{email}\"")
  end

  def remove
    Heroku::Auth.api.delete_collaborator(app, email)
    write_string("Removed user with email \"#{email}\"")
  end

  private

  def email
    request.args[1]
  end
end
