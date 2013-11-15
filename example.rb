require 'mailgat'
require 'rest_client'

Mailgat.configure do |config|
  config.api_key = 'key-79l7h-xnypifsdv975-686go-uhsj8h9'
  config.domain  = 'evanta.mailgun.org'
end

@mailgat = Mailgat()



# create_mailing_list
@mailgat.lists.create("list_name")

# set list to use
@mailgat.list_members.use("list_name")

# add_list_member
@mailgat.list_members.add("michael.irey@gmail.com")

# add_list_members
@mailgat.list_members.add('[{"address": "Alice <alice@example.com>", "vars": {"age": 26}},{"name": "Bob", "address": "bob@example.com", "vars": {"age": 34}}]')

# update_member
@mailgat.list_members.update("...")

# list_members



# get_list_stats

# remove_member

# remove_list









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

