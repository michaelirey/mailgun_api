module Mailgat
  class Base
    # Options taken from
    # http://documentation.mailgun.net/quickstart.html#authentication
    # * Mailgun host - location of mailgun api servers
    # * Procotol - http or https [default to https]
    # * API key and version
    # * Test mode - if enabled, doesn't actually send emails (see http://documentation.mailgun.net/user_manual.html#sending-in-test-mode)
    # * Domain - domain to use
    def initialize(options)
      Mailgat.mailgun_host    = options.fetch(:mailgun_host)    {"api.mailgun.net"}
      Mailgat.protocol        = options.fetch(:protocol)        { "https"  }
      Mailgat.api_version     = options.fetch(:api_version)     { "v2"  }
      Mailgat.test_mode       = options.fetch(:test_mode)       { false }
      Mailgat.api_key         = options.fetch(:api_key)         { raise ArgumentError.new(":api_key is a required argument to initialize Mailgat") if Mailgat.api_key.nil?}
      Mailgat.domain          = options.fetch(:domain)          { nil }
    end

    # Returns the base url used in all Mailgun API calls
    def base_url
      "#{Mailgat.protocol}://api:#{Mailgat.api_key}@#{Mailgat.mailgun_host}/#{Mailgat.api_version}"
    end

  end
end