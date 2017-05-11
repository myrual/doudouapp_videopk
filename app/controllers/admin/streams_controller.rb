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
