require 'uri'
require 'net/http'
require 'json'

module Ocar

  class UnprocessableError < RuntimeError; end
  class ForbiddenError < RuntimeError; end
  class UnknownResponse < RuntimeError; end

  extend self


  def get_packages(track_id)
    uri = set_params(track_id)
    response = send_request(uri)
    parse_json(response)
  end

  private
  def parse_json(response)
    case response
    when Net::HTTPSuccess
      check_response(response)
    when Net::HTTPUnprocessableEntity
      raise UnprocessableError, 'Bad URI param!'
    else
      raise UnknownResponse, 'Something was wrong!'
    end
  end

  def check_response(response)
    json = JSON.parse(response.body)
    if json['cod'] == 200
      Ocar::Status.new(json)
    else
      nil
    end
  end

  def send_request(uri)
    req = Net::HTTP::Get.new(uri.request_uri)
    setup_headers(req)
    http_params = [uri.hostname, uri.port, use_ssl: uri.scheme == 'https']
    Net::HTTP.start(*http_params) {|http| http.request(req)}
  end

  def set_params(options)
    uri = URI.parse("http://www.oca.com.ar")
    uri.query = URI.encode_www_form({q:"package-locator", type: options[:type], number: track_id})
    uri
  end

  def setup_headers(req)
    req.add_field "User-Agent","Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.36"
    req.add_field "Accept","application/json, text/javascript, */*; q=0.01"
    req.add_field "Accept-Encoding", "deflate"
    req.add_field "Accept-Language", "en-US,en;q=0.8,es;q=0.6"
    req.add_field "Connection", "keep-alive"
    req.add_field "Host", "www.oca.com.ar"
    req.add_field "Referer","http://www.oca.com.ar/"
    req.add_field "X-Requested-With","XMLHttpRequest"
    req
  end
end
