require 'spec_helper'
require 'replicon_scheduler_client'

describe RepliconSchedulerClient::API do

  let(:client) { create(:client) }

  let(:api_host )     { 'api_host' }

  before { RepliconSchedulerClient.init({api_host: api_host}) }

  describe 'Client' do
    let!(:client)  { RepliconSchedulerClient.create }

    context 'api_url' do
      it 'create the api url' do
        url = 'employees'
        ret = client.api_url(url)

        expect(ret).to eq("http://#{api_host}/#{url}")
      end
    end

    context '#employees' do
      let(:employee) { FactoryGirl.build(:employee)}

      it 'retrieves all employee details' do

        employee_id_1   = 1
        employee_id_2   = 2
        employee_name_1 = 'some.name'
        employee_name_2 = 'some.other.name'
        allow(client).to receive(:get_json).with(client.api_url('employees')) { [employee_json(employee_id_1, employee_name_1),
                                                                                 employee_json(employee_id_2, employee_name_2)] }

        actual = client.employees

        expect(actual.count).to eql(2)

        employee = actual.first
        expect(employee.id).to eql(employee_id_1)
        expect(employee.name).to eql(employee_name_1)

        employee = actual[1]
        expect(employee.id).to eql(employee_id_2)
        expect(employee.name).to eql(employee_name_2)
      end
    end

    context 'employee' do

      it 'retrieves specific employee details' do

        employee_id = 1
        employee_name = 'some.name'
        allow(client).to receive(:get_json).with(client.api_url("employees/#{employee_id}")) { employee_json(employee_id, employee_name) }

        actual_employee = client.employee(employee_id)
        expect(actual_employee.id).to eql(employee_id)
        expect(actual_employee.name).to eql(employee_name)
      end
    end

    context 'time-off requests' do

      it 'retrieves all time-off requests' do

        days_1 = [1,2,3]
        week_1 = 23
        employee_id_1 = 1

        days_2 = [1,2]
        week_2 = 24
        employee_id_2 = 2

        allow(client).to receive(:get_json).with(client.api_url('time-off/requests')) { [time_off_request_json(employee_id_1, week_1, days_1),
                                                                                         time_off_request_json(employee_id_2, week_2, days_2)]}

        actual = client.time_off_requests

        expect(actual.count).to eql(2)

        time_off_request = actual.first
        expect(time_off_request.employee_id).to eql(employee_id_1)
        expect(time_off_request.week).to eql(week_1)
        expect(time_off_request.days).to eql(days_1)

        time_off_request = actual[1]
        expect(time_off_request.employee_id).to eql(employee_id_2)
        expect(time_off_request.week).to eql(week_2)
        expect(time_off_request.days).to eql(days_2)
      end
    end

    context 'weeks' do

      it 'retrieves all weeks details' do

        id_1 = 23
        start_date_1 = '2015/06/01'

        id_2 = 24
        start_date_2 = '2015/06/08'

        allow(client).to receive(:get_json).with(client.api_url('weeks')) { [week_json(id_1, start_date_1),
                                                                             week_json(id_2, start_date_2)] }
        actual = client.weeks

        expect(actual.count).to eql(2)

        week = actual.first
        expect(week.id).to eql(id_1)
        expect(week.start_date).to eql(start_date_1.to_date)

        week = actual[1]
        expect(week.id).to eql(id_2)
        expect(week.start_date).to eql(start_date_2.to_date)

      end
    end

    context 'week' do

      it 'retrieves specific week details' do

        id = 23
        start_date = '2015/06/01'

        allow(client).to receive(:get_json).with(client.api_url("weeks/#{id}")) { week_json(id, start_date) }

        actual = client.week(id)
        expect(actual.id).to eql(id)
        expect(actual.start_date).to eql(start_date.to_date)
      end
    end

    context 'rule-definitions' do

      it 'retrieves all rule-definitions' do

        id_1 = 1
        value_1 = 'some.value'
        description_1 = 'some.description'

        id_2 = 2
        value_2 = 'some.other.value'
        description_2 = 'some.other.description'

        allow(client).to receive(:get_json).with(client.api_url('rule-definitions')) { [rule_definition_json(id_1, value_1, description_1),
                                                                                        rule_definition_json(id_2, value_2, description_2)] }

        actual = client.rule_definitions

        expect(actual.count).to eql(2)

        rule_definition = actual.first
        expect(rule_definition.id).to eql(id_1)
        expect(rule_definition.value).to eql(value_1)
        expect(rule_definition.description).to eql(description_1)

        rule_definition = actual[1]
        expect(rule_definition.id).to eql(id_2)
        expect(rule_definition.value).to eql(value_2)
        expect(rule_definition.description).to eql(description_2)
      end
    end

    context 'shift-rules' do

      it 'retrieves all shift-rules' do

        rule_id_1 = 1
        employee_id_1 = 123
        value_1 = 2

        rule_id_2 = 2
        employee_id_2 = 234
        value_2 = 4

        allow(client).to receive(:get_json).with(client.api_url('shift-rules')) { [shift_rule_json(rule_id_1, employee_id_1, value_1),
                                                                                   shift_rule_json(rule_id_2, employee_id_2, value_2)]}

        actual = client.shift_rules

        expect(actual.count).to eql(2)

        shift_rules = actual.first
        expect(shift_rules.rule_id).to eql(rule_id_1)
        expect(shift_rules.employee_id).to eql(employee_id_1)
        expect(shift_rules.value).to eql(value_1)

        shift_rules = actual[1]
        expect(shift_rules.rule_id).to eql(rule_id_2)
        expect(shift_rules.employee_id).to eql(employee_id_2)
        expect(shift_rules.value).to eql(value_2)
      end
    end
  end

  private

  def employee_json(id, name)
    {id: id,
     name: name}
  end

  def rule_definition_json(id, value, description)
    {id: id,
     value: value,
     description: description}
  end

  def shift_rule_json(rule_id, employee_id, value)
    {rule_id: rule_id,
     employee_id: employee_id,
     value: value}
  end

  def time_off_request_json(employee_id, week, days)
    {employee_id: employee_id,
     week: week,
     days: days}
  end

  def week_json(id, start_date)
    {id: id,
     start_date: start_date}
  end
end
