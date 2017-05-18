class Api::V1::VideosController < ApplicationController
    skip_before_action :verify_authenticity_token, if: :json_request?
    
    def json_request?
      request.format.json?
    end
    def index
      if verify_api_only == true
        respond_to :json
        videos = Video.all
        @videos = videos.map {|each|
          {:id => each.id, :title => each.title, :user_id => each.user_id, :origin_video_poster => each.image.thumb.to_s,:origin_video_url => each.video_url.to_s}
        }
      else
        render status: :unauthorized
      end
    end

    def show
      if verify_api_only == true
        respond_to :json
        each = Video.find(params[:id])
          @video = {:id => each.id, :title => each.title, :user_id => each.user_id, :origin_video_poster => each.image.thumb.to_s,:origin_video_url => each.video_url.to_s}

      else
        render status: :unauthorized
      end

    end

    def create
      @video = Video.create(video_params)
      @video.user = current_user

      if @video.save!
        redirect_to admin_videos_path, notice: '视频已创建!'
      else
        render :new
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
    
    private
    def video_params
      params.require(:video).permit(:title, :description, :video, :image)
    end
  def verify_api_only
     params[:appid].present? and params[:appsecret].present?
  end
end
