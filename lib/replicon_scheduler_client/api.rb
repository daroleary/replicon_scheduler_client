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

    def time_off_requests
      api_path = 'time-off/requests'
      get_json api_url(api_path)
    end

    def weeks_api_path
      api_path = 'weeks'
    end

    def weeks
      get_json api_url(weeks_api_path)
    end

    def week(week_number)
      api_path = "#{weeks_api_path}/#{week_number}"
      get_json api_url(api_path)
    end

    def rule_definitions
      api_path = 'rule-definitions'
      get_json api_url(api_path)
    end

    def shift_rules
      api_path = 'shift-rules'
      get_json api_url(api_path)
    end

    def submit(json,features={})
      # TODO: Need to call post in client
      # Pass in JSON to post, so can post schedule(s)

      api_path = 'submit'
      get_json api_url(api_path)
    end
  end
end