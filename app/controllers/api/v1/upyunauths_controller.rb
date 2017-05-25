require 'base64'                                              
require 'cgi'
require 'openssl'
class Api::V1::UpyunauthsController < ApplicationController
    skip_before_action :verify_authenticity_token, if: :json_request?
    
    def json_request?
      request.format.json?
    end
    def index
      
      if verify_api_only == true
        
        respond_to :json
        md5 = Digest::MD5.new
        md5.update ENV["UPYUN_OPERATOR_PASSWORD"] #update 又拍云的密码
        #md5.update 'grjxv2mxELR'
        data = params["data"]
        key = md5.hexdigest
        @result = Base64.encode64("#{OpenSSL::HMAC.digest('sha1', key, data)}") 
      else
        render status: :unauthorized
      end
    end
  private
  def verify_api_only
     params[:appid].present? and params[:appsecret].present?
  end
end
