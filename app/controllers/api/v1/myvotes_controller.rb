class Api::V1::MyvotesController < ApplicationController
    skip_before_action :verify_authenticity_token, if: :json_request?
    
    def json_request?
      request.format.json?
    end
    def index
      if verify_api_only and verify_wxuser_only
        respond_to :json
        current_wxuser = User.find(params[:user_id])
        leftBattle = current_wxuser.favor_left_videos.all
        rightBattle = current_wxuser.favor_right_videos.all
        totalBattle  = leftBattle + rightBattle
        myVotedBattles = totalBattle.map {|each|
          {:id => each.id, :title => each.title}
        }
        render json: myVotedBattles
      else
        render status: :unauthorized
      end
    end

    private
    def video_params
      params.require(:video).permits(:title, :description)
    end
    def verify_api_only
        Thirdapp.where(:appid => params[:appid], :secret => params[:appsecret]).count > 0
    end
    def verify_wxuser_only
        thisUser = User.find(params[:user_id])
        wxappuserLogin =  thisUser and thisUser.provider == "wxapp" and wxapploginsession = Wxappsession.find_by(:openid => thisUser.uid) and wxapploginsession == params["sesson"]
        wxappuserLogin        
    end
  def verify_user_only
     params[:user_id].present? and params[:user_token].present? and User.find(params[:user_id]).authentication_token == params[:user_token]
  end
end
