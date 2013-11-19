
module Gun

  # Mailing List functionality
  # Refer http://documentation.mailgun.net/api-mailinglists.html for optional parameters


  class Message
    attr_accessor :parameters

    def initialize(parameters={})
      @parameters = parameters
    end

  end

end
