class MessageProcessorJob < ApplicationJob
  queue_as :default
  def perform(json)
    puts "Worker invoked with #{json}"
    
  end
end
