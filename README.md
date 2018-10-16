# README

Five containers: db(postgres), api(rails), workers(rails),
message-processor(lib/message_processor), rabbitmq

PG is running on a non standard port because I have PG running locally,
and will cause bind error.

Set in docker-compose PORTS:
 - "5433:5432"


Start all of the containers with

  `docker-compose up`

Send a test payload:

  `docker-compose run api bundle exec rails vote:upvote`
  `docker-compose run api bundle exec rails vote:downvote`

Running the tests:

  `docker-compose -f docker-compose-tests.yml up`

Design choices:

Workers are present to translate the message_processor JSON into an ActiveJob,
which is a more robust framework than I can manage quickly with a ruby script.

Votes are expected to by +1 / -1, thumbs-up style. Voting by star-rating is not
contemplated.

Strings, usernames, and passwords not yet extracted.

The WORKERS container is spammy on startup is RabbitMQ boots slowly. I was
going to implement health checking but it looks like Docker has changed since I
last did this. So I left it spammy in favor of finishing the project.

I disabled CSRF token checking since there is only one API call and no forms.

Generally, I like to test only one thing (ie. one assert) per test. These tests
are fairly simple, though, so I cheated a bit.

We do not enforce "1 person, 1 vote". That'd be my next most important feature
to implement. 
