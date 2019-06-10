# Zendesk Ticket Viewer - Coding Challenge

Zendesk is a customer service tool that allows the creation and management of support tickets.
This Application allows you to do the following features:

- Connect to Zendesk API using endpoints.
- Request the tickets for your account.
- Display them in a list.
- Display individual ticket details.
- Page through tickets when more than 25 are returned.

## About my application
I decided to go with sinatra 

## Installation Instruction

- Clone this repository: `git@github.com:priyankamk/Zendesk_Ticket_Viewer.git` to your local machine through the command line.
- Ensure you have version 2.6.2 of Ruby installed. The version can be checked by running `ruby -v` in the terminal. If not, you can download ruby here https://www.ruby-lang.org/en/downloads/
### Install dependencies:
- cd into the repository and then run `bundle install` to install dependencies.
### Run server:
- Enter in `bundle exec ruby lib/controllers/ticket.rb` to start the application.
### Testing:
- To test the ticket.rb or zendesk_api.rb run `rspec spec/controllers/ticket_spec.rb`
 `rspec spec/controllers/zendesk_api_spec.rb`

## The Challenge

- The challenge is to create a customer service tool using Zendesk API calls by requesting tickets to display.
- I have used RSpec and web mock to test the JSON request as I can create a dummy JSON response and test with the actual output.
- To list out 25 tickets in one page and show page through tickets as next page and previous page buttons.
- Exception error handling

## Learning

- For Testing
 http://sinatrarb.com/testing.html
- For exception handling
 https://stackify.com/web-api-error-handling/

## My Approach

-  I decided to build a web-based application to make UI simple and easy to use for the user's and I chose to write the application with Ruby and Sinatra, as I felt the rails would do too much of 'Heavy Lifting' and It would also allow me to keep the application more lightweight and simplified.
- I am using HTTParty gem to make the API calls using Zendeskapi `https://priyankamukundmk.zendesk.com/api/v2/tickets` and request the tickets.
- I separated my concern’s inside lib folder and I tried to stick with object-oriented MVC design to keep my code neat and clean. In which ZendeskApi class deals with API calls and ticket controller displays the user interface.
- The Zendesk API returns 25 tickets per page. I have accounted for having more tickets by making multiple API calls, I did that using postman but only making the request when the extra records are needed.


