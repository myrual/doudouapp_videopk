module ApplicationHelper
    def full_title()
        base_title = "吃饭，睡觉，打斗斗"
        if @title
            "斗斗" + " | " + @title
        else
            base_title
        end
    end
  def right_is_voted(battle)
    if current_user
      current_user.has_follow_right?(battle)
    else
      visitorID = find_visitor_id
      battle.visitor_votes.find_by(visitorID:visitorID, voteLeft:false) != nil
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
    left_is_voted(battle) or right_is_voted(battle)
  end
end
