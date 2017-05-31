class Myasset::TopicsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_topic, only: [:show, :edit, :update, :destroy]

  # GET /topics/1
  # GET /topics/1.json
  def show
      @videos = @topic.videos.where(:user => current_user)
  end


  def newvideo
    @topic = Topic.find(params[:topic_id])
      @video = Video.new
  end
  # POST /topics/1/createvideo
  
  def createvideo
      video_topic = Topic.find(params[:topic_id])
      @video = current_user.videos.new(video_params)
      if @video.save
          @topic_video = current_user.topic_videos.new(video: @video, topic: video_topic)
          if @topic_video.save
          else
          end
          redirect_to myasset_topic_path(video_topic), notice: '视频上传成功!'
      else
        render :new
      end
  end
  # POST /topics
  # POST /topics.json
  def create
    @topic = Topic.new(topic_params)

    respond_to do |format|
      if @topic.save
        format.html { redirect_to admin_topic_url(@topic), notice: 'Topic was successfully created.' }
        format.json { render :show, status: :created, location: @topic }
      else
        format.html { render :new }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
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
