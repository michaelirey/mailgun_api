
module Gun

  class Message
    attr_accessor :parameters

    def initialize(parameters={})
      @parameters = parameters
    end

  end

end
