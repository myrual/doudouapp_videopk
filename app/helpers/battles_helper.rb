module BattlesHelper
  def render_left_width(battle)
    (battle.left_followers.count + battle.visitor_votes.where(voteLeft: true).count).to_f/total_votes(battle).to_f*100
  end

  def render_right_width(battle)
    (battle.right_followers.count + battle.visitor_votes.where(voteLeft: false).count).to_f/total_votes(battle).to_f*100
  end

   def total_votes(battle)
     battle.left_followers.count+battle.right_followers.count+battle.visitor_votes.where(voteLeft: true).count+battle.visitor_votes.where(voteLeft: false).count
   end
end
