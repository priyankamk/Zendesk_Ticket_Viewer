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
# To check nextpage, previous page and count.
get '/tickets' do
  begin
    response = ZendeskApi.new.tickets(params[:page])
    @tickets = response.dig('tickets')
    @next_page = response.dig('next_page')
    @previous_page = response.dig('previous_page')
    @count = response.dig('count')
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
    # return status 404 if @ticket.nil?

    @error = @ticket['error_message']
    erb :show_ticket
  rescue SocketError
    erb :internet_offline_error
  rescue Errno::ECONNREFUSED
    erb :blocked_by_administrator_error
  end
end
