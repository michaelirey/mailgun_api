module Mailgun

  # Domain functionality
  # Refer http://documentation.mailgun.com/api-domains.html for optional parameters


  class Domain
    attr_accessor :properties


    # Used internally
    def initialize(mailgun)
      @mailgun = mailgun
    end

    # List Domains. If domain name is passed return detailed information, otherwise return a list of all domains.
    def list(domain=nil)
      if domain
        @mailgun.response = Mailgun::Base.fire(:get, @mailgun.api_url + "/domains/#{domain}")
      else
        @mailgun.response = Mailgun::Base.fire(:get, @mailgun.api_url + "/domains")["items"] || []
      end
    end

	end

end
