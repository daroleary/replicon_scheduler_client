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

      it 'retrieves user details' do

        allow(client).to receive(:get_json).with(client.api_url('employees')) { response }

        ret = client.employees
        expect(ret).to eql(response)
      end
    end

    context 'employee' do

      it 'retrieves user details' do

        employee_id = 1
        allow(client).to receive(:get_json).with(client.api_url("employees/#{employee_id}")) { response }

        ret = client.employee(employee_id)
        expect(ret).to eql(response)
      end
    end

  end
end
