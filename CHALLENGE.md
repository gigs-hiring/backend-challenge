# The Challenge

Please leave this file in your submission, as we regularly make tweaks to the
challenge definition, and it's helpful for the reviewers to know which version
you were sent.

## Overview

Gigs provides an API to let customers manage phone plans for their users. Check our [developers documentation] for a general overview of our API offerings!

The Gigs platform publishes many events for all actions taking place, e.g. `user.created`, `subscription.created`, or `subscription.activated`. Events power all the interactions between different parts of our internal infrastructure. We use Google Cloud Pub/Sub to publish events and subscribe to event topics, but this is not relevant for this challenge.

Next to our internal use cases for events we also expect them to be very helpful to our customers. For example, they will enable reacting to asynchronous events like sending notification emails once a subscription has been activated. We want to provide common [HTTP webhooks][webhooks] for that purpose. Our customers should be able to specify one or more HTTP URL endpoints to receive webhook messages at and we'll make sure to send all specified events there.

To determine which customer gets which webhook, we look at the `project` field in the payload. Every customer should have their own project.

Fortunately, there is a [webhooks as a service solution built by Svix][svix] which we can utilize for the heavy lifting. All we need to do is to receive events (as HTTP POST requests) from Pub/Sub, extract a few fields, and send the message to Svix.

In this project, you're going to build exactly this as an independent service.

## Your Task

Write some code and more importantly write some notes for us! We are most interested in your thoughts and approach to the problem. Don't handle all edge cases or write tests for all possible scenarios. Use the `NOTES.md` file to explain any shortcomings and what you would like to do with more time.

Write a small service which does the following:

* listens on a HTTP port
* accepts JSON formatted POST messages on a chosen endpoint (e.g. `/notifications`)
* sends every received event as individual message to Svix
* ensures idempotency in case requests to Svix fail
* handles Svix rate limit errors appropriately

We want to see some tests as well. Make a good choice what you think should be tested directly and write down your thoughts on additional tests.

Finally, we want to hear your thoughts on what follow up tasks should be done in order to make the service production-ready.

## Your Thoughts

The `NOTES.md` file is a place for you to show us how you think about the problem and what you'd be thinking about if you were in charge of this feature at Gigs.

Here are some examples of things we love reading in peoples' `NOTES.md` files:

* What big customer-facing ideas would you focus on to improve the customer experience when receiving events?
* How would you run the service in production? How do we maintain confidence that events are properly sent to Svix?
* How would you track errors and communicate problems?
* Any other comments, questions, or thoughts that came up.

## What We're Looking For

We want you to show us two things:

1. You can build a service to implement a real life problem
1. You can solve problems for real life users. See "Your Thoughts" above

For the Svix integration, we want to see how you'd build resiliency to API errors, handle retries, and overall do the right thing when things go wrong.

## Don't Do These

There's a lot of extra work you'd do in real life that we don't need to see here. Feel free to skip these things:

1. Don't spend time making this perfect or writing tests for every scenario.
2. Don't solve every edge case. Rough edges are fine if it helps you move quickly, and you can document your decisions and trade-offs in `NOTES.md`.

And last, if you know what you're doing, don't spend more than two hours on this.
If you are learning, take all the time you need.

But if you're experienced with HTTP services and a programming language, this should be a quick project.

[developers documentation]: https://developers.gigs.com/docs/api/35a6c0eba105a-quickstart
[svix]: https://www.svix.com/
[webhooks]: https://webhooks.fyi/
