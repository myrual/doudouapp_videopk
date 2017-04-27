if @battle.present?
  json.extract! @latestBattle, :id, :title, :leftImage, :leftVideo, :rightImage, :rightVideo, :leftCount, :rightCount
else
  return "no battle"
end