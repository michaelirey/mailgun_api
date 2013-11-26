require "rest-client"
require "json"
require "mailgun/list"
require "mailgun/domain"
require "mailgun/error"
require "mailgun/message"



module Mailgun

  @@host = "api.mailgun.net"
  @@protocol = "https"
  @@api_version = "v2"
  @@test_mode = false
  @@api_key = nil
  @@domain = nil

  def self.new(params={})
    parameters = {}
    parameters[:host] = params.fetch(:host, host)
    parameters[:protocol] = params.fetch(:protocol, protocol)
    parameters[:api_version] = params.fetch(:api_version, api_version)
    parameters[:test_mode] = params.fetch(:test_mode, test_mode)
    parameters[:api_key] = params.fetch(:api_key, api_key)
    parameters[:domain] = params.fetch(:domain, domain)

    Mailgun::Base.new(parameters)
  end

  def self.configure
    yield self
  end

  def self.host=(value)
    @@host = value
  end

  def self.host
    @@host
  end

  def self.protocol=(value)
    @@protocol = value
  end

  def self.protocol
    @@protocol
  end

  def self.api_version=(value)
    @@api_version = value
  end

  def self.api_version
    @@api_version
  end

  def self.test_mode=(value)
    @@test_mode = value
  end

  def self.test_mode
    @@test_mode
  end

  def self.api_key=(value)
    @@api_key = value
  end

  def self.api_key
    @@api_key
  end  

  def self.domain=(value)
    @@domain = value
  end

  def self.domain
    @@domain
  end



  class Base

    attr_accessor :host, :protocol, :api_version, :test_mode, :api_key, :domain, :response

    def self.configure
      yield self
    end

    def initialize(params={})
      raise ArgumentError.new(":api_key is a required argument to initialize Mailgun") if params.fetch(:api_key).nil?

      @host         = params.fetch(:host)
      @protocol     = params.fetch(:protocol)
      @api_version  = params.fetch(:api_version)
      @test_mode    = params.fetch(:test_mode)
      @api_key      = params.fetch(:api_key)
      @domain       = params.fetch(:domain, nil)
    end

    def find_list(list_name)
      list = Mailgun::List.new(self)
      list.find("#{list_name}@#{domain}")
      list
    end

    def lists
      Mailgun::List.new(self).list
    end

    def domains
      Mailgun::Domain.new(self).list
    end

    def create_list(list_name, options={})
      Mailgun::List.new(self).create("#{list_name}@#{domain}", options)
    end


    def create_message(params)
      Mailgun::Message.new(params)
    end


    # Returns the api url used in all Mailgun API calls
    def api_url
      "#{protocol}://api:#{api_key}@#{host}/#{api_version}"
    end
      

    def self.fire(method, url, parameters={})
      begin
        parameters = {:params => parameters} if method == :get    
        return JSON(RestClient.send(method, url, parameters))
      rescue => e
        error_message = nil
        if e.respond_to? :http_body
          begin
            error_message = JSON(e.http_body)["message"]
          rescue
            raise e
          end
          raise Mailgun::Error.new(error_message)
        end
        raise e
      end
    end

  end

end
