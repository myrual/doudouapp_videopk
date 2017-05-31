class Myasset::TopicsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_topic, only: [:show, :edit, :update, :destroy]

  # GET /topics/1
  # GET /topics/1.json
  def show
      @video = Video.new
  end


  # POST /topics/1/createvideo
  
  def createvideo
      video_topic = Topic.find(params[:topic_id])
      @video = Video.create(video_params)
      @video.user = current_user
      if @video.save!
          newBattle = Battle.new
          newBattle.title = toChallenge_video.title
          newBattle.left_video_id = @video.id
          newBattle.right_video_id = toChallenge_video.id
          newBattle.is_hidden = false
          newBattle.user = current_user
          newBattle.save
          redirect_to congratulation_battle_path(newBattle), notice: '比赛已创建!'
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
