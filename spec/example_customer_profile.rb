require_relative 'oneapi/client'

username = ARGV[0]
password = ARGV[1]

if username == nil or username.empty?
    puts "No username given"
    exit
end
if password == nil or password.empty?
    puts "No password given"
    exit
end

customer_profile_client = OneApi::CustomerProfileClient.new(username, password)
customer_profile_client.login

customer_profile = customer_profile_client.get_customer_profile()
puts customer_profile.inspect

account_balance = customer_profile_client.get_account_balance()
puts account_balance.inspect
