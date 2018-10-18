require "bunny"

class MessageProcessor
  def run
    connect
    loop { process_messages; sleep 1 }
  end

  def connect
    loop {
      begin
        @connection = Bunny.new(host: 'rabbitmq',
                         user: "fasteragile",
                         password: 'atlantis')
        @connection.start
        break
      rescue Bunny::TCPConnectionFailedForAllHosts
        puts "RabbitMQ is not available. Waiting 5 seconds, then retrying. " \
             "Make sure Rabbit is running."
        sleep 5
        next
      end
    }
  end

  def channel
    @channel ||= @connection.create_channel
  end

  def queue
    @queue ||= channel.queue("votes", auto_delete: true)
  end

  def process_messages
    queue.subscribe(manual_ack: true) do |delivery_info, properties, payload|
      puts "Received #{payload}, message properties are #{properties.inspect}"
      safe_payload = JSON.parse(payload)

      response = MessageProcessorJob.perform_now(safe_payload)
      puts "Response from REST API: #{response}"

      if response.success?
        ch.ack delivery_info.delivery_tag
      else
        puts "Message failed to post to REST endpoint: #{payload}, #{response}"
        ch.nack
      end
    end
  end
end

MessageProcessor.new.run()
