module BattlesHelper
  def render_left_width(battle)
    (battle.left_followers.count + battle.visitor_votes.where(voteLeft: true).count).to_f/total_votes(battle).to_f*99
  end

  def render_right_width(battle)
    (battle.right_followers.count + battle.visitor_votes.where(voteLeft: false).count).to_f/total_votes(battle).to_f*99
  end

   def total_votes(battle)
     left_votes(battle) + right_votes(battle)
   end
   
   def left_votes(battle)
      battle.left_followers.count + battle.visitor_votes.where(voteLeft: true).count
   end
   def right_votes(battle)
      battle.right_followers.count + battle.visitor_votes.where(voteLeft: false).count
   end
  def right_is_voted(battle)
    if current_user
      current_user.has_follow_right?(battle)
    else
      visitorID = find_visitor_id
      battle.visitor_votes.find_by(visitorID:visitorID, voteLeft:false) != nil
    end
  end
  def is_my_battle(battle)
    if current_user
      current_user.battles.include?(battle)
    else
      false
    end
  end
  def left_is_voted(battle)
    if current_user
      current_user.has_follow_left?(battle)
    else
      visitorID = find_visitor_id
      battle.visitor_votes.find_by(visitorID:visitorID, voteLeft:true) != nil
    end
  end
  def is_voted(battle)
    left_is_voted(battle_params) or right_is_voted(battle)
  end
  def find_visitor_id
    visitorID = ""
    if(visitor_id_incookie = cookies.signed[:doudouapp_vd])
      visitorID = visitor_id_incookie
    else
      visitorID = Time.now.to_s
      cookies.permanent.signed[:doudouapp_vd] = visitorID
    end
    visitorID
  end
end
