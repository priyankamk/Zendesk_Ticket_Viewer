# Zendesk Ticket Viewer - Coding Challenge

Zendesk is a customer service tool that allows the creation and management of support tickets.
This Application allows you to do the following features:

- Connect to Zendesk API using endpoints.
- Request the tickets for your account.
- Display them in a list.
- Display individual ticket details.
- Page through tickets when more than 25 are returned.

## Installation Instruction

- Clone this repository: `git@github.com:priyankamk/Zendesk_Ticket_Viewer.git` to your local machine through the command line.
- Ensure you have version 2.6.2 of Ruby installed. The version can be checked by running `ruby -v` in the terminal. If not, you can download ruby here https://www.ruby-lang.org/en/downloads/

### Install dependencies:

- cd into the repository and then run `bundle install` to install dependencies.

### Run server:

- Enter `bundle exec ruby lib/controllers/ticket.rb` to start the application.
- Open url in the browser - http://localhost:4567

### Testing:

- To test the ticket.rb run `rspec spec/controllers/ticket_spec.rb`
- To test the zendesk_api.rb run `rspec spec/models/zendesk_api_spec.rb`

## Build with

- Ruby
- Sinatra
- httparty
- Rspec
- WebMock
- Bootstrap

## The Challenge

- The challenge is to create a customer service tool using Zendesk API calls by generating tickets to display.
- I have used RSpec and web mock to test the JSON request as I can create a dummy JSON response and test with the actual output.
- To add pagination and check out 1st page, last page, current page, next page and previous page.
- Exception error handling

## My Approach

- I decided to build a web-based application to make UI simple and easy to use. I chose to write the application with Ruby and Sinatra, as I felt the rails would do too much of 'Heavy Lifting' and also allow me to keep the application more lightweight and simplified.
- I am using HTTParty gem to make the API calls using Zendeskapi `https://priyankamukundmk.zendesk.com/api/v2/tickets` and generate the tickets.
- I separated my concern’s inside lib folder and I tried to stick with object-oriented MVC design to keep my code neat and clean. In which ZendeskApi class deals with API calls and ticket controller displays the user interface.
- The Zendesk API returns 25 tickets per page - `http://localhost:4567/tickets?page=1`. I have accounted for having more tickets by making multiple API calls, I did that using postman but only making the request when the extra records are needed.
- I have added pagination in which user can check next page, previous page, current page and last page.
- I used RSpec for happy path testing and webmock to test with actual JSON output.
- This is the first time i’m experimenting with exception handling, I researched a lot and implemented basic error handling and display response message when an error occurs.

## Learning

- For Testing
  http://sinatrarb.com/testing.html
- For exception handling - Basic understanding what is error handling
  https://stackify.com/web-api-error-handling/
