desc "Post a test vote to RabbitMQ"
task post_vote: :environment do
  STDOUT.sync = true
  puts "Posting a test vote to RabbitMQ"

  conn = Bunny.new(host: 'rabbitmq', user: "fasteragile", password: 'atlantis')
  conn.start

  ch = conn.create_channel
  q  = ch.queue("votes", :auto_delete => true)
  x  = ch.default_exchange

  x.publish(
    '{"name":"Woodstock B&B","vote":1,"voter":{"first_name":"Jack","last_name":"Collier"}',
    :routing_key => q.name
  )

  sleep 1.0
  puts "Posted. Shutting down connection."
  conn.close
end
