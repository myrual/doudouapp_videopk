module ApplicationHelper
    def full_title(page_title = '')
        base_title = "吃饭，睡觉，打斗斗"
        if page_title.empty?
            base_title
        else
            base_title + " | " + page_title
        end
    end
end
