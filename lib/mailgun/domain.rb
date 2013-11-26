module Mailgun

  # Domain functionality
  # Refer http://documentation.mailgun.com/api-domains.html for optional parameters


  class Domain
    attr_accessor :properties


    # Used internally
    def initialize(mailgun)
      @mailgun = mailgun
    end

    # List all domains
    def list(options={})
      @mailgun.response = Mailgun::Base.fire(:get, @mailgun.api_url + "/domains")["items"] || []
    end

	end

end
