class StreamsController < ApplicationController
  before_action :set_stream, only: [:show, :vote_for_left, :vote_for_right, :invitechallenge]


  # GET /streams/1
  # GET /streams/1.json
  def show
      if !@stream.approved or !@stream.running
        redirect_to root_url
      end
      battle_order = @stream.multivotes.all.sort_by{|bo| bo.order}
      @remainBattles = battle_order.map {|v| Battle.find(v.battle_id)}
      @battle = @remainBattles.first
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
        redirect_to invitechallenge_stream_url(@stream)
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
        redirect_to invitechallenge_stream_url(@stream)
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
        redirect_to invitechallenge_stream_url(@stream)
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
        redirect_to invitechallenge_stream_url(@stream)
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
    if(visitor_id_incookie = cookies.signed[:visitorID])
      visitorID = visitor_id_incookie
    else
      visitorID = Time.now.to_s
      cookies.permanent.signed[:visitorID] = visitorID
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
end
