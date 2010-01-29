require 'rack'

class Rack::ForceDomain
  def initialize(app, domain)
    @app = app
    @domain = domain
  end

  def call(env)
    request = Rack::Request.new(env)
    if @domain and request.host != @domain
      fake_request = Rack::Request.new(env.merge("HTTP_HOST" => @domain))
      Rack::Response.new([], 301, "Location" => fake_request.url).finish
    else
      @app.call(env)
    end
  end
end
