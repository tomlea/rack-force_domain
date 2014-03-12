require 'rack'

class Rack::ForceDomain
  def initialize(app, host, alternate_domains = [])
    @app = app
    @host = host unless host.to_s.empty?
    @allowable_domains = [@host, *alternate_domains].compact
  end

  def ok?(domain)
    @host.nil? or @allowable_domains.include?(domain)
  end

  def call(env)
    request = Rack::Request.new(env)

    if ok? request.host
      @app.call(env)
    else
      fake_request = Rack::Request.new(env.merge("HTTP_HOST" => @host))
      Rack::Response.new([], 301, "Location" => fake_request.url).finish
    end
  end
end
