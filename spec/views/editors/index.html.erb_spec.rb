require 'rails_helper'

RSpec.describe "editors/index", type: :view do
  before(:each) do
    assign(:editors, [
      Editor.create!(),
      Editor.create!()
    ])
  end

  it "renders a list of editors" do
    render
  end
end
