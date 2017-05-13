class Admin::StreamsController < ApplicationController
  before_action :set_stream, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :admin_required

  layout "admin"

  # GET /streams
  # GET /streams.json
  def index
    @streams_waiting_prove  = Stream.all.where(approved: false)
    @streams_proved  = Stream.all.where(approved: true)

  end

  # GET /streams/1
  # GET /streams/1.json
  def show
    @challenge_video = @stream.inside_videos.first
  end
  # GET /streams/1/edit
  def edit
  end
  
  # GET /stream/1/addvideo
  def addvideo
    @stream = Stream.find(params["id"])
    @videos = Video.all.map { |v| [v.title, v.id] }
  end
  def addvideodone
    @stream = Stream.find(params["id"])
    video = Video.find(params["video"])
    challengevideo = Challengevideo.new
    challengevideo.user = current_user
    challengevideo.stream = @stream
    challengevideo.video = video
    if challengevideo.save
      redirect_to admin_stream_url(@stream)
    else
      redirect_to admin_streams_url
    end
  end
  
  def editvideo
    @stream = Stream.find(params["id"])
    @videos = Video.all.map { |v| [v.title, v.id] }
  end
  def editvideodone
    @stream = Stream.find(params["id"])
    video_id = params["video"]
    challenge_video = @stream.challengevideos.first
    if params["commit"] == "删除"
      @stream.challengevideos.first.delete
    else
      challenge_video.video = Video.find(video_id)
      challenge_video.save
    end
    redirect_to admin_stream_url(@stream)
  end
  # GET /streams/1/append
  def append
    @stream = Stream.find(params["id"])
    battles_in_stream = @stream.inside_battles.all
    battles_all = current_user.battles.all
    battles_not_in_stream = battles_all.select do |battle|
      battles_in_stream.exclude? battle
    end
    @battles = battles_not_in_stream.map { |v| [v.title, v.id] }
  end
  # POST /streams/1/appended
  def appended
    @stream = Stream.find(params["id"])
    @battle = Battle.find(params["battle"])
    order = params["order"]
    @multivote = Multivote.new
    @multivote.stream = @stream
    @multivote.battle = @battle
    @multivote.order = order
    if @multivote.save
      redirect_to admin_stream_url(@stream)
    else
      redirect_to admin_streams_url
    end
  end

  # GET /streams/1/reordered
  def reorder
    @stream = Stream.find(params["id"])
  end
  # POST /streams/1/reordered
  def reordered
    
    @stream = Stream.find(params["id"])
    order = params["order"]
    if params["commit"] == "删除"
      multivote = @stream.multivotes.find_by(:battle_id => params["battle"])
      multivote.delete
      if @stream.multivotes.all.count > 0
        redirect_to admin_stream_url(@stream)
      else
        redirect_to admin_streams_url
      end
    else
      multivote = @stream.multivotes.find_by(:battle_id => params["battle"])
      multivote.order = order
      multivote.save
      redirect_to admin_stream_url(@stream)
    end
  end

  # POST /streams
  # POST /streams.json
  def create
    @stream = current_user.streams.new(stream_params)
    @stream.approved = false
    @stream.running = true
    

    respond_to do |format|
      if @stream.save
        format.html { redirect_to admin_stream_url(@stream), notice: 'Stream was successfully created.' }
        format.json { render :show, status: :created, location: @stream }
      else
        format.html { render :new }
        format.json { render json: @stream.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /streams/1
  # PATCH/PUT /streams/1.json
  def update
    respond_to do |format|
      if @stream.update(stream_params)
        format.html { redirect_to myasset_stream_url(@stream), notice: 'Stream was successfully updated.' }
        format.json { render :show, status: :ok, location: @stream }
      else
        format.html { render :edit }
        format.json { render json: @stream.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /streams/1
  # DELETE /streams/1.json
  def destroy
    @stream.destroy
    respond_to do |format|
      format.html { redirect_to admin_streams_url, notice: 'Stream was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def approve
    @stream = Stream.find(params[:id])
    @stream.approved = true
    @stream.save
    redirect_to :back
  end

  def rollback
    @stream = Stream.find(params[:id])
    @stream.approved = false
    @stream.save
    redirect_to :back
  end

  # GET /streams/new
  def new
    @stream = Stream.new
  end

  # GET /streams/1/edit
  def edit
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
end
