require 'uri'

class Link < ActiveRecord::Base
  ENCODE_BASE = '23456789abcdefghijklmnpqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ'

  validates :url, presence: true, format: {with: URI.regexp}

  def self.encode(url)
    begin
      link = find_or_create_by!(url: url.strip)
    rescue ActiveRecord::RecordNotUnique
      link = find_by(url: url.strip) # for handling a synchronous inserts the same urls
    end
    encode_number(link.id)
  end

  def self.decode(key)
    find_by(id: decode_number(key.strip)).try :url
  end

  private

  def self.encode_key
    return @encode_key if @encode_key

    key_file_name = '.encode_key'
    @encode_key = File.read(key_file_name) if File.exists?(key_file_name)
    if (@encode_key || '').empty?
      @encode_key = ENCODE_BASE.split('').shuffle.join
      File.write(key_file_name, @encode_key)
    end
    @encode_key
  end

  def self.encode_number(num)
    base = encode_key.size
    result = ''
    begin
      num, remainder = num / base, num % base
      result += encode_key[remainder]
    end while num > 0
    result
  end

  def self.decode_number(str)
    base = encode_key.size
    i = -1
    str.split('').inject(0) do |result, char|
      i += 1
      result + encode_key.index(char) * (base ** i)
    end
  end

  def url_mask
    @@url_mask ||= URI.regexp
  end

end
