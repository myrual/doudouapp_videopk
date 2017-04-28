class Admin::FavorLeftVideoRelationshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_required

  def index
    @favros_left_video = FavorLeftVideoRelationship.all
  end
end
