class Myasset::VideosController < ApplicationController
    before_action :authenticate_user!

    layout "myasset"

    def index
      @videos = Video.where(user_id: current_user.id)

    end

    def show
      @video = Video.find(params[:id])
    end

    def new
      @video = Video.new
    end

    def create
      @video = Video.create(video_params)
      @video.user = current_user

      if @video.save!
        redirect_to myasset_videos_path, notice: 'Video Created!'
      else
        render :new
      end
    end

    def edit
      @video = Video.find(params[:id])
    end

    def update
      @video = Video.find(params[:id])

      if @video.update(video_params)
        redirect_to myasset_videos_path, notice: 'Video updated!'
      else
        render :edit
      end
    end

    def destroy
      @video = Video.find(params[:id])
      @video.destroy
      redirect_to myasset_videos_path, alert: 'Video deleted'
    end

    private
    def video_params
      params.require(:video).permit(:title, :description, :video, :image)
    end
end
