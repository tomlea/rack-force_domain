require 'rack'

class Rack::ForceDomain
  def initialize(app, domain)
    @app = app
    if domain and domain != ""
      @domain = domain

      # set host from domain
      domain_parts = domain.split(":")
      @host = domain_parts[0]

      # add port if applicable
      if domain_parts[1]
        port = domain_parts[1].to_i
        @port = port if port > 0
      end
    end
  end

  def call(env)
    request = Rack::Request.new(env)
    host_mismatch = (@host && request.host != @host)
    port_mismatch = (@port && request.port != @port)
    if host_mismatch or port_mismatch
      fake_request = Rack::Request.new(env.merge("HTTP_HOST" => @domain, "SERVER_PORT" => @port || request.port))
      Rack::Response.new([], 301, "Location" => fake_request.url).finish
    else
      @app.call(env)
    end
  end
end
