require 'rails_helper'

RSpec.describe "Ajaxes", type: :request do

  describe "GET /write_in" do
    it "returns http success" do
      get "/ajax/write_in"
      expect(response).to have_http_status(:success)
    end
  end

end
