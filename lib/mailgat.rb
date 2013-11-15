require "rest-client"
require "json"
require "multimap"

# require "mailgun/mailgun_error"
# require "mailgun/base"
# require "mailgun/domain"
# require "mailgun/route"
# require "mailgun/mailbox"
# require "mailgun/bounce"
# require "mailgun/unsubscribe"
# require "mailgun/complaint"
# require "mailgun/log"
# require "mailgun/list"
# require "mailgun/list/member"
# require "mailgun/message"

#require "startup"

def Mailgat(options={})
  options[:api_key] = Mailgat.api_key if Mailgat.api_key
  options[:domain] = Mailgat.domain if Mailgat.domain
  Mailgat::Base.new(options)
end
