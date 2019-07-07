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

get '/tickets' do
  response = ZendeskApi.new.tickets(params[:page].to_i)
  @tickets = response.dig('tickets')
  @count = response.dig('count') || 25
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
