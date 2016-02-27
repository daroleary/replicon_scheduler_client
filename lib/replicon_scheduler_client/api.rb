module RepliconSchedulerClient
  EMAIL_REGEX = Regexp.compile(/^\w+@\w+\.(com|net|org|edu)$/i)
  # consumes replicons client api, converting them into models
  module API
    def employees_api_path
      'employees'
    end

    def employees
      employees_json = get_json api_url(employees_api_path)
      employees_json.map do |employee|
        Employee.new(employee)
      end
    end

    def employee(id)
      api_path = "#{employees_api_path}/#{id}"
      employee_json = get_json api_url(api_path)
      Employee.new employee_json
    end

    def time_off_requests
      api_path = 'time-off/requests'
      time_off_requests_json = get_json api_url(api_path)
      time_off_requests_json.map do |time_off_request|
        TimeOffRequest.new(time_off_request)
      end
    end

    def weeks_api_path
      'weeks'
    end

    def weeks
      weeks_json = get_json api_url(weeks_api_path)
      weeks_json.map do |week|
        Week.new(week)
      end
    end

    def week(week_number)
      api_path = "#{weeks_api_path}/#{week_number}"
      week_json = get_json api_url(api_path)
      Week.new week_json
    end

    def rule_definitions
      api_path = 'rule-definitions'
      rule_definitions = get_json api_url(api_path)
      rule_definitions.map do |rule_definition|
        RuleDefinition.new(rule_definition)
      end
    end

    def shift_rules
      api_path = 'shift-rules'
      shift_rules_json = get_json api_url(api_path)
      shift_rules_json.map do |shift_rule|
        ShiftRule.new(shift_rule)
      end
    end

    def submit(options={})
      raise ArgumentError.new "invalid name: `#{options[:name]}` given"          unless (name     = extract_name(options))
      raise ArgumentError.new "invalid email format: `#{options[:email]}` given" unless (email    = extract_email(options))
      raise ArgumentError.new "invalid features: `#{options[:features]}` given"  unless (features = extract_features(options))

      api_path = 'submit'
      payload  = {
          name:     name,
          email:    email,
          features: features,
          solution: extract_solution(options)
      }

      response = execute :post, api_url(api_path), payload
      JSON.parse(response, symbolize_names: true)
    end

    def employees_per_shift
      fetch_shift_rule_value_for('EMPLOYEES_PER_SHIFT')
    end

    private

    def fetch_shift_rule_value_for(key)
      rule_definition = rule_definitions.find { |model| model.value == key }
      shift_rules.find { |model| model.rule_id == rule_definition.id }.value
    end

    def extract_name(options)
      name = options[:name]
      name.blank? ? false : name
    end

    def extract_email(options)
      email = options[:email]
      EMAIL_REGEX.match(email) ? email : false
    end

    def extract_features(options)
      features = options[:features]
      features = [features] unless features.is_a? Array
      (features.all? { |item| item.to_i.between?(1, 5) }) ? features : false
    end

    def extract_solution(options)
      solution = options[:solution]
      solution == true || solution == 'true'
    end
  end
end
