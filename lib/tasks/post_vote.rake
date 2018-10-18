namespace :vote do
  desc "Post a test upvote to RabbitMQ"
  task :upvote do
    enqueue_vote('{"name":"Woodstock B&B","vote":1,"voter":{"first_name":"Jack","last_name":"Collier"}}')
  end

  desc "Post a test down vote to RabbitMQ"
  task :downvote do
    enqueue_vote('{"name":"Woodstock B&B","vote":-1,"voter":{"first_name":"Jack","last_name":"Collier"}}')
  end

  desc "Post an incomplete test vote to RabbitMQ"
  task :incomplete do
    enqueue_vote('{"vote":-1,"voter":{"last_name":"Collier"}}')
  end

  desc "Enqueue an invalid payload that should be rejected"
  task :junk do
    enqueue_vote('---csdfsdfdfssd')
  end
end

def enqueue_vote(vote_json)
  STDOUT.sync = true
  puts "Posting a test vote to RabbitMQ"

  conn = Bunny.new(host: 'rabbitmq', user: "fasteragile", password: 'atlantis')
  conn.start

  ch = conn.create_channel
  q  = ch.queue("votes", :auto_delete => true)
  x  = ch.default_exchange

  x.publish(vote_json,:routing_key => q.name)

  sleep 1.0
  puts "Posted. Shutting down connection."
  conn.close
end
