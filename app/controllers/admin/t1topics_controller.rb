class Admin::T1topicsController < ApplicationController
  before_action :set_t1topic, only: [:show, :edit, :update, :destroy]

  # GET /t1topics
  # GET /t1topics.json
  def index
    @t1topics = T1topic.all
  end

  # GET /t1topics/1
  # GET /t1topics/1.json
  def show
  end

  # GET /t1topics/new
  def new
    @t1topic = T1topic.new
  end

  # GET /t1topics/1/edit
  def edit
  end

  # POST /t1topics
  # POST /t1topics.json
  def create
    @t1topic = T1topic.new(t1topic_params)

    respond_to do |format|
      if @t1topic.save
        format.html { redirect_to admin_t1topic_url(@t1topic), notice: 'T1topic was successfully created.' }
        format.json { render :show, status: :created, location: @t1topic }
      else
        format.html { render :new }
        format.json { render json: @t1topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /t1topics/1
  # PATCH/PUT /t1topics/1.json
  def update
    respond_to do |format|
      if @t1topic.update(t1topic_params)
        format.html { redirect_to admin_t1topic_url(@t1topic), notice: 'T1topic was successfully updated.' }
        format.json { render :show, status: :ok, location: @t1topic }
      else
        format.html { render :edit }
        format.json { render json: @t1topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /t1topics/1
  # DELETE /t1topics/1.json
  def destroy
    @t1topic.destroy
    respond_to do |format|
      format.html { redirect_to admin_t1topics_url, notice: 'T1topic was successfully destroyed.' }
      format.json { head :no_content }
    end
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
