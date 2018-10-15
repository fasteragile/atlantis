require 'sneakers'
Sneakers.configure(
  connection: Bunny.new(host: 'rabbitmq', username: 'fasteragile', password: 'atlantis')
)
