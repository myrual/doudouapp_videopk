class Myasset::FavorRightVideoRelationshipsController < ApplicationController
  before_action :authenticate_user!
  #before_action :admin_required

  def index
    @favros_right_video = FavorRightVideoRelationship.all
  end
end
