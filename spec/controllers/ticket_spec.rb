# Test for ticket.rb file
# frozen_string_literal: true

require_relative '../../lib/controllers/ticket'
require 'rack/test'
require 'webmock/rspec'

RSpec.describe 'Ticket routes' do
  # Rack::Test::Methods -> mixin bring's test method helper.
  include Rack::Test::Methods
  # Instend of adding (def app) in spec_helper,
  # for conveience I included that function here.
  def app
    Sinatra::Application
  end

  describe 'GET to check / for landing page' do
    it 'should match the title' do
      get '/'
      expect(last_response).to be_ok
      expect(last_response).to match(/Welcome To Zendesk Ticker Viewer/)
    end

    it 'should match the display ticket link' do
      get '/'
      expect(last_response).to be_ok
      expect(last_response).to match %r{<a href="/tickets" class="btn btn-warning">Display Tickets</a>}
    end
  end

  describe 'GET checks /tickets to list tickets' do
    # created a exact dummy response to match/test the endpoints.
    let(:ticket_response) do
      {
        'tickets' => [
          'url' => 'https://priyankamukundmk.zendesk.com/api/v2/tickets/1.json',
          'created_at' => '2019-05-28T07:00:12Z',
          'status' => 'open'
        ],
        'next_page' => 'https://priyankamukundmk.zendesk.com/api/v2/tickets.json?page=1&per_page=25',
        'previous_page' => 0,
        'count' => 201
      }
    end

    let(:page) { 1 }

    before do
      stub_request(
        :get,
        "https://priyankamukundmk.zendesk.com/api/v2/tickets.json?page=#{page}&per_page=25"
      ).with(
        headers: {
          'Accept' => '*/*',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization' => 'Basic cHJpeWFua2FAa3VuZGF5LmNvbTouM2pGcEVQcW9aZjc=',
          'User-Agent' => 'Ruby'
        }
      )
        .to_return(status: 200, body: JSON.dump(ticket_response), headers: {
                     'Content-Type': 'application/json'
                   })
    end

    # It checking status to be HTTP 200
    it 'should check for tickets response' do
      get '/tickets', page: 1
      expect(last_response).to be_ok
    end
  end

  describe 'GET to check /tickets/:id to display individual ticket' do
    let(:individual_ticket_response) do
      {
        'ticket' => {
          'url' => 'https://priyankamukundmk.zendesk.com/api/v2/tickets/1.json',
          'created_at' => '2019-05-28T07:00:12Z',
          'status' => 'open'
        }
      }
    end

    # default id is 1
    let(:id) { 1 }

    before do
      stub_request(
        :get,
        "https://priyankamukundmk.zendesk.com/api/v2/tickets/#{id}.json"
      ).with(
        headers: {
          'Accept' => '*/*',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization' => 'Basic cHJpeWFua2FAa3VuZGF5LmNvbTouM2pGcEVQcW9aZjc=',
          'User-Agent' => 'Ruby'
        }
      )
        .to_return(status: 200, body: JSON.dump(individual_ticket_response),
                   headers: {
                     'Content-Type': 'application/json'
                   })
    end
    # It checking status to be HTTP 200
    it 'should display individual ticket response status' do
      get '/tickets/1'
      expect(last_response).to be_ok
    end
  end
end
