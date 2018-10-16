# README

## Containers
Five containers: db(postgres), api(rails), workers(rails),
message-processor(lib/message_processor), rabbitmq

### db

PG is running on a non standard port because I have PG running locally,
and will cause bind error.

Set in docker-compose PORTS:
 - "5433:5432"

### api
The REST API implemented as a Rails app (generated without --api)

#### POST /votes.json
Expects something like this:
```
{"name":"Woodstock B&B","vote":-1,"voter":{"first_name":"Jack","last_name":"Collier"}}
```
Returns HTTP_OK or a 422 status with messages.

#### GET /bed_and_breakfasts.json

Returns something like this:
```
[{"id":1,"name":"Woodstock B\u0026B","karma":8}]
```

### rabbitmq

Standard image

### workers

ActiveJob runner using `rake sneakers:run`. Takes JSON payloads enqueued
by the message-processor and posts them via HTTParty to the REST API.

### message-processor

Runs a ruby script in lib/message_processor.rb that:
* builds a connection to RabbitMQ
* Subscribes
* Processes messages by turning them into an ActiveJob worker

Start all of the containers with

  `docker-compose up`

Send a test payload:

  `docker-compose run api bundle exec rails vote:upvote`
  
  `docker-compose run api bundle exec rails vote:downvote`

## Running the tests:

  `docker-compose -f docker-compose-tests.yml up`

Standard rails tests instead of Rspec.

## Design choices

Votes are expected to by +1 / -1, thumbs-up style. Voting by star-rating is not
contemplated.

Strings, usernames, and passwords not yet extracted.

The WORKERS container is spammy on startup is RabbitMQ boots slowly. I was
going to implement health checking but it looks like Docker has changed since I
last did this. So I left it spammy in favor of finishing the project.

Workers are present to translate the message_processor JSON into an ActiveJob,
which is a more robust framework than what I can build quickly with a ruby script.

Case in point: message-processor is a poll-style client with a 1 second timeout.
I'm a little unfamiliar with building RabbitMQ consumers from scratch,
so given unlimited time I'd spend time understanding how to fold the workers and
message processor together and do manual acks when my jobs succeed, and subscribe
to messages as they are pushed instead of polling.

I decided that tabulating votes on NH B&Bs did not require more real time
tabulation.  

I disabled CSRF token checking since there is only one API POST and no forms.

The API does not require token or other authentication.

Generally, I like to test only one thing (ie. one assert) per test. These tests
are fairly simple, though, so I cheated a bit.

We do not enforce "1 person, 1 vote". That'd be my next most important feature
to implement.
