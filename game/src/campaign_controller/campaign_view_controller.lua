local CampaignViewController = {}

function CampaignViewController.init()

end

function CampaignViewController.update(delta_frame)

  if love.keyboard.isDown("right") then
    GameData.campaign_data.screen_x_view_factor = GameData.campaign_data.screen_x_view_factor + 1000 * delta_frame
  end

  if love.keyboard.isDown("left") then
    GameData.campaign_data.screen_x_view_factor = GameData.campaign_data.screen_x_view_factor - 1000 * delta_frame
  end

  if love.keyboard.isDown("down") then
    GameData.campaign_data.screen_y_view_factor = GameData.campaign_data.screen_y_view_factor + 1000 * delta_frame
  end

  if love.keyboard.isDown("up") then
    GameData.campaign_data.screen_y_view_factor = GameData.campaign_data.screen_y_view_factor - 1000 * delta_frame
  end

  if GameData.campaign_data.screen_y_view_factor < 0 then
    GameData.campaign_data.screen_y_view_factor = 0
  end

  if GameData.campaign_data.screen_x_view_factor < 0 then
    GameData.campaign_data.screen_x_view_factor = 0
  end

  if GameData.campaign_data.screen_x_view_factor > GameData.campaign_data.campaign_world_x - GameData.settings.screen_w then
    GameData.campaign_data.screen_x_view_factor = GameData.campaign_data.campaign_world_x - GameData.settings.screen_w
  end

  if GameData.campaign_data.screen_y_view_factor > GameData.campaign_data.campaign_world_y - GameData.settings.screen_h then
    GameData.campaign_data.screen_y_view_factor = GameData.campaign_data.campaign_world_y - GameData.settings.screen_h
  end

  if love.keyboard.isDown("g") then
    WaveGame.init()
    GameData.game_view_mode = "battle"
  end

  if love.keyboard.isDown("escape") then
    os.exit()
  end

  -- only if the mouse did not click on the minimap
  if (
    -- the minimap
    not (love.mouse.getX() > GameData.settings.screen_w - 600 and love.mouse.getY() > GameData.settings.screen_h - 600)
      and -- the selected tile rect with info
      not (GameData.campaign_data.selected_tile ~= nil and love.mouse.getY() > GameData.settings.screen_h - 400)
  )
  then

    -- select tile for details
    if love.mouse.isDown(1) and Player.number_cool_down <= 0 then

      local x = love.mouse.getX() + GameData.campaign_data.screen_x_view_factor
      -- fixme: why - 32 ????
      local y = love.mouse.getY() + GameData.campaign_data.screen_y_view_factor - 32

      local tile = CampaignTile:get(x, y)
      --print(GameData.campaign_data.screen_x_view_factor)
      --print(GameData.campaign_data.screen_y_view_factor)

      GameData.campaign_data.selected_tile = tile
      Player.number_cool_down = 0.1
    end
  end

  if love.mouse.isDown(2) and Player.number_cool_down <= 0 then
    GameData.campaign_data.selected_tile = nil
  end

  --- click in the mini map ports the player view there
  -- todo

  --[[
     Normal should display the commander and the terrain and the state and the banner of the owner faction
     On each tile can be 2 commanders: This would result in a battle
     owner relation shows if the owner likes your faction or not
     details show the strength of the garrison, the happiness of the people and the available resources
  ]]
  if love.keyboard.isDown("v") and Player.number_cool_down <= 0 then
    print(GameData.campaign_data.tile_view_mode)
    if GameData.campaign_data.tile_view_mode == "details" then
      GameData.campaign_data.tile_view_mode = "normal"
    elseif GameData.campaign_data.tile_view_mode == "normal" then
      GameData.campaign_data.tile_view_mode = "owner_relation"
    elseif GameData.campaign_data.tile_view_mode == "owner_relation" then
      GameData.campaign_data.tile_view_mode = "details"
    end
    Player.number_cool_down = 0.2
  end

  if love.mouse.isDown("1") and love.mouse.getX() > GameData.settings.screen_w - 600 and
    love.mouse.getY() > GameData.settings.screen_h - 600 and Player.number_cool_down <= 0 then

    local x = love.mouse.getX() - (GameData.settings.screen_w - 600)
    local y = love.mouse.getY() - (GameData.settings.screen_h - 600)
    local tile_x = math.floor(x / 3) * 64
    local tile_y = math.floor(y / 3) * 64

    local tile = CampaignTile:get(tile_x, tile_y)

    -- set tile in center of screen
    GameData.campaign_data.screen_x_view_factor = tile.x - GameData.settings.screen_w / 2
    GameData.campaign_data.screen_y_view_factor = tile.y - GameData.settings.screen_h / 2

    Player.number_cool_down = 0.2
  end


end

function CampaignViewController.draw()
  CampaignTile:draw_all()

  love.graphics.print("Campaign Mode (g for progress)")

  --- the campaign basic hu
  love.graphics.setColor(0, 0, 1, 1)
  love.graphics.rectangle("fill", 0, 0, GameData.settings.screen_w, 96)
  --- minimap
  CampaignTile:minimap()
  --love.graphics.rectangle("fill",GameData.settings.screen_w-600,GameData.settings.screen_h- 600,600, 600)
  love.graphics.setColor(1, 1, 1, 1)

  --love.graphics.rectangle("line", 0, GameData.settings.screen_h - 400, GameData.settings.screen_w - 600, 400)


  if GameData.campaign_data.selected_tile ~= nil then
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.rectangle(
      "fill",
      0, GameData.settings.screen_h - 400, GameData.settings.screen_w - 600, 400
    )
    local base_y = GameData.settings.screen_h - 400

    love.graphics.setColor(1, 1, 1, 1)
    --- @type CampaignTile
    local tile = GameData.campaign_data.selected_tile

    love.graphics.print(tile.tile_type, 30, base_y + 30)
    love.graphics.print(tile.x, 30, base_y + 45)
    love.graphics.print(tile.y, 30, base_y + 60)
    love.graphics.print("Buildings: ".. tostring(#tile.buildings), 30, base_y + 75)
    love.graphics.print("Objects: ".. tostring(#tile.objects), 30, base_y + 90)
    love.graphics.print("Mobs: ".. tostring(#tile.mobs), 30, base_y +105)
    love.graphics.print("Index: "..tostring(CampaignTile.get_tile_index(tile.x, tile.y)), 30, base_y +120)
  end

  love.graphics.print("Food: 9999", 120, 30)
  love.graphics.print("Wood: 9990", 240, 30)
  love.graphics.print("Stone: 2356", 360, 30)
  love.graphics.print("copper: 3455", 480, 30)
  love.graphics.print("iron: 235", 600, 30)
  love.graphics.print("steel: 2343", 720, 30)
  love.graphics.print("gold: 444", 840, 30)
  love.graphics.print("magic ore: 8888", 960, 30)


end

return CampaignViewController