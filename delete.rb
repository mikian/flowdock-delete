require 'flowdock'

client = Flowdock::Client.new(api_token: ENV['FLOWDOCK_TOKEN'])
user_id = client.get('/user')['id']

client.get('/private').each do |private_flow|
  client.get("/private/#{private_flow['id']}/messages").select{|msg| msg['user_id'] == user_id}.each do |message|
    client.delete("/private/#{private_flow['id']}/messages/#{message['id']}")
  end
end
