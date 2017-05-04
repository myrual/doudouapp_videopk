module ApplicationHelper
    def full_title()
        base_title = "吃饭，睡觉，打斗斗"
        if @title
            "斗斗" + " | " + @title
        else
            base_title
        end
    end
end
