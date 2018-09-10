require 'rails_helper'

RSpec.describe 'Tasks API', type: :request do
  # add tasks owner
  let(:user) { create(:user) }
  let!(:tasks) { create_list(:task, 10, created_by: user.id) }
  let(:task_id) { tasks.first.id }
  # authorize request
  let(:headers) { valid_headers }

  describe 'GET /tasks' do
    # update request with headers
    before { get '/tasks', params: {}, headers: headers }

    # [...]
  end

  describe 'GET /tasks/:id' do
    before { get "/tasks/#{task_id}", params: {}, headers: headers }
    # [...]
  end
  # [...]
end

describe 'POST /tasks' do
  let(:valid_attributes) do
    # send json payload
    { title: 'Learn Ruby', created_by: user.id.to_s }.to_json
  end

  context 'when request is valid' do
    before { post '/tasks', params: valid_attributes, headers: headers }
    # [...]
  end

  context 'when the request is invalid' do
    let(:invalid_attributes) { { title: nil }.to_json }
    before { post '/tasks', params: invalid_attributes, headers: headers }

    it 'returns status code 422' do
      expect(response).to have_http_status(422)
    end

    it 'returns a validation failure message' do
      expect(json['message'])
          .to match(/Missing token/)
    end
  end

  describe 'PUT /tasks/:id' do
    let(:valid_attributes) { { title: 'Rancagua' }.to_json }

    context 'when the record exists' do
      before { put "/tasks/#{task_id}", params: valid_attributes, headers: headers }
      # [...]
    end
  end

  describe 'DELETE /tasks/:id' do
    before { delete "/tasks/#{task_id}", params: {}, headers: headers }
    # [...]
  end
end