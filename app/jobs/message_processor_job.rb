class MessageProcessorJob < ApplicationJob
  queue_as :default

  def perform(json)
    HTTParty.post(uri, body: json)
  end

  # TODO: Works with docker-compose, make this production ready
  def uri
    "http://api:3000/votes.json"
  end

end
