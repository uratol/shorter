require 'spec_helper'
require 'rails_helper'

describe "main/index.html.erb", type: :view do
  it "contains encode form" do
    render
    expect(rendered).to match /encode/
    expect(rendered).to match /url/
    expect(rendered).to match /result/
  end


end