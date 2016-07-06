require "cog/command"
require "heroku/auth"
require_relative "helpers"

class CogCmd::Heroku::Ps < Cog::Command
  include CogCmd::Heroku::Helpers

  def run_command
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
    ps = heroku.get_ps(app).body
    write_json(ps, "ps_list")
  end

  # TODO: Support formation. See heroku CLI for example.
  #   https://github.com/heroku/heroku/blob/master/lib/heroku/command/ps.rb
  def scale
    ps = ps_scale_pairs.map do |ps|
      type, qty = ps.split("=", 2)
      heroku.post_ps_scale(app, type, qty)
      "Scaled process type \"#{type}\" to #{qty} processes"
    end

    write_string(ps)
  end

  def restart
    if ps
      heroku.post_ps_restart(app, {ps: ps})
      write_string("Restarted process \"#{ps}\"")
    else
      heroku.post_ps_restart(app, {})
      write_string("Restarted all processes")
    end
  end

  private

  def ps_scale_pairs
    request.args[1..-1]
  end

  def ps
    request.args[1]
  end
end
