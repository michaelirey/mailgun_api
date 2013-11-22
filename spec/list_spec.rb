require "mailgun_api"

# Add a mailgun account credentials here. Should be empty of lists.
test_account = {
  api_key: 'key-xxxxxxxxxxxxxxxxxxxxxxx',
  domain: 'test_account.mailgun.org'
}

list_name = "rspec_test"

describe Mailgun::List do
  before :each do
    @mailgun = Mailgun.new(test_account)
  end

  it "should list all mailling lists on the account" do
    @mailgun.lists.should == []
  end

  it "Create a mailing list" do
    @mailgun.create_list(list_name)
    @mailgun.response["message"].should == "Mailing list has been created"
  end

  it "should list all mailling lists on the account" do
    @mailgun.lists.count.should == 1
    @mailgun.lists.first["address"].should == "rspec_test@evanta.mailgun.org"
  end

  it "find a mailing list by name" do
    @list = @mailgun.find_list(list_name)
    @list.address.should == "rspec_test@evanta.mailgun.org"
  end

  it "Deletes the mailing list" do
    @list = @mailgun.find_list(list_name)
    @list.delete
    @mailgun.response["message"].should == "Mailing list has been deleted"
    @mailgun.response["address"].should == "#{list_name}@#{test_account[:domain]}"
  end


  it "Creates a mailing list - With additional properties" do
    @list = @mailgun.create_list(list_name, {description: "my description", name: "my name"})
    @mailgun.response["message"].should == "Mailing list has been created"
    @list.address.should == "#{list_name}@#{test_account[:domain]}"
    @list.name.should == "my name"
    @list.description.should == "my description"
  end


  describe "List properties" do
    before :each do
      @list = @mailgun.find_list(list_name)
    end

    it "Updates mailing list properties" do
      @list.update({description: "new description"})
      @mailgun.response["message"].should == "Mailing list has been updated"
      @list.description.should == "new description"
    end

    it "Gets the raw list properties" do
      @list.properties["members_count"].should == 0
      @list.properties["description"].should == "new description"
      @list.properties["access_level"].should == "readonly"
      @list.properties["address"].should == "rspec_test@evanta.mailgun.org"
      @list.properties["name"].should == "my name"
    end

    it "Other properties can be accessed" do
      @list.members_count.should == 0
      @list.description.should == "new description"
      @list.access_level.should == "readonly"
      @list.address.should == "rspec_test@evanta.mailgun.org"
      @list.name.should == "my name"
    end

    it "Should get the list stats" do
      @list.stats.should == {"unique"=> {"clicked"=>{"recipient"=>0, "link"=>0}, "opened"=>{"recipient"=>0}},"total"=>{"complained"=>0,"delivered"=>0,"clicked"=>0,"opened"=>0,"unsubscribed"=>0,"bounced"=>0,"dropped"=>0}}
    end

  end


  describe "List Members" do
    before :each do
      @list = @mailgun.find_list(list_name)
    end

    it "Gets the list of mailing list members" do
      @list.members.should == []
      @list.members_count.should == 0
    end

    it "Adds a member to the list (using email address only)" do
      @list.add_member("alice@example.com")
      @mailgun.response["message"].should == "Mailing list member has been created"
      @mailgun.response["member"].should == {"subscribed"=>true, "name"=>"", "vars"=>{}, "address"=>"alice@example.com"}
    end

    it "Gets the count of mailing list members" do
      @list.members_count.should == 1
    end

    it "Adds a member to the list (using hash)" do
      @list.add_member({address: "bob@example.com", name: "Bob Smith", subscribed: false})
      @mailgun.response["message"].should == "Mailing list member has been created"
      @mailgun.response["member"].should == {"subscribed"=>false, "name"=>"Bob Smith", "vars"=>{}, "address"=>"bob@example.com"}
      @list.members_count.should == 2
    end

    it "Finds a member in the list" do
      member = @list.find_member("bob@example.com")
      member["member"].should == {"subscribed"=>false, "name"=>"Bob Smith", "vars"=>{}, "address"=>"bob@example.com"}
    end

    it "Updates a member on the mailing list" do
      @list.update_member("bob@example.com", {address: "bob@newdomain.com", name: "Robert Smith", subscribed: true})
      @mailgun.response["message"].should == "Mailing list member has been updated"
      member = @list.find_member("bob@newdomain.com")
      member["member"].should == {"subscribed"=>true, "name"=>"Robert Smith", "vars"=>{}, "address"=>"bob@newdomain.com"}      
    end

    it "Adds multiple members" do
      @list.add_member([{address: "Peter <peter@exampe.com>", vars: {age: 26}}, {name: "John Doe", address: "John@doe.com", vars: {age: 34} }])
      @mailgun.response["message"].should == "Mailing list has been updated"
      @list.members_count.should == 4
    end

    it "Removes a member from the list" do
      @list.remove_member("peter@exampe.com")
      @mailgun.response["message"].should == "Mailing list member has been deleted"
      @list.members_count.should == 3
    end

    it "Deletes the mailing list" do
      @list.delete
      @mailgun.response["message"].should == "Mailing list has been deleted"
      @mailgun.response["address"].should == "#{list_name}@#{test_account[:domain]}"
    end

  end


end