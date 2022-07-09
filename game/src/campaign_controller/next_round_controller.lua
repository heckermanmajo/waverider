local NextRoundController = {}

function NextRoundController.init()

end

--- This function calls all needed to progress to the next round
function NextRoundController.update(delta_frame)

  if love.mouse.isDown("1") and Player.number_cool_down <= 0 and Utils.CheckCollision(
    love.mouse.getX(),
    love.mouse.getY(),
    3,
    3,
    1380,
    20,
    love.graphics.getFont():getWidth("Next Round => ") +  40,
    love.graphics.getFont():getHeight("Next Round => ") + 20
  ) then
    print("NEXT ROUND")
    Player.number_cool_down = 0.5
    GameData.campaign_data.round = GameData.campaign_data.round + 1
  end

end

function NextRoundController.draw()
  love.graphics.rectangle(
    "fill",
    1380, 20,
    love.graphics.getFont():getWidth("Next Round => ") +  40,
    love.graphics.getFont():getHeight("Next Round => ") + 20
  )
  love.graphics.setColor(0.7, 0.7, 0.7, 1)
  love.graphics.rectangle(
    "line",
    1380-1, 20-1,
    love.graphics.getFont():getWidth("Next Round => ") +  40+2,
    love.graphics.getFont():getHeight("Next Round => ") + 20+2
  )
  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.print("Next Round => ", 1400, 30)

  love.graphics.print("Current Round: "..tostring(GameData.campaign_data.round), 1600, 30)
end

return NextRoundController