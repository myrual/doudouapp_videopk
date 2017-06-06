class Api::V1::StreamsController < ApplicationController
  skip_before_action :verify_authenticity_token, if: :json_request?
  before_action :set_stream, only: [:show, :vote_for_left, :vote_for_right, :invitechallenge]

  def json_request?
    request.format.json?
  end

  def index
    @streams = Stream.all
  end
  # GET /streams/1
  # GET /streams/1.json
  def show
      if !@stream.approved or !@stream.running
        render status: :no_content
      else
        battle_order = @stream.multivotes.all.sort_by{|bo| bo.order}
        available_battle = battle_order.select do |each| 
          !is_voted(Battle.find(each.battle_id))
        end
        @battles_in_stream = available_battle.map {|v| 
         b = Battle.find(v.battle_id)
         lvideo = Video.find(b.left_video_id)
         rvideo = Video.find(b.right_video_id)
         
         {:battle_id => b.id, :left_video_url => lvideo.video_url.to_s, :left_video_poster => lvideo.image.thumb.to_s,:right_video_url => rvideo.video_url.to_s, :right_video_poster => rvideo.image.thumb.to_s}
        }
      end
  end

  def invitechallenge
      if !@stream.approved or !@stream.running
        redirect_to root_url
      end
      @video = @stream.inside_videos.first
  end


  # GET /streams/new
  def new
    @stream = Stream.new
  end
  def vote_for_left
    @remainBattles = remain_battles_in_stream(@stream)
    @battle = @remainBattles.first
    battle = Battle.find(params["battle"])
    if current_user
      current_user.follow_left!(battle)
      flash[:warning] = "投票成功" if request.format.html?
      if @battle
        respond_to do |format|
          format.html {redirect_to :back}
          format.js
        end
      else
        if @stream.inside_videos.first
          redirect_to invitechallenge_stream_url(@stream)
        else
          redirect_to root_url
        end
      end
    else
      #visitor click left vote button
      visitorID = find_visitor_id
      newVote = battle.visitor_votes.build(visitorID:visitorID,voteLeft:true)
      flash[:warning] = "投票成功" if request.format.html?
      newVote.save
      if @battle
        respond_to do |format|
          format.html {redirect_to :back}
          format.js
        end
      else
        if @stream.inside_videos.first
          redirect_to invitechallenge_stream_url(@stream)
        else
          redirect_to root_url
        end
      end
    end
  end
  
  def vote_for_right
    @remainBattles = remain_battles_in_stream(@stream)
    @battle = @remainBattles.first
    battle = Battle.find(params["battle"])
    if current_user
      current_user.follow_right!(battle)
      if @battle
      flash[:warning] = "投票成功" if request.format.html?
        respond_to do |format|
          format.html {redirect_to :back}
          format.js
        end
      else
        if @stream.inside_videos.first
          redirect_to invitechallenge_stream_url(@stream)
        else
          redirect_to root_url
        end
      end
    else
      #visitor click left vote button
      visitorID = find_visitor_id
      newVote = battle.visitor_votes.build(visitorID:visitorID,voteLeft:false)
      newVote.save
      if @battle      
        flash[:warning] = "投票成功" if request.format.html?
        respond_to do |format|
          format.html {redirect_to :back}
          format.js
        end
      else
        if @stream.inside_videos.first
          redirect_to invitechallenge_stream_url(@stream)
        else
          redirect_to root_url
        end
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stream
      @stream = Stream.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def stream_params
      params.require(:stream).permit(:title, :content)
    end
  def find_visitor_id
    visitorID = ""
    if(visitor_id_incookie = cookies.signed[:doudouapp_vd])
      visitorID = visitor_id_incookie
    else
      visitorID = Time.now.to_s
      cookies.permanent.signed[:doudouapp_vd] = visitorID
    end
    visitorID
  end
  def right_is_voted(battle)
    if current_user
      current_user.has_follow_right?(battle)
    else
      visitorID = find_visitor_id
      battle.visitor_votes.find_by(visitorID:visitorID, voteLeft:false) != nil
    end
  end  
  def left_is_voted(battle)
    if current_user
      current_user.has_follow_left?(battle)
    else
      visitorID = find_visitor_id
      battle.visitor_votes.find_by(visitorID:visitorID, voteLeft:true) != nil
    end
  end
  def is_voted(battle)
    left_is_voted(battle) or right_is_voted(battle)
  end
  def remain_battles_in_stream(stream)
      battles_in_stream_inorder = stream.multivotes.all.sort_by{|bo| bo.order}
      remainbattles_in_stream_inorder = battles_in_stream_inorder.select do |battle_order|
        "#{battle_order.battle_id}" != params["battle"] and !is_voted(Battle.find(battle_order.battle_id))
      end
      remainbattles_in_stream_inorder.map {|v| Battle.find(v.battle_id)}
  end
    def verify_api_only
        Thirdapp.where(:appid => params[:appid], :secret => params[:appsecret]).count > 0
    end

end
