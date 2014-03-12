$:.unshift(File.join(File.dirname(__FILE__), *%w[.. lib]))

require 'rack/test'
require 'test/unit'
require 'rack/force_domain'

class ForceDomainTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def test_should_do_nothing_if_domain_is_null
    app = Rack::ForceDomain.new(lambda{|env| @called = true; [200, [], {}] }, nil)
    app.call(Rack::MockRequest.env_for("http://foo.com/baz"))
    assert @called, "expected the request to be passed through"
  end

  def test_should_301_if_domain_is_wrong
    app = Rack::ForceDomain.new(lambda{|env| @called = true; [200, [], {}] } , "bar.com")
    status, body, headers = app.call(Rack::MockRequest.env_for("http://foo.com/baz"))
    assert_equal 301, status
    assert_equal "http://bar.com/baz", headers["Location"]
    assert !@called, "should not have passed through"
  end

  def test_should_passthrough_for_correct_domain
    app = Rack::ForceDomain.new(lambda{|env| @called = true; [200, [], {}] } , "foo.com")
    status, body, headers = app.call(Rack::MockRequest.env_for("http://foo.com/baz"))
    assert_equal 200, status
    assert @called, "expected the request to be passed through"
  end

  def test_should_allow_domains_listed_in_alternate_domains_through
    app = Rack::ForceDomain.new(lambda{|env| @called = true; [200, [], {}] } , "foo.com", ["bar.com", "baz.com"])

    @called = false
    status, body, headers = app.call(Rack::MockRequest.env_for("http://bar.com/baz"))
    assert_equal 200, status
    assert @called, "expected the request to be passed through"

    @called = false
    status, body, headers = app.call(Rack::MockRequest.env_for("http://baz.com/baz"))
    assert_equal 200, status
    assert @called, "expected the request to be passed through"

    status, body, headers = app.call(Rack::MockRequest.env_for("http://other.com/baz"))
    assert_equal 301, status
    assert_equal "http://foo.com/baz", headers["Location"]
  end

  def test_it_redirects_https_to_https
    app = Rack::ForceDomain.new(lambda{|env| @called = true; [200, [], {}] } , "foo.com")
    status, body, headers = app.call(Rack::MockRequest.env_for("https://bar.com/baz"))
    assert_equal 301, status
    assert_equal "https://foo.com/baz", headers["Location"]
  end
end
