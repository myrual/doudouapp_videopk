class TopicsController < ApplicationController
  before_action :set_topic, only: [:show]

  # GET /topics/1
  # GET /topics/1.json
  def show
      @title = @topic.title
      @videoindex = params[:cur_videoid].to_i
      allvideo = @topic.videos.all
      if @videoindex
        @currentvideo = allvideo[@videoindex]
        @nextvideo = allvideo[@videoindex + 1]
        if @videoindex != 0
          @prevideo = allvideo[@videoindex - 1]
        end
      else
        @videoindex = 0
        @currentvideo = allvideo[@videoindex]
        @nextvideo = allvideo[@videoindex + 1]
      end
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_topic
      @topic = Topic.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def topic_params
      params.require(:topic).permit(:title, :running, :order, :t1topic)
    end
    def video_params
      params.require(:video).permit(:title, :description, :video, :image)
    end
end
