require_relative "20170602031033_create_wechat_sessions"
class RemoveWechat < ActiveRecord::Migration[5.0]
  def change
    revert CreateWechatSessions
  end
end
