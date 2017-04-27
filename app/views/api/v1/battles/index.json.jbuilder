if @battle.present?
  json.extract! @latestBattle, :id, :title, :leftImage, :leftVideo, :rightImage, :rightVideo
else
  return "no battle"
end
