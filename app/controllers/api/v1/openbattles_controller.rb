class Api::V1::OpenbattlesController < ApplicationController
    skip_before_action :verify_authenticity_token, if: :json_request?
    
    def json_request?
      request.format.json?
    end
    def index
      if verify_api_only
        respond_to :json
        @topics = Topic.all.map {|each|
          {:id => each.id, :title => each.title}
        }
      else
        render status: :unauthorized
      end
    end

    def show
      if verify_api_only == true
        respond_to :json
        current_wxuser = User.find(params[:user_id])
        each = current_wxuser.videos.find(params[:id])
          @video = {:id => each.id, :title => each.title, :user_id => each.user_id, :video_poster => each.poster_url,:video_url => each.unique_url}
      else
        render status: :unauthorized
      end

    end

    def create
      respond_to :json
      if verify_api_only and verify_wxuser_only
        current_wxuser = User.find(params[:user_id])
        @video = current_wxuser.videos.new
        @video.title = params["video_title"]
        @video.description = params["video_description"]
        if @video.save!
        else
          render :new
        end
      else
        render status: :unauthorized
      end

    end

    def update
      @video = Video.find(params[:id])

      if @video.update(video_params)
        redirect_to admin_videos_path, notice: '视频已更新!'
      else
        render :edit
      end
    end

    def addvideototopic
      respond_to :json
      if verify_api_only and verify_wxuser_only
        current_wxuser = User.find(params[:user_id])
        @video = current_wxuser.videos.find(params[:video_id])
        @video_topic = Topic.find(params[:topic_id])
        @topic_video = current_wxuser.topic_videos.new(video: @video, topic: @video_topic)
        if @topic_video.save
        else
        end
      else
        render status: :unauthorized
      end
    end
    
    
    def update_ext_video
      @video = Video.find(params[:id])
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
