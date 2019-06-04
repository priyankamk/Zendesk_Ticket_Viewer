require 'httparty'
# To connect with zendeskapi and to request for tickets using url endpoints
class ZendeskApi
  # I used bacic_auth to login everytime and access the tickets
  # Here tickets function list upto 25 tickets in a page
  def tickets(page = 1)
    endpoint = "https://priyankamukundmk.zendesk.com/api/v2/tickets.json?page=#{page}&per_page=25"
    HTTParty.get(endpoint, basic_auth: auth)
  end

  # Here ticket function show's individual ticket
  def ticket(id:)
    HTTParty.get(
      "https://priyankamukundmk.zendesk.com/api/v2/tickets/#{id}.json", basic_auth: auth).dig('ticket')
  end

  private

  def auth
    {
      username: 'priyanka@kunday.com',
      password: '.3jFpEPqoZf7'
    }
  end
end
