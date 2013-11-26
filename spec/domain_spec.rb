require "mailgun_api"

# Add a mailgun account credentials here. Should be empty of lists.
test_account = {
  api_key: 'key-xxxxxxxxxxxxxxxxxxxxxxx'
}

# Need to adjust the domain for your account.
domain = "xxxxxx.mailgun.org"

describe Mailgun::Domain do
  before :each do
    @mailgun = Mailgun.new(test_account)
  end

  it "should list all domains on the account" do
    @mailgun.domains.first["name"].should == domain
  end

end