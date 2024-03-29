class Api::V1::BattlesController < ApplicationController
  skip_before_action :verify_authenticity_token, if: :json_request?


  def json_request?
    request.format.json?
  end
  #before_action :authenticate_user!, only: [:follow_left_video, :unfollow_left_video, :follow_right_video, :unfollow_right_video]
  
  before_action :verify_api_only, only:[:index, :show]
  before_action :find_battle, only: [:follow_left_video, :unfollow_left_video, :follow_right_video, :unfollow_right_video, :get_battle]
  acts_as_token_authentication_handler_for User , only: [:follow_left_video, :unfollow_left_video, :follow_right_video, :unfollow_right_video, :get_battle]


  def index
    if verify_api_only == true
      respond_to :json
      battles = Battle.published.recent
      @battles = battles.map {|each|
        {:id => each.id, :title => each.title, :left_video_url => Video.find(each.left_video_id).video_url.to_s, :left_video_poster => Video.find(each.left_video_id).image.thumb.to_s,:right_video_url => Video.find(each.right_video_id).video_url.to_s, :right_video_poster => Video.find(each.right_video_id).image.thumb.to_s}
      }
    else
      render status: :unauthorized
    end
  end


  def show
    if verify_api_only == true
      respond_to :json
      each = Battle.find(params[:id])
      @battle = {:id => each.id, :title => each.title, :description => each.description,
      :left_video_id => each.left_video_id, 
      :right_video_id => each.right_video_id, 
      :left_video_url => Video.find(each.left_video_id).video_url.to_s, 
      :left_video_poster => Video.find(each.left_video_id).image.thumb.to_s,
      :right_video_url => Video.find(each.right_video_id).video_url.to_s, 
      :right_video_poster => Video.find(each.right_video_id).image.thumb.to_s}
    else
      render status: :unauthorized
    end
  end

  def create
    if verify_api_only == true and verify_user_only == true and video_present == true
      respond_to :json
      currentuser  = User.find(params["user_id"])
        
      @battle = currentuser.battles.new
      @battle.title = params["battle_title"]
      @battle.description = params["battle_description"]
      @battle.left_video_id = params["battle_left_video_id"]
      @battle.right_video_id = params["battle_right_video_id"]
      @battle.is_hidden = false

      if @battle.save!
        @battle
      else
        render status: :unauthorized
      end
    else
      render status: :unauthorized
    end
  end
  
  def follow_left_video
    respond_to :json
    if current_user.has_follow_right?(@battle)
      render json: {
        error: "already vote right, can not vote again",
        status: 400
      }

    elsif current_user.has_follow_left?(@battle)
      render json: {
        status: 204
      }
    else
      current_user.follow_left!(@battle)
      @left_video = Video.find(@battle.left_video_id)
      @right_video = Video.find(@battle.right_video_id)

      @latestBattle = {id:@battle.id, title:@battle.title, leftImage:@left_video.image.thumb.to_s, leftVideo:@left_video.video_url.to_s, rightImage:@right_video.image.thumb.to_s, rightVideo:@right_video.video_url.to_s, leftCount: @battle.left_followers.count, rightCount:@battle.right_followers.count,  status: 200}
      render json: @latestBattle
    end
  end

  def unfollow_left_video
    current_user.unfollow_left!(@battle)
      render json: {
        status: 200
      }
  end

  def follow_right_video
    respond_to :json
    if current_user.has_follow_left?(@battle)
      render json: {
        error: "already vote left, can not vote again",
        status: 400
      }
    elsif current_user.has_follow_right?(@battle)
      render json: {
        status: 204
      }
    else
      current_user.follow_right!(@battle)
      @left_video = Video.find(@battle.left_video_id)
      @right_video = Video.find(@battle.right_video_id)

      @latestBattle = {id:@battle.id, title:@battle.title, leftImage:@left_video.image.thumb.to_s, leftVideo:@left_video.video_url.to_s, rightImage:@right_video.image.thumb.to_s, rightVideo:@right_video.video_url.to_s, leftCount: @battle.left_followers.count, rightCount:@battle.right_followers.count,  status: 200}
      render json: @latestBattle
    end

  end

  def unfollow_right_video
    current_user.unfollow_right!(@battle)
      render json: {
        status: 200
      }
  end

  def about
  end

  def contact
  end

  def get_battle
    if verify_api_only == true
      respond_to :json
      @battle = Battle.find(params[:id])

      if @battle.present?
        @left_video = Video.find(@battle.left_video_id)
        @right_video = Video.find(@battle.right_video_id)

        @latestBattle = {id:@battle.id, title:@battle.title, leftImage:@left_video.image.thumb.to_s, leftVideo:@left_video.video_url.to_s, rightImage:@right_video.image.thumb.to_s, rightVideo:@right_video.video_url.to_s, leftCount: @battle.left_followers.count, rightCount:@battle.right_followers.count}
        # @left_video_comments = VideoComment.where(video_id: @battle.left_video_id).order("created_at DESC")
        # @left_video_comment = VideoComment.new
        #
        # @right_video_comments = VideoComment.where(video_id: @battle.right_video_id).order("created_at DESC")
        # @right_video_comment = VideoComment.new

        @battle_comments = BattleComment.where(battle_id: @battle.id)
        @battle_comment = BattleComment.new
        render json: @latestBattle
      end

    else
      render status: :unauthorized
    end
  end


  private
  def find_battle
    @battle = Battle.find(params[:id])
  end
  def verify_api_only
     params[:appid].present? and params[:appsecret].present?
  end
  def verify_user_only
     params[:user_id].present? and params[:user_token].present? and User.find(params[:user_id]).authentication_token == params[:user_token]
  end
  def video_present
    lv = params[:battle_left_video_id]
    rv = params[:battle_right_video_id]
    lv.present? and Video.find(lv).present? and rv.present? and Video.find(rv).present?
  end
end
