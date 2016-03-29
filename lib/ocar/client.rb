require 'json'
require 'typhoeus'

module Ocar

  extend self

  TYPES = ["cartas", "paquetes", "dni", "partidas" ]
  $hydra = Typhoeus::Hydra.new

  def get_package track_id
    requests = setup_request track_id
    run_request
    get_response requests
  end

  private
  def setup_request track_id
    requests = TYPES.map { |type|
      request = Typhoeus::Request.new("http://www.oca.com.ar",
        method: :get,
        params: { q: "package-locator",
        type: type,
        number: track_id },
        headers: { Accept: "text/html" }
      )
      $hydra.queue(request)
      request
    }
  end

  def run_request
    $hydra.run
  end

  def get_response requests
    results = []
    responses = requests.map do |request|
      parsed = JSON.parse request.response.body
      results << parsed if parsed['success'] == true
    end
    return check_response results
  end


  def check_response results
    if results.any?
      Ocar::Status.new(results.first)
    else
      nil
    end
  end
end
