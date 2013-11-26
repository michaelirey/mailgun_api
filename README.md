mailgun_api rubygem
=======

A library for interfacing with the awesome Mailgun API.

See: http://www.mailgun.com/

mailgun_api exposes the following resources:

  * Sending email
  * Mailing Lists
  * Mailing List Members

## Usage

#### Installation
```ruby
gem install mailgun_api
```

#### Include in your ruby file(s)
```ruby
require 'mailgun_api'
```

#### Configuration
```ruby

# Initialize Mailgun (set defaults):
Mailgun.configure do |config|
  config.api_key = 'your-api-key-xxxxxxxxxxxxxxx'
  config.domain = 'your_domain.mailgun.org'
end

@mailgun = Mailgun.new


# Initialize Mailgun (custom for each object):
@mailgun = Mailgun.new(api_key: 'your-api-key-xxxxxxxxxxxxxxx', domain: 'your_domain.mailgun.org')
```


#### Mailing Lists
```ruby
# List all Mailing lists
@mailgun.lists

# Find a mailing list - Will search for 'list@your_domain.mailgun.org'
@list = @mailgun.find_list("list")

# Create a mailing list - Will create 'list@your_domain.mailgun.org'
@list = @mailgun.create_list("list")

# Create a mailing list - With additional properties
@list = @mailgun.create_list('list_address', {description: "my description", name: "my name"})

# Update mailing list properties
@list.update({description: "My Description"})

# Delete the mailing list
@list.delete


# Get the raw list properties
@list.properties

# Other properties can be accessed as well
@list.members_count
@list.description
@list.created_at
@list.access_level
@list.address
@list.name

# Get the list of mailing list members.
@list.members

# Get the list stats
@list.stats
```

#### List Members
```ruby
# Find a member in the list
@list.find_member("alice@example.com")

# Add a member to the list (using email address only)
@list.add_member("alice@example.com")

# Add a member to the list (using hash)
@list.add_member({address: "alice@example.com", name: "Alice Smith"})

# Add multiple members
@list.add_member([{address: "Alice <alice@example.com>", vars: {age: 26}}, {name: "Bob", address: "bob@example.com", vars: {age: 34} }])

# Update member
@list.update_member("bob@example.com", {address: "bob@newdomain.com", name: "Robert Smith", subscribed: false})

# Remove member
@list.remove_member("alice@exampe.com")
```

#### Domains
```ruby
# List domains
@domains = @mailgun.domains
```

#### Messages
```ruby
# Create a message
@message = @mailgun.create_message({})

# Send a message to a list
@list.send_message(@message, when: "Fri, 25 Oct 2011 23:10:10 -0000")
```


## Author

Michael Irey / [@michaelirey](http://github.com/michaelirey)

## License

Released under the MIT license. See LICENSE for more details.