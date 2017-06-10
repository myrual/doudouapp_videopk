if @extvideo.present?
    json.extract! @extvideo, :id
else
  return "no"
end