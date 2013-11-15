require "rest-client"
require "json"
# require "multimap"

# require "mailgun/mailgun_error"
# require "mailgun/base"
# require "mailgun/domain"
# require "mailgun/route"
# require "mailgun/mailbox"
# require "mailgun/bounce"
# require "mailgun/unsubscribe"
# require "mailgun/complaint"
# require "mailgun/log"
# require "mailgun/list"
# require "mailgun/list/member"
# require "mailgun/message"

#require "startup"
class Mailgat

  attr_accessor :host, :protocol, :api_version, :test_mode, :api_key, :domain


  def initialize(params={})
    @host         = params.fetch(:host, "api.mailgun.net")
    @protocol     = params.fetch(:protocol, "https")
    @api_version  = params.fetch(:api_version, "v2")
    @test_mode    = params.fetch(:test_mode, false)
    @api_key      = params.fetch(:api_key) { raise ArgumentError.new(":api_key is a required argument to initialize Mailgat") if api_key.nil?}
    @domain       = params.fetch(:domain, nil)
  end

  def find_list

  end


  # returns the last raw json response
  def response

  end

  # Returns the base url used in all Mailgun API calls
  def api_url
    "#{protocol}://api:#{api_key}@#{host}/#{api_version}"
  end
    
end
