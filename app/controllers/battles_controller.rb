class BattlesController < ApplicationController
  before_action :authenticate_user!, only: [:follow_left_video, :unfollow_left_video, :follow_right_video, :unfollow_right_video]
  before_action :find_battle, only: [:follow_left_video, :unfollow_left_video, :follow_right_video, :unfollow_right_video]

  def index
    @battle = Battle.recent.first

    @left_video = Video.find(@battle.left_video_id)
    @right_video = Video.find(@battle.right_video_id)

    @left_video_comments = VideoComment.where(video_id: @battle.left_video_id).order("created_at DESC")
    @left_video_comment = VideoComment.new

    @right_video_comments = VideoComment.where(video_id: @battle.right_video_id).order("created_at DESC")
    @right_video_comment = VideoComment.new
  end

  def follow_left_video

    current_user.follow_left!(@battle)
    redirect_to :back
  end

  def unfollow_left_video
    current_user.unfollow_left!(@battle)
    redirect_to :back
  end

  def follow_right_video
    current_user.follow_right!(@battle)
    redirect_to :back
  end

  def unfollow_right_video
    current_user.unfollow_right!(@battle)
    redirect_to :back
  end

  private
  def find_battle
    @battle = Battle.find(params[:id])
  end
end
