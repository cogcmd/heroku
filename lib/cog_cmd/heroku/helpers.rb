module CogCmd::Heroku::Helpers
  def heroku
    Heroku::API.new(credentials)
  end

  def credentials
    if api_key
      {api_key: api_key}
    elsif username && password
      {username: username, password: password}
    else
      fail("You must set either HEROKU_API_KEY or HEROKU_USERNAME and HEROKU_PASSWORD")
    end
  end

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

  def api_key
    ENV["HEROKU_API_KEY"]
  end

  def username
    ENV["HEROKU_USERNAME"]
  end

  def password
    ENV["HEROKU_PASSWORD"]
  end
end
