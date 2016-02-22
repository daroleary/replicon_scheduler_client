require 'replicon_scheduler_client/version'
require 'replicon_scheduler_client/api'
require 'replicon_scheduler_client/client'
require 'replicon_scheduler_client/models/employee'
require 'replicon_scheduler_client/models/rule_definition'
require 'replicon_scheduler_client/models/shift_rule'
require 'replicon_scheduler_client/models/time_off_request'
require 'replicon_scheduler_client/models/week'

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
