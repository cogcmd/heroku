require "cog/command"
require "heroku/auth"

class CogCmd::Heroku::Ps < Cog::Command
  def run_command
    subcommand = request.args.first

    case subcommand
    when "list", nil
      list
    when "scale"
      scale
    when "restart"
      restart
    end
  end

  def list
    ps = Heroku::Auth.api.get_ps(app).body
    render(ps)
  end

  # TODO: Support formation. See heroku CLI for example.
  #   https://github.com/heroku/heroku/blob/master/lib/heroku/command/ps.rb
  def scale
    ps = request.args[1..-1].map do |ps|
      type, qty = ps.split("=", 2)
      Heroku::Auth.api.post_ps_scale(app, type, qty)
      "Scaled process type \"#{type}\" to #{qty} processes"
    end

    info(ps)
  end

  def restart
    if ps = request.args[1]
      Heroku::Auth.api.post_ps_restart(app, {ps: ps})
      info("Restarted process \"#{ps}\"")
    else
      Heroku::Auth.api.post_ps_restart(app, {})
      info("Restarted all processes")
    end
  end

  def app
    request.options["app"]
  end

  def render(content)
    response.content = content
    response
  end

  def info(message)
    response["body"] = message
    response
  end
end
