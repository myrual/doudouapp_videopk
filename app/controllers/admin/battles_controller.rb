class Admin::BattlesController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_required

  layout "admin"

  def index
    @battles = Battle.all
    @battles_waiting_prove = Battle.all.where(is_hidden: true)
    @battles_proved        = Battle.all.where(is_hidden: false)
    @streams_waiting_prove  = Stream.all.where(approved: false)
    @streams_proved  = Stream.all.where(approved: false)
  end

  def show
    @battle = Battle.find(params[:id])
    @left_video = Video.find(@battle.left_video_id)
    @right_video = Video.find(@battle.right_video_id)

    @left_followers = FavorLeftVideoRelationship.where(battle_id: @battle.id)
    @right_followers = FavorRightVideoRelationship.where(battle_id: @battle.id)
  end

  def publish
    @battle = Battle.find(params[:id])
    @battle.publish!
    redirect_to :back
  end

  def hidden
    @battle = Battle.find(params[:id])
    @battle.hide!
    redirect_to :back
  end

  private
  def battle_params
    params.require(:battle).permit(:title, :description, :left_video_id, :right_video_id)
  end
end
