# The Challenge

Please leave this file in your submission, as we regularly make tweaks to the
challenge definition, and it's helpful for the reviewers to know which version
you were sent.

Before you read on, note that some parts of this challenge have been left
consciously vague. We want to see how you react to imperfect specifications,
and what choices you make under such circumstances.

## Overview

Gigs provides an API to let customers manage phone plans for their users. Check
out our [developer documentation] for a general overview of our API offering.

We publish events for all actions that take place on the platform, e.g.
`user.created`, `subscription.created`, `subscription.activated`, etc. Events
power all the interactions between different parts of our internal
infrastructure. We use [Google Cloud Pub/Sub] to publish events and subscribe to
event topics.

Next to our internal use cases for events we also expect them to be useful for
out customers. For example, the `subscription.activated` event could allow a
customer to send an email notifying the user that their subsccription is ready
to use. We want to provide common [HTTP webhooks][webhooks] for that purpose.
Our customers should be able to specify one or more HTTP URL endpoints to
receive webhook messages at and we'll make sure to send all specified events
there.

Fortunately, there is a [webhooks as a service solution built by Svix][svix]
which we can use to get most of this behaviour for free. All we need to do is
receive events (as HTTP POST requests) from Pub/Sub, extract a few fields, and
send the message to Svix.

In this project, you're going to build exactly this as an independent service.

(Don't worry if you don't have experience with Pub/Sub specifically - just
assume it works similarly to your favourite queuing service.)

## Your Task

Write a small service as described above and, even more importantly, write some
notes! We are most interested in understanding your thought process and approach
to the problem. Don't worry about handling all edge cases or achieving full test
coverage. Use the `NOTES.md` file to explain any shortcomings and what you would
like to do with more time.

Write a small service which does the following:

* Listens on an HTTP port.
* Accepts JSON formatted POST messages on `/notifications`.
* Sends every received event to Svix as an individual message.
* Ensures idempotency in case the same message is received multiple times.
* Handles errors raised by Svix appropriately (and, in particular, handles any
  rate limit errors in a sensible way).

While we don't expect full test coverage, we'd like to see _some_ tests. Use
your judgement to decide what should be tested, and write down your thoughts on
any additional tests you would add.

Finally, we want to hear your thoughts on what follow up tasks would be
necessary in order to make your service production-ready.

## Your Thoughts

The `NOTES.md` file is the place to show us how you thought through the problem,
and what your priorities would be if you were in charge of implementing this
feature at Gigs.

Here are some examples of things we love reading in peoples' `NOTES.md` files:

* What big customer-facing ideas would you focus on to improve the customer
  experience of subscribing to & receiving events?
* What assumptions did you make while building the service, and why were your
  choices the right ones?
* How would you run the service in production? How would you maintain confidence
  that events are properly sent to Svix?
* How would you track errors and communicate problems?

## What We're Looking For

We want you to show us two things:

1. That you can implement a service to solve a real life problem.
1. That you can solve problems for real life users. (See "Your Thoughts" above.)

For the Svix integration, we want to see how you'd build resilience to API
errors, handle retries, and in general make sure your system does the right
thing when things go wrong.

## Don't Do These

There's a lot of extra work you'd do in real life that we don't need to see
here. Feel free to skip these things:

1. Don't worry about writing perfect code or having tests for every scenario.
2. Don't feel you need to solve every edge case. Rough edges are fine as long as
   you document your decisions and trade-offs in your `NOTES.md` file.

And last, if you know what you're doing, don't spend more than a few hours on
this. If you are learning, take all the time you need.

[developer documentation]: https://developers.gigs.com/docs/api/35a6c0eba105a-quickstart
[Google Cloud Pub/Sub]: https://cloud.google.com/pubsub/docs/overview
[svix]: https://www.svix.com/
[webhooks]: https://webhooks.fyi/
