require 'sinatra'
require 'sinatra/reloader'
require_relative '../models/zendesk_api'

get '/' do
  erb :home
end

# Written response because to dig into all tickets
# as it is a array of hash, nextpage and previous page.
get '/tickets' do
  response = ZendeskApi.new.tickets(params[:page])
  @tickets = response.dig('tickets')
  @next_page = response.dig('next_page')
  @previous_page = response.dig('previous_page')
  @count = response.dig('count')
  erb :list_ticket
end

get '/tickets/:id' do
  @ticket = ZendeskApi.new.ticket(id: params['id'])
  erb :show_ticket
end
