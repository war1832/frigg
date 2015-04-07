require 'rails_helper'

RSpec.describe "editors/edit", type: :view do
  before(:each) do
    @editor = assign(:editor, Editor.create!())
  end

  it "renders the edit editor form" do
    render

    assert_select "form[action=?][method=?]", editor_path(@editor), "post" do
    end
  end
end
