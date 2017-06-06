require 'securerandom'
require 'net/http'
require 'json'
class Api::V1::WxappauthsController < ApplicationController
  skip_before_action :verify_authenticity_token, if: :json_request?

    def json_request?
      request.format.json?
    end
    
    def patchwxappuser
        if verify_api_only and verify_user_only and json_request?
            respond_to :json
            nickname = params["nickname"]
            avatarurl = params["avatarurl"]
            thisUser = User.find(params["user_id"])
            thisUser.name = nickname
            thisUser.current_sign_in_at = Time.now
            thisUser.save
            thisuseravatar = thisUser.useravatars.last
            if thisuseravatar
                thisuseravatar.url = avatarurl
                thisuseravatar.save
            else
                newuseravatar = thisUser.useravatars.new
                newuseravatar.url = avatarurl
                newuseravatar.save
            end
            result = {:status => "OK", :session => ""}
            render json: result
        else
            result = {:status => "Error", :session => ""}            
            render json: result
        end
    end
    
    def verifywxappuser
        if verify_api_only and verify_user_only and json_request?
            respond_to :json
            
            result = {:status => "OK", :user_id => User.find(params[:id])}
            render json: result
        else
            result = {:status => "Error", :session => ""}            
            render json: result
        end
    end
    
    def index
        if verify_api_only and json_request?
            respond_to :json
            appid = 'wx094245cd07bbda82'
            appsecret = '8184ae4424fdd359de278e99474268e2'
            jscode = params["code"]
            rootURL = 'https://api.weixin.qq.com/sns/jscode2session?'
            uri = URI(rootURL + 'appid=' + appid + '&secret=' + appsecret + '&js_code=' + jscode + '&grant_type=authorization_code')
            result = Net::HTTP.get(uri)
            res = JSON.parse(result)
            if res["openid"] and res["session_key"]
                oldsession = Wxappsession.find_by(:openid => res["openid"])
                if oldsession
                    oldsession.wxsession_key = res["session_key"]
                    oldsession.session = SecureRandom.uuid
                    olduser = User.find_by(:provider => "wxapp", :uid => res["openid"])
                    if oldsession.save
                        result = {:status => "ReportInfo", :session => oldsession.session, :user_id => olduser.id}
                        render json: result
                    else
                        result = {:status => "SaveSessionFailed", :session => ""}
                        render json: result
                    end

                else
                    new_wxsession = Wxappsession.new
                    new_wxsession.openid = res["openid"]
                    new_wxsession.wxsession_key = res["session_key"]
                    new_wxsession.session = SecureRandom.uuid
                    if new_wxsession.save
                        newuser = User.new
                        newuser.provider = "wxapp"
                        newuser.uid = new_wxsession.openid
                        newuser.email = SecureRandom.uuid + "@herego.com"
                        newuser.name = ""
                        newuser.password = Devise.friendly_token[0,20]
                        newuser.is_admin = false
                        newuser.save
                        result = {:status => "ReportInfo", :session => new_wxsession.session, :user_id => newuser.id}
                        render json: result
                    else
                        result = {:status => "SaveSessionFailed", :session => ""}
                        render json: result
                    end
                end
                #result = {:status => "ReportInfo", :session => SecureRandom.uuid}
            else
                result = {:status => "Error", :session => ""}
                render json: result
            end
        end
    end
    private
    def verify_api_only
        Thirdapp.where(:appid => params[:appid], :secret => params[:appsecret]).count > 0
    end
    def verify_user_only
        thisUser = User.find(params[:user_id])
        wxappuserLogin =  thisUser and thisUser.provider == "wxapp" and wxapploginsession = Wxappsession.find_by(:openid => thisUser.uid) and wxapploginsession == params["sesson"]
        wxappuserLogin        
    end
end
