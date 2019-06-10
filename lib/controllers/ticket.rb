require 'sinatra'
require 'sinatra/reloader'
require_relative '../models/zendesk_api'

get '/' do
  begin
    erb :home
  rescue SocketError
    erb :internet_offline_error
  rescue Errno::ECONNREFUSED
    erb :blocked_by_administrator_error
  end
end

# Written response because to dig into all tickets
# as it is a array of hash.
get '/tickets' do
  begin
    response = ZendeskApi.new.tickets(params[:page])
    @first_page = 1
    @no_of_tickets = 25
    @tickets = response.dig('tickets')
    @count = response.dig('count')
    @last_page = @count / @no_of_tickets + 1 if @count % @no_of_tickets != 0
    @current_page = params[:page].nil? ? @first_page : params[:page].to_i
    @next_page = response.dig('next_page')
    @previous_page = response.dig('previous_page')
    @error = response['error_message']
    erb :list_ticket
  rescue SocketError
    erb :internet_offline_error
  rescue Errno::ECONNREFUSED
    erb :blocked_by_administrator_error
  end
end

get '/tickets/:id' do
  begin
    @ticket = ZendeskApi.new.ticket(id: params['id'].to_i)
    @error = @ticket['error_message']
    erb :show_ticket
  rescue SocketError
    erb :internet_offline_error
  rescue Errno::ECONNREFUSED
    erb :blocked_by_administrator_error
  end
end
