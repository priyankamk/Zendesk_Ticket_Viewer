# Zendesk Ticket Viewer - Coding Challenge

Zendesk is a customer service tool that allows the creation and management of support tickets.
Your company needs you to build a Ticket Viewer that will:

- Connect to Zendesk API using endpoints
- Request the tickets for your account
- Display them in a list
- Display individual ticket details
- Page through tickets when more than 25 are returned.

## How to Run Locally

- Clone this repo to you local machine through command-line.
- Ensure you have at least version 2.6.2 of Ruby installed. Version can be checked by running `ruby -v` in the terminal. If not, you can download ruby here https://www.ruby-lang.org/en/downloads/
- cd into the repository and then run `bundle install` to install dependencies.
- Enter in `bundle exec ruby lib/controllers/ticket.rb` to start the application.
- To test the ticket.rb or zendesk_api.rb run `rspec spec/controllers/ticket_spec.rb`
  `rspec spec/controllers/zendesk_api_spec.rb`

## The Challenge

- The challenge is to create a customer service tool using zendesk API and by requesting customer tickets and solve them.
- I have used stub the request as it create a dummy response and test the output.

## Learning

- For Testing
  http://sinatrarb.com/testing.html
- For exception handling
  https://stackify.com/web-api-error-handling/

## Design Notes
