require "mailgun_api"

describe Mailgun::Base do

  it "should raise an error if the api_key has not been set" do
    expect do
      Mailgun.new
    end.to raise_error ArgumentError
  end

  it "can be called directly if the api_key has been set via Mailgun.configure" do
    Mailgun.configure { |c| c.api_key = "api-key-xxxxxxxxxxxxxxxxx" }
    expect do
      Mailgun.new
    end.not_to raise_error()
  end

  it "can be instanced with the api_key as a param" do
    expect do
      Mailgun.new(api_key: "api-key-xxxxxxxxxxxxxxxxx")
    end.not_to raise_error()
  end

  describe "Mailgun.new" do
    it "Mailgun() method should return a new Mailgun object" do
      mailgun = Mailgun.new({api_key: "api-key-xxxxxxxxxxxxxxxxx"})
      mailgun.should be_kind_of(Mailgun::Base)
    end
  end

  describe "internal helper methods" do
    before :each do
      @mailgun = Mailgun.new({api_key: "api-key-xxxxxxxxxxxxxxxxx", domain: 'my.domain.com'})
    end

    describe "Mailgun#api_url" do
      it "should return https url if use_https is true" do
      @mailgun.api_url.should == "https://api:#{@mailgun.api_key}@#{@mailgun.host}/#{@mailgun.api_version}"
      end
    end

    describe "Mailgun.fire" do
      it "should send method and arguments to RestClient" do
        RestClient.should_receive(:test_method)
          .with({:arg1=>"val1"},{})
          .and_return({})
        Mailgun::Base.fire :test_method, :arg1=>"val1"
      end
    end
    
  end


  describe "configuration" do
    describe "default settings" do
      it "api_version is v2" do
        Mailgun.api_version.should eql 'v2'
      end
      it "should use https by default" do
        Mailgun.protocol.should == "https"
      end
      it "mailgun_host is 'api.mailgun.net'" do
        Mailgun.host.should eql 'api.mailgun.net'
      end

      it "test_mode is false" do
        Mailgun.test_mode.should eql false
      end

      it "domain is not set" do
        Mailgun.domain.should be_nil
      end
    end

    describe "setting configurations" do
      before(:each) do
        Mailgun.configure do |c|
          c.api_key = 'some-api-key'
          c.api_version = 'v2'
          c.protocol = 'https'
          c.host = 'api.mailgun.net'
          c.test_mode = false
          c.domain = 'some-domain'
        end
      end

      it "allows me to set my API key easily" do
        Mailgun.api_key.should eql 'some-api-key'
      end

      it "allows me to set the api_version attribute" do
        Mailgun.api_version.should eql 'v2'
      end

      it "allows me to set the protocol attribute" do
        Mailgun.protocol.should eql 'https'
      end
      
      it "allows me to set the host attribute" do
        Mailgun.host.should eql 'api.mailgun.net'
      end
      it "allows me to set the test_mode attribute" do
        Mailgun.test_mode.should eql false
      end

      it "allows me to set my domain easily" do
        Mailgun.domain.should eql 'some-domain'
      end
    end
  end
end