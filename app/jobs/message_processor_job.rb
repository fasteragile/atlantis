class MessageProcessorJob < ApplicationJob
  queue_as :default

  def perform(json)
    puts "Worker invoked with #{json}. Posting that payload to HTTP REST API"

    http = HTTParty.post(uri, body: json)
    puts "Response from REST API: #{http.response}"
  end

  # TODO: Works with docker-compose, make this production ready
  def uri
    "http://api:3000/votes.json"
  end

end
