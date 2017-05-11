class Myasset::MultivotesController < ApplicationController
  before_action :set_multivote, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  layout "myasset"
  # GET /multivotes
  # GET /multivotes.json
  def index
    @multivotes = Multivote.all
  end

  # GET /multivotes/1
  # GET /multivotes/1.json
  def show
  end

  # GET /multivotes/new
  def new
    @multivote = Multivote.new
    @streams = current_user.streams.all.map { |v| [v.title, v.id] }
    @battles = current_user.battles.all.map { |v| [v.title, v.id] }
  end

  # GET /multivotes/1/edit
  def edit
  end

  # POST /multivotes
  # POST /multivotes.json
  def create
    @multivote = Multivote.new(multivote_params)
    @multivote.user = current_user
    respond_to do |format|
      if @multivote.save
        format.html { redirect_to myasset_multivote_url(@multivote), notice: 'Multivote was successfully created.' }
        format.json { render :show, status: :created, location: @multivote }
      else
        format.html { render :new }
        format.json { render json: @multivote.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /multivotes/1
  # PATCH/PUT /multivotes/1.json
  def update
    respond_to do |format|
      if @multivote.update(multivote_params)
        format.html { redirect_to myasset_multivote_url(@multivote), notice: 'Multivote was successfully updated.' }
        format.json { render :show, status: :ok, location: @multivote }
      else
        format.html { render :edit }
        format.json { render json: @multivote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /multivotes/1
  # DELETE /multivotes/1.json
  def destroy
    @multivote.destroy
    respond_to do |format|
      format.html { redirect_to myasset_multivotes_url, notice: 'Multivote was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_multivote
      @multivote = Multivote.find(params[:id], )
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def multivote_params
      params.require(:multivote).permit(:battle_id, :stream_id)
    end
end
