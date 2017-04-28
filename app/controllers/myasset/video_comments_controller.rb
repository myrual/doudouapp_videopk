class Admin::VideoCommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_required

  def index
    @video = Video.find(params[:video_id])
    @comments = @video.video_comments.order('created_at DESC')
  end

  def edit
    @video_comment = VideoComment.find(params[:id])
    @video = Video.find(params[:video_id])
  end

  def update
    @video_comment = VideoComment.find(params[:id])

    if @video_comment.update(video_comment_params)
      redirect_to admin_video_video_comments_path, notice: 'Video Comment updated!'
    else
      render :edit
    end
  end

  def destroy
    @video_comment = VideoComment.find(params[:id])

    @video_comment.destroy
    redirect_to admin_video_video_comments_path, alert: 'Video Comment deleted'
  end

  private
  def video_comment_params
    params.require(:video_comment).permit(:comment)
  end

end
