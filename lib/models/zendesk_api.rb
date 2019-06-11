require 'httparty'
# frozen_string_literal: true
# To connect with zendeskapi and generate tickets using url endpoints.
class ZendeskApi
  # I used bacic_auth to login everytime and access the tickets.
  ZENDESK_API_TICKET_URL = 'https://priyankamukundmk.zendesk.com/api/v2/tickets.json'
  # Here tickets function list upto 25 tickets per page.
  def tickets(page = 1)
    endpoint = "#{ZENDESK_API_TICKET_URL}?page=#{page}&per_page=25"
    response = HTTParty.get(endpoint, basic_auth: auth)
    if response.code == 404 || response.code == 401
      return {
        'tickets' => [], 'total' => 0, 'error_message' => response['error']
      }
    end
    response
  end

  # Here ticket function show's individual ticket
  def ticket(id:)
    response = HTTParty.get(
      "https://priyankamukundmk.zendesk.com/api/v2/tickets/#{id}.json",
      basic_auth: auth
    )
    if response.code == 404 || response.code == 401
      return {
        'tickets' => [], 'total' => 0, 'error_message' => response['error']
      }
    end
    response.dig('ticket')
  end

  private

  def auth
    {
      username: 'priyanka@kunday.com',
      password: '.3jFpEPqoZf7'
    }
  end
end
