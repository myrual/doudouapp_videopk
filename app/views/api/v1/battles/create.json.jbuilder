if @battle.present?
    json.extract! @battle, :id
else
  return "no"
end
