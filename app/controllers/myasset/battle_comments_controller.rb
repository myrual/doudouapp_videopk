class Myasset::BattleCommentsController < ApplicationController
  before_action :authenticate_user!
  #before_action :admin_required

  def index
    @battle = Battle.find(params[:battle_id])
    @comments = @battle.battle_comments.order('created_at DESC')
  end

  def edit
    @battle_comment = BattleComment.find(params[:id])
    @battle = Battle.find(params[:battle_id])
  end

  def update
    @battle_comment = BattleComment.find(params[:id])

    if @battle_comment.update(battle_comment_params)
      redirect_to admin_battle_battle_comments_path, notice: 'battle Comment updated!'
    else
      render :edit
    end
  end

  def destroy
    @battle_comment = BattleComment.find(params[:id])

    @battle_comment.destroy
    redirect_to admin_battle_battle_comments_path, alert: 'battle Comment deleted'
  end

  private
  def battle_comment_params
    params.require(:battle_comment).permit(:comment)
  end
end
