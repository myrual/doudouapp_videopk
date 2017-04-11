class VideoCommentsController < ApplicationController
  before_action :authenticate_user!
  def new
    @video_comment = VideoComment.new
  end

  def create
    @video_comment = VideoComment.create(video_comment_params)
    @video_comment.user = current_user

    # if params[:left_video_id].present?
    #   video = Video.find(params[:left_video_id])
    # elsif params[:right_video_id].present?
    #   video = Video.find(params[:right_video_id])
    # end
    video = Video.find(params[:video_id])
    @video_comment.video = video
    @video_comment.save

    redirect_to :back
  end

  private
  def video_comment_params
    params.require(:video_comment).permit(:comment)
  end
end
