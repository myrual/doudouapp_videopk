class OpenbattlesController < ApplicationController
  before_action :set_t1topic, only: [:show]

  def index
    @t1topics = T1topic.all
    @t1topic = @t1topics.first
  end

  def show
    @t1topics = T1topic.all
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_t1topic
      @t1topic = T1topic.find(params[:id])
    end
end
