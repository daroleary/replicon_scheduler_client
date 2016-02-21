module RepliconSchedulerClient
  module API

    def employees
      api_path = 'employees'
      get_json api_url(api_path)
    end
  end
end