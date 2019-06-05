# Writing test for zendesk_api.rb file
# frozen_string_literal: true

require_relative '../../lib/models/zendesk_api'
require 'webmock/rspec'

RSpec.describe ZendeskApi do
  let(:all_tickets) { ZendeskApi.new }

  # Testing list tickets function from zendesk_api - #tickets
  describe '#tickets' do
    # created a exact dummy response to match/test the endpoints
    let(:ticket_response) do
      {
        'tickets' => [
          'url' => 'https://priyankamukundmk.zendesk.com/api/v2/tickets/1.json',
          'created_at' => '2019-05-28T07:00:12Z',
          'status' => 'open'
        ]
      }
    end
    # default page starts with 1st page
    let(:page) { 1 }

    # Used webmok - it disable the network conneting to api
    # and it keep a record of all HTTP calls, so that it can look up later
    before do
      stub_request(:get, "https://priyankamukundmk.zendesk.com/api/v2/tickets.json?page=#{page}&per_page=25")
        .with(
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

    it 'should read - list all tickets from the url endpoints' do
      all_tickets.tickets
      expect(WebMock).to have_requested(
        :get,
        'https://priyankamukundmk.zendesk.com/api/v2/tickets.json?page=1&per_page=25'
      )
    end

    describe 'To check the endpoints reads 2nd page' do
      let(:page) { 2 }

      it 'should check for 2nd page' do
        all_tickets.tickets(2)
        expect(WebMock).to have_requested(
          :get,
          'https://priyankamukundmk.zendesk.com/api/v2/tickets.json?page=2&per_page=25'
        )
      end
    end
  end

  # Testing show individual ticket function from zendesk_api - #ticket
  describe '#ticket' do
    # creating a exact dummy response to match/test the endpoints
    let(:individual_ticket_response) do
      {
        'ticket' => {
          'url' => 'https://priyankamukundmk.zendesk.com/api/v2/tickets/1.json',
          'created_at' => '2019-05-28T07:00:12Z',
          'status' => 'open'
        }
      }
    end
    # default id is 1 for test.
    let(:id) { 1 }

    before do
      stub_request(:get, 'https://priyankamukundmk.zendesk.com/api/v2/tickets/1.json')
        .with(
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
    it 'should read ticket ID' do
      all_tickets.ticket(id: 1)
      expect(WebMock).to have_requested(
        :get,
        'https://priyankamukundmk.zendesk.com/api/v2/tickets/1.json'
      )
    end
  end
end
