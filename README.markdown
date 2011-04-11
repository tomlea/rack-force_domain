# Rack::ForceDomain

Directs all traffic to a single domain via 301 redirects.

## Example Usage (Heroku)

### config.ru
    use Rack::ForceDomain, ENV["DOMAIN"]

### environment.rb
    config.middleware.use Rack::ForceDomain, ENV["DOMAIN"]

### Heroku Config

    heroku config:add DOMAIN="foo.com"


Now all requests to www.foo.com (or anything else pointed at the app) will 301 to foo.com.

If the `$DOMAIN` environment variable is missing, no redirection will occur.

You can also give provide a port along with your domain "foo.com:3000".