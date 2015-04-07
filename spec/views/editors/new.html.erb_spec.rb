require 'rails_helper'

RSpec.describe "editors/new", type: :view do
  before(:each) do
    assign(:editor, Editor.new())
  end

  it "renders new editor form" do
    render

    assert_select "form[action=?][method=?]", editors_path, "post" do
    end
  end
end
