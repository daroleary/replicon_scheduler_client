module RepliconSchedulerClient
  module API

    def employees_api_path
      api_path = 'employees'
    end

    def employees
      get_json api_url(employees_api_path)
    end

    def employee(id)
      api_path = "#{employees_api_path}/#{id}"
      get_json api_url(api_path)
    end
  end
end