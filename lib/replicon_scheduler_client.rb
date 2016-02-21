require 'replicon_scheduler_client/version'
require 'replicon_scheduler_client/api'
require 'replicon_scheduler_client/client'

module RepliconSchedulerClient

  # Should only be called from the initializer on Rails startup
  def self.init(conf)
    Client.init(conf)
  end

  # Creates an instance of the client
  def self.create
    Client.new
  end
end
