module BattlesHelper
  def render_left_width(battle)
    (battle.left_followers.count).to_f/(battle.left_followers.count+battle.right_followers.count).to_f*100
  end

  def render_right_width(battle)
    (battle.right_followers.count).to_f/(battle.left_followers.count+battle.right_followers.count).to_f*100
  end
end
