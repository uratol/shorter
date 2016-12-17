require 'spec_helper'
require 'rails_helper'

describe MainController, type: :controller do
  it "renders the index template" do
    get :index
    expect(response).to render_template("index")
  end

  it "returns the encoded key" do
    test_url = 'http://test_controller.com'

    xhr :post, 'encode', url: test_url, format: :json

    expect(response.code).to eq('200')
    expect(JSON.parse(response.body)['key']).to eq(Link.encode(test_url))
  end


end