class StreamsController < ApplicationController
  before_action :set_stream, only: [:show]


  # GET /streams/1
  # GET /streams/1.json
  def show
      debugger
      if !@stream.approved or !@stream.running
        redirect_to root_url
      end
  end

  # GET /streams/new
  def new
    @stream = Stream.new
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
