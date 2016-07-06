require "cog/command"
require "heroku/auth"
require_relative "helpers"

class CogCmd::Heroku::Config < Cog::Command
  include CogCmd::Heroku::Helpers

  def run_command
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
    config = config.map { |key, value| {key: key, value: value} }
    write_json(config, "config_list")
  end

  def set
    new_config = config_pairs.map { |config| config.split("=", 2) }.to_h
    old_config = Heroku::Auth.api.get_config_vars(app).body
    config = old_config.merge(new_config)
    Heroku::Auth.api.put_config_vars(app, config)
    write_string("Set environment variables and restarted app")
  end

  def unset
    config_keys.each do |key|
      Heroku::Auth.api.delete_config_var(app, key)
    end

    write_string("Unset environment variables and restarted app")
  end

  private

  def config_pairs
    request.args[1..-1]
  end

  def config_keys
    request.args[1..-1]
  end
end
