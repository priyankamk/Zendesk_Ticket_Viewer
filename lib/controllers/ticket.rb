# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require_relative '../models/zendesk_api'

get '/' do
  erb :home
rescue SocketError
  erb :internet_offline_error
rescue Errno::ECONNREFUSED
  erb :blocked_by_administrator_error
end

# Written response because to dig into all tickets
# as it is a array of hash.
get '/tickets' do
  response = ZendeskApi.new.tickets(params[:page])
  # @first_page = 1
  # @tickets_per_page = 25
  # @last_page = @count / @tickets_per_page + 1 if @count % @tickets_per_page != 0
  # @current_page = params[:page].nil? ? @first_page : params[:page].to_i
  @tickets = response.dig('tickets')
  @count = response.dig('count')
  @next_page = response.dig('next_page')
  @previous_page = response.dig('previous_page')
  @no_of_pages = @count / ZendeskApi::NO_OF_TICKETS_PER_PAGE
  @error = response['error_message']
  erb :list_ticket
rescue SocketError
  erb :internet_offline_error
rescue Errno::ECONNREFUSED
  erb :blocked_by_administrator_error
end

get '/tickets/:id' do
  @ticket = ZendeskApi.new.ticket(id: params['id'].to_i)
  @error = @ticket['error_message']
  erb :show_ticket
rescue SocketError
  erb :internet_offline_error
rescue Errno::ECONNREFUSED
  erb :blocked_by_administrator_error
end
