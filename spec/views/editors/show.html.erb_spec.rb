require 'rails_helper'

RSpec.describe "editors/show", type: :view do
  before(:each) do
    @editor = assign(:editor, Editor.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
