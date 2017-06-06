require 'securerandom'
require 'net/http'                                              
class Api::V1::WxappauthsController < ApplicationController
    def json_request?
      request.format.json?
    end
    def index
        respond_to :json
        appid = 'wx094245cd07bbda82'
        appsecret = '8184ae4424fdd359de278e99474268e2'
        jscode = params["code"]
        rootURL = 'https://api.weixin.qq.com/sns/jscode2session?'
        uri = URI(rootURL + 'appid=' + appid + '&secret=' + appsecret + '&js_code=' + jscode + '&grant_type=authorization_code')
        res = Net::HTTP.get(uri)
        if res["openid"]
            result = {:status => "ReportInfo", :session => SecureRandom.uuid}
            render json: result
            #result = {:status => "ReportInfo", :session => SecureRandom.uuid}
        else
            result = {:status => "Error", :session => ""}
            render json: result
        end
    end
    private
    def verify_api_only
        params[:appid].present? and params[:appsecret].present?
    end
    def verify_user_only
        params[:user_id].present? and params[:user_token].present? and User.find(params[:user_id]).authentication_token == params[:user_token]
    end
end
