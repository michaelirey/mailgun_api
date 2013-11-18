require 'pry'

module Gun

  # Mailing List functionality
  # Refer http://documentation.mailgun.net/api-mailinglists.html for optional parameters


  class List
    attr_accessor :properties

    # Used internally
    def initialize(mailgun)
      @mailgun = mailgun
    end

    # List all mailing lists
    def list(options={})
      @mailgun.response = Mailgun.fire(:get, list_url, options)["items"] || []
    end

    # List a single mailing list by a given address
    def find(list_name)
      @mailgun.response = Mailgun.fire(:get, list_url(list_name))
      @properties = @mailgun.response["list"]
    end

    # Create a mailing list with a given address
    def create(list_name, options={})
      params = {:address => list_name}
      @mailgun.response = Mailgun.fire(:post, list_url, params.merge(options))
    end

    # Update a mailing list with a given address
    # with an optional new address, name or description
    def update(params={})
      return unless !params.empty?
      @mailgun.response = Mailgun.fire(:put, list_url(self.address), params)
    end   

    # Deletes a mailing list with a given address
    def delete
      @mailgun.response = Mailgun.fire(:delete, list_url(self.address))
    end


    def members
      @mailgun.response = Mailgun.fire(:get, list_url(self.address) + "/members")["items"] || []
    end


    def stats
      @mailgun.response = Mailgun.fire(:get, list_url(self.address) + "/stats")
    end


    def add_member(params={})

      if params.class == String
        add_member_by_hash(params)
      end

      if params.class == Hash
        add_member_by_hash(params)
      end

      if params.class == Array
        add_members(params)
      end


    end


    def update_member(address, params={})
      return unless !params.empty?
      @mailgun.response = Mailgun.fire(:put, list_url(self.address) + "/members/#{address}", params)
    end


    def find_member(address)
      @mailgun.response = Mailgun.fire(:get, list_url(self.address) + "/members/#{address}")
    end


    def remove_member(address)
      @mailgun.response = Mailgun.fire(:delete, list_url(self.address) + "/members/#{address}")
    end


    def method_missing(name, *args)

      if properties.has_key?(name.to_s)
        @properties[name.to_s]
      end
    end




    private

    def add_member_by_name(params)
      address = params
      params = {}
      params[:address] = address
      @mailgun.response = Mailgun.fire(:post, list_url(self.address) + "/members", params)
    end

    def add_member_by_hash(params)
      @mailgun.response = Mailgun.fire(:post, list_url(self.address) + "/members", params)
    end


    def add_members(members)
      params = {}
      params['members'] = members.to_json
      @mailgun.response = Mailgun.fire(:post, list_url(self.address) + "/members.json", params)
    end




    # Helper method to generate the proper url for Mailgun mailbox API calls
    def list_url(address=nil)
      "#{@mailgun.api_url}/lists#{'/' + address if address}"
    end
    
  end
end