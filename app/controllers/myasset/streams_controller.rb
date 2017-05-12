class Myasset::StreamsController < ApplicationController
  before_action :set_stream, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  layout "myasset"
  # GET /streams
  # GET /streams.json
  def index
    @streams = current_user.streams.all
  end

  # GET /streams/1
  # GET /streams/1.json
  def show
  end

  # GET /streams/new
  def new
    @stream = Stream.new
  end

  # GET /streams/1/edit
  def edit
  end

  # GET /streams/1/append
  def append
    @stream = Stream.find(params["stream_id"])
    @battles = current_user.battles.all.map { |v| [v.title, v.id] }
  end
  # POST /streams/1/appended
  def appended
    @stream = Stream.find(params["stream_id"])
    @battle = Battle.find(params["battle"])
    order = params["order"]
    @multivote = Multivote.new
    @multivote.stream = @stream
    @multivote.battle = @battle
    @multivote.order = order
    if @multivote.save
      redirect_to myasset_stream_url(@stream)
    else
      redirect_to myasset_streams_url
    end
  end

  # GET /streams/1/reordered
  def reorder
    @stream = Stream.find(params["stream_id"])
  end
  # POST /streams/1/reordered
  def reordered
    
    @stream = Stream.find(params["stream_id"])
    order = params["order"]
    if params["commit"] == "删除"
      multivote = @stream.multivotes.find_by(:battle_id => params["battle"])
      multivote.delete
      if @stream.multivotes.all.count > 0
        redirect_to myasset_stream_url(@stream)
      else
        redirect_to myasset_streams_url
      end
    else
      multivote = @stream.multivotes.find_by(:battle_id => params["battle"])
      multivote.order = order
      multivote.save
      redirect_to myasset_stream_url(@stream)
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
        format.html { redirect_to myasset_stream_url(@stream), notice: 'Stream was successfully created.' }
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
      format.html { redirect_to myasset_streams_url, notice: 'Stream was successfully destroyed.' }
      format.json { head :no_content }
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
end
