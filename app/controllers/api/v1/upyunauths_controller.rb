require 'base64'                                              
require 'cgi'
require 'openssl'
class Api::V1::UpyunauthsController < ApplicationController
    def json_request?
      request.format.json?
    end
    def index
      
        respond_to :json
        md5 = Digest::MD5.new
        md5.update ENV["UPYUN_OPERATOR_PASSWORD"] #update 又拍云的密码
        #md5.update 'grjxv2mxELR'
        data = params["data"]
        key = md5.hexdigest
        @result = Base64.encode64("#{OpenSSL::HMAC.digest('sha1', key, data)}") 
    end
end
