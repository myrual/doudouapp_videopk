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
          redirect_to myasset_videos_path, notice: '视频已创建!'
      else
        render :new
      end
    end
    
    def challenge
      @video = Video.new
      @targevideo = Video.find(params[:video_id])
    end
    def createchallenge
      toChallenge_video = Video.find(params[:video_id])
      @video = Video.create(video_params)
      @video.user = current_user
      if @video.save!
          newBattle = Battle.new
          newBattle.title = toChallenge_video.title
          newBattle.left_video_id = @video.id
          newBattle.right_video_id = toChallenge_video.id
          newBattle.is_hidden = false
          newBattle.user = current_user
          newBattle.save
          redirect_to battle_path(newBattle), notice: '比赛已创建!'
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
        redirect_to myasset_videos_path, notice: '视频已更新!'
      else
        render :edit
      end
    end

    def destroy
      @battles = Battle.where("left_video_id = ? OR right_video_id = ?", params[:id], params[:id])
      if @battles.present?
        redirect_to myasset_videos_path, alert: '视频已经被用于比赛， 不能直接删除！'
      else
        @video = Video.find(params[:id])
        @video.destroy
        redirect_to myasset_videos_path, alert: '视频已删除！'
      end
    end

    private
    def video_params
      params.require(:video).permit(:title, :description, :video, :image)
    end
end
