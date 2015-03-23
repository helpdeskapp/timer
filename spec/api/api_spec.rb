require 'rails_helper'

describe Api do
  describe 'GET /api/ping' do
    it "should return pong" do
      get '/api/ping'

      valid_response = { :pong => "ok" }.to_json

      expect(response.status).to eq 200
      expect(response.body).to eq valid_response
    end
  end
end
