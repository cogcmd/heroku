require "cog/command"
require "heroku/auth"

class CogCmd::Heroku::User < Cog::Command
  def run_command
    subcommand = request.args.first

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
    render(users)
  end

  def add
    email = request.args[1]
    Heroku::Auth.api.post_collaborator(app, email)
    output("Added user with email \"#{email}\"")
  end

  def remove
    email = request.args[1]
    Heroku::Auth.api.delete_collaborator(app, email)
    output("Removed user with email \"#{email}\"")
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
