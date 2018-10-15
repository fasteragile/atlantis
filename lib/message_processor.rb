require "bunny"

conn = nil

loop {
  begin
    conn = Bunny.new(host: 'rabbitmq', user: "fasteragile", password: 'atlantis')
    conn.start
    break
  rescue Bunny::TCPConnectionFailedForAllHosts
    puts 'RabbitMQ is not available. Waiting 5 seconds, then retrying. Make sure Rabbit is running.'
    sleep 5
    next
  end
}

ch   = conn.create_channel
q = ch.queue("votes", auto_delete: true)

loop {
  q.subscribe(:manual_ack => true) do |delivery_info, properties, payload|
    puts "Received #{payload}, message properties are #{properties.inspect}"
    MessageProcessorJob.perform_later(payload)
  end
  sleep 1
}
