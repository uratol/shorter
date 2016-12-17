require 'spec_helper'

describe Link, type: :model do

  it 'url encoding' do
    tested_url = "http://example.com"
    encoded_str = Link.encode(tested_url)
    decoded_str = Link.decode(encoded_str)
    expect(decoded_str).to eq(tested_url)
  end

  it 'url encoding with spaces' do
    tested_url = "  http://example.com  "
    encoded_str = Link.encode(tested_url)
    decoded_str = Link.decode(' ' + encoded_str + ' ')
    expect(decoded_str).to eq(tested_url.strip)
  end

  it 'fail with wrong url' do
    tested_url = "dffgfgg"
    expect{Link.encode(tested_url)}.to raise_error(ActiveRecord::RecordInvalid)
  end

end
