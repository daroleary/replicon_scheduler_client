require 'replicon_scheduler_client/api'
require 'json'
require 'rest-client'

module RepliconSchedulerClient
  class APIResourceNotFound   < StandardError; end
  class APIServiceError       < StandardError; end
  class InvalidAPIKey         < StandardError; end
  class InvalidResponse       < StandardError; end

  class Client
    include RepliconSchedulerClient::API

    def execute(method, url, payload={})
      args = @@config_args.merge method: method, url: url, payload: payload
      response = RestClient::Request.execute args

    rescue RestClient::ResourceNotFound => exception        #404
      raise APIResourceNotFound, exception.http_body
    rescue RestClient::InternalServerError => exception     #500
      raise APIServiceError, exception.http_body
    end


    def get_json(url, payload={})
      response = execute(:get, url, payload)
      JSON.parse( response, symbolize_names: true )
    rescue => exception
      error = "Error RepliconSchedulerClient:: response: #{response}, payload: #{payload}, url: #{url}, exception: #{exception}"
      raise InvalidResponse, error
    end

    def api_url(path)
      "http://#{@@api_host}/#{path}"
    end

    # Note: Important! this is only used to initialize global configuration and should be called as an initializer
    def self.init(conf)
      raise ArgumentError, 'The config argument must be a Hash.' unless conf.kind_of? Hash
      raise ArgumentError, 'An API host must be supplied.'       unless conf[:api_host  ]
      raise ArgumentError, 'The API host must be a string'       unless conf[:api_host  ].kind_of? String

      default_args   = {
          open_timeout: 60,
          timeout:      90 # read timeout
      }

      @@api_host                   = conf[:api_host].chomp("/")

      @@config_args = {}
      @@config_args[:open_timeout] = conf[:open_timeout] || default_args[:open_timeout]
      @@config_args[:timeout]      = conf[:timeout]      || default_args[:timeout]

      RestClient.log = conf[:logger] if conf[:logger]
    end
  end
end