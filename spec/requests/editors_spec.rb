require 'rails_helper'

RSpec.describe "Editors", type: :request do
  describe "GET /editors" do
    it "works! (now write some real specs)" do
      get editors_path
      expect(response).to have_http_status(200)
    end
  end
end
