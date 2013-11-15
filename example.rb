require 'mailgat'
require 'rest_client'


@mailgat = Mailgat.new(api_key: 'key-xxxxxxxxxxxxxxxx', domain: 'evanta.mailgun.org')


### Lists

# get all lists on account
@mailgat.lists

# find a list by name
@list = @mailgat.find_list("list_name")

# create_mailing_list
@list = @mailgat.create_list("list_name")



# Fetches the list of mailing list members.
@list.members

# get_list_stats
@list.stats

# remove_list
@list.delete

# Update mailing list properties
@list.update({name: "new_list_name"})


### List Members

# Find a mailing list member
@list.find_member("michael.irey@gmail.com")

# add_list_member
@list.add_member("michael.irey@gmail.com")

# add_list_members
@list.add_member([{"address": "Alice <alice@example.com>", "vars": {"age": 26}},{"name": "Bob", "address": "bob@example.com", "vars": {"age": 34}}])

# update_member
@list.update_member("...")

# remove_member from list
@list.remove_member("michael.irey@gmail.com")

# will efficiently add/remove/update the list given with the list at mailgun.
@list.sync_members([{"address": "Alice <alice@example.com>"}, {"etc.."}])


### Members

# find all lists a member belongs to
@member.lists


### Messages

# Create a message
@message = @mailgat.create_message({})

# Send a message to a list
@list.send_message(@message, when: "Fri, 25 Oct 2011 23:10:10 -0000")






list_name = "devtest@evanta.mailgun.org"


# or alternatively:
@mailgun = Mailgun(api_key: 'key-79l7h-xnypifsdv975-686go-uhsj8h9', domain: 'evanta.mailgun.org')


# Delete list
# @mailgun.lists.delete(list_name)


# Create list
@mailgun.lists.create list_name


# # Show all lists
# puts @mailgun.lists.list


# Add people to list
# @mailgun.list_members(list_name).add("nathan.brakken@evanta.com")
# @mailgun.list_members(list_name).add("graham.baas@evanta.com")
# @mailgun.list_members(list_name).add("ryan.pyeatt@evanta.com")
# @mailgun.list_members(list_name).add("daniel.johnson@evanta.com")
# @mailgun.list_members(list_name).add("brittany.budil@evanta.com")

# puts @mailgun.list_members(list_name).add("michael.irey@evanta.com")
# @mailgun.list_members(list_name).add("michael.irey@gmail.com")


# Show people on the list
# puts @mailgun.list_members(list_name).list

# # Show all lists
# puts @mailgun.lists.list




# Show all lists
puts @mailgun.lists.list

# Create Email

# Send email to list
# parameters = {
#   :to => list_name,
#   :subject => "TPS Reports",
#   :html => "Yeah, so we're gonna need you to go ahead and come in on Saturday... Yeah<br /><br /><img src='http://i.ytimg.com/vi/Fy3rjQGc6lA/0.jpg' />",
#   :from => "Bill Lumberg <lumberg.bill@initech.mailgun.domain>"
# }
# puts @mailgun.messages.send_email(parameters)


RestClient.post("https://api:key-79l7h-xnypifsdv975-686go-uhsj8h9" \
                  "@api.mailgun.net/v2/lists/#{list_name}/members.json",
                  :subscribed => true,
                  :members => Evanta::EmailGeneratorEmail.find(209).recipients.to_json )

# puts @mailgun.list_members(list_name).list


# puts Evanta::EmailGeneratorEmail.find(209)

