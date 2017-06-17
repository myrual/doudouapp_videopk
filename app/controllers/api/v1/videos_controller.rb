class Api::V1::VideosController < ApplicationController
    skip_before_action :verify_authenticity_token, if: :json_request?
    
    def json_request?
      request.format.json?
    end
    def index
      if verify_api_only and verify_wxuser_only
        respond_to :json
        current_wxuser = User.find(params[:user_id])
        videos = current_wxuser.videos.all
        @videos = videos.map {|each|
          {:id => each.id, :title => each.title, :user_id => each.user_id, :video_poster => each.poster_url,:video_url => each.unique_url}
        }
      else
        render status: :unauthorized
      end
    end

    def show
      if verify_api_only == true
        respond_to :json
        each = Video.find(params[:id])
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
    
    def listallvideos
      if verify_api_only
         @videos = Video.all.map {|each|
           {:id => each.id, :title => each.title, :user_id => each.user_id, :origin_video_poster => each.image.thumb.to_s,:origin_video_url => each.video_url.to_s}
          }
      else
        render status: :unauthorized
      end
    end
    def video_convert_done
      @video = Video.find(params[:id])

      bucket_name = params["bucket_name"]
      path = params["path"]
      taskid = params["task_id"]
      description = params["description"]
      if description == "OK"
        @extvideo = ExtVideo.new
        if @video.ext_video
          @extvideo = @video.ext_video
        else
          @extvideo = ExtVideo.new
        end
        @extvideo.video = @video
        @extvideo.provider = "upyun"
        @extvideo.videourl = "http://"+bucket_name + ".b0.upaiyun.com" + path[0]
        @extvideo.posturl = params[:posturl]
        @extvideo.save
      end


    end


    def thumb_done
      @video = Video.find(params[:id])

      bucket_name = params["bucket_name"]
      path = params["path"]
      taskid = params["task_id"]
      description = params["description"]
      if description == "OK"
        if @video.ext_video
          @extvideo = @video.ext_video
          @extvideo.posturl = "http://"+bucket_name + ".b0.upaiyun.com" + path[0]
          @extvideo.save
        end
      end
    end

    def new_ext_video
      respond_to :json
      if verify_api_only and verify_wxuser_only
        @video = Video.find(params[:id])
        @extvideo = @video.build_ext_video
        @extvideo.provider = params[:provider]
        @extvideo.videourl = params[:videourl]
        @extvideo.posturl = params[:posturl]
        if @extvideo.save
          @extvideo
        else
          render status :no_content
        end
      else
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
