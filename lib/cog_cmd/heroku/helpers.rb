module CogCmd::Heroku::Helpers
  def write_json(json, template = nil)
    response.content = json
    response.template = template
    response
  end

  def write_string(string)
    response["body"] = string
    response
  end

  def app
    request.options["app"]
  end

  def subcommand
    request.args.first
  end
end
