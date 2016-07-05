require "cog/command"
require "heroku/auth"

class CogCmd::Heroku::Config < Cog::Command
  def run_command
    subcommand = request.args.first

    case subcommand
    when "list", nil
      list
    when "set"
      set
    when "unset"
      unset
    end
  end

  def list
    config = Heroku::Auth.api.get_config_vars(app).body
    config = config.map { |key, value| {"key" => key, "value" => value} }
    render(config)
  end

  def set
    new_config = request.args[1..-1].map { |config| config.split("=", 2) }.to_h
    config = Heroku::Auth.api.get_config_vars(app).body
    config = config.merge(new_config)
    Heroku::Auth.api.put_config_vars(app, config)
    render("Set environment variables and restarted app")
  end

  def unset
    request.args[1..-1].each do |key|
      Heroku::Auth.api.delete_config_var(app, key)
    end

    render("Unset environment variables and restarted app")
  end

  def app
    request.options["app"]
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
