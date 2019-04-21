require 'net/http'

class User < ApplicationRecord
  has_one :user_address
  has_many :orders

  module Level
    Ordinary = 16
    Admin = 32
  end
  
  def self.get_openid(code)
    uri = "https://api.weixin.qq.com/sns/jscode2session?appid=#{Rails.application.credentials.weixin_appid}&secret=#{Rails.application.credentials.weixin_secret}&js_code=#{code}&grant_type=authorization_code"
    response = Net::HTTP.get(URI(uri))
    ActiveSupport::JSON.decode(response)
  end

  def self.generate_token
    a = lambda { rand(36).to_s(36) }
    token = ""
    32.times { |t| token << a.call.to_s }
    token
  end
end

