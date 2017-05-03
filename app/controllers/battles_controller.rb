class BattlesController < ApplicationController
  before_action :authenticate_user!, only: [:follow_left_video, :unfollow_left_video, :follow_right_video, :unfollow_right_video]
  before_action :find_battle, only: [:follow_left_video, :unfollow_left_video, :follow_right_video, :unfollow_right_video, :visitor_vote_left, :visitor_vote_right, :undo_visitor_vote_right, :undo_visitor_vote_left
  
  ]

  def index
    #@battle = Battle.published.recent.first
    @battles = Battle.published.recent.paginate(:page => params[:page], :per_page => 3)


    # if @battle.present?
    # @left_video = Video.find(@battle.left_video_id)
    # @right_video = Video.find(@battle.right_video_id)

    # @left_video_comments = VideoComment.where(video_id: @battle.left_video_id).order("created_at DESC")
    # @left_video_comment = VideoComment.new
    #
    # @right_video_comments = VideoComment.where(video_id: @battle.right_video_id).order("created_at DESC")
    # @right_video_comment = VideoComment.new

    #@battle_comments = BattleComment.where(battle_id: @battle.id)
    @battle_comment = BattleComment.new
    #end
  end

  def follow_left_video
    if current_user.has_follow_right?(@battle)
      flash[:warning] = "已经给右边视频投票！不能同时投两边！"
    else
    flash[:warning] = "投票成功"
      current_user.follow_left!(@battle)
    end
    redirect_to :back
  end

  def unfollow_left_video
    current_user.unfollow_left!(@battle)
    redirect_to :back
  end

  def follow_right_video
    if current_user.has_follow_left?(@battle)
      flash[:warning] = "已经给左边视频投票！不能同时投两边！"
    else
    flash[:warning] = "投票成功"
      current_user.follow_right!(@battle)
    end
    redirect_to :back
  end

  def unfollow_right_video
    current_user.unfollow_right!(@battle)
    redirect_to :back
  end

  def visitor_vote_right
    visitorID = ""
    if(visitor_id_incookie = cookies.signed[:visitorID])
      visitorID = visitor_id_incookie
    else
      visitorID = Time.now.to_s
      cookies.permanent.signed[:visitorID] = visitorID
    end
    flash[:warning] = "投票成功"

    thisVote = @battle.visitor_votes.build(visitorID:visitorID,voteLeft:false)
    #thisVote = VisitorVote.create(battle:@battle, visitorID:visitorID,voteLeft:false)  
    thisVote.save
    redirect_to root_path
  end
  def visitor_vote_left
    visitorID = ""
    if(visitor_id_incookie = cookies.signed[:visitorID])
      visitorID = visitor_id_incookie
    else
      visitorID = Time.now.to_s
      cookies.permanent.signed[:visitorID] = visitorID
    end
    flash[:warning] = "投票成功"
    thisVote = @battle.visitor_votes.build(visitorID:visitorID,voteLeft:true)
    thisVote.save
    redirect_to root_path
  end
  def undo_visitor_vote_right
    visitorID = ""
    if(visitor_id_incookie = cookies.signed[:visitorID])
      visitorID = visitor_id_incookie
    else
      visitorID = Time.now.to_s
      cookies.permanent.signed[:visitorID] = visitorID
    end
    flash[:warning] = "后悔成功"
    thisVote = @battle.visitor_votes.find_by(visitorID:visitorID,voteLeft:false)
    thisVote.delete
    redirect_to root_path
  end
  def undo_visitor_vote_left
    visitorID = ""
    if(visitor_id_incookie = cookies.signed[:visitorID])
      visitorID = visitor_id_incookie
    else
      visitorID = Time.now.to_s
      cookies.permanent.signed[:visitorID] = visitorID
    end
    flash[:warning] = "后悔成功"
    thisVote = @battle.visitor_votes.find_by(visitorID:visitorID,voteLeft:true)
    thisVote.delete
    redirect_to root_path
  end
  def about
  end

  def contact
  end

  private
  def find_battle
    @battle = Battle.find(params[:id])
  end
end
