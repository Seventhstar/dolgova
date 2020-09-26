require 'rails_helper'

RSpec.describe "Enents", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/enent/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/enent/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/enent/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/enent/update"
      expect(response).to have_http_status(:success)
    end
  end

end
