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

  def self.generate_token len = 8
    a = lambda { rand(36).to_s(36) }
    token = ""
    len.times { |t| token << a.call.to_s }
    token
  end

  def self.generate_order_uuid
    Date.today.to_s.split('-').join()[2..-1] << generate_token(8).upcase
  end
end

