class Myasset::T1topicsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_t1topic, only: [:show, :edit, :update, :destroy]

  # GET /t1topics
  # GET /t1topics.json
  def index
    @t1topics = T1topic.all
  end

  # GET /t1topics/1
  # GET /t1topics/1.json
  def show
    @topicsundert1 = @t1topic.topics.all
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_t1topic
      @t1topic = T1topic.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def t1topic_params
      params.require(:t1topic).permit(:title, :running, :order)
    end
end
