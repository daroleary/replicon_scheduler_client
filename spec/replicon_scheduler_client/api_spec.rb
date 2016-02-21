require 'spec_helper'
require 'replicon_scheduler_client'

describe RepliconSchedulerClient::API do

  let(:client) { create(:client) }

  let(:api_host )     { 'api_host' }
  let(:response)      { { state: "succ"} }
  let(:str_response)  { "{\"state\":\"succ\"}" }

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

    context 'employees' do

      it 'retrieves all employee details' do

        allow(client).to receive(:get_json).with(client.api_url('employees')) { response }

        ret = client.employees
        expect(ret).to eql(response)
      end
    end

    context 'employee' do

      it 'retrieves specific employee details' do

        employee_id = 1
        allow(client).to receive(:get_json).with(client.api_url("employees/#{employee_id}")) { response }

        ret = client.employee(employee_id)
        expect(ret).to eql(response)
      end
    end

    context 'time-off requests' do

      it 'retrieves all time-off requests' do

        allow(client).to receive(:get_json).with(client.api_url('time-off/requests')) { response }

        ret = client.time_off_requests
        expect(ret).to eql(response)
      end
    end

    context 'weeks' do

      it 'retrieves all weeks details' do

        allow(client).to receive(:get_json).with(client.api_url('weeks')) { response }

        ret = client.weeks
        expect(ret).to eql(response)
      end
    end

    context 'week' do

      it 'retrieves specific week details' do

        week_number = 1
        allow(client).to receive(:get_json).with(client.api_url("weeks/#{week_number}")) { response }

        ret = client.week(week_number)
        expect(ret).to eql(response)
      end
    end

    context 'rule-definitions' do

      it 'retrieves all rule-definitions' do

        allow(client).to receive(:get_json).with(client.api_url('rule-definitions')) { response }

        ret = client.rule_definitions
        expect(ret).to eql(response)
      end
    end

    context 'shift-rules' do

      it 'retrieves all shift-rules' do

        allow(client).to receive(:get_json).with(client.api_url('shift-rules')) { response }

        ret = client.shift_rules
        expect(ret).to eql(response)
      end
    end
  end
end
