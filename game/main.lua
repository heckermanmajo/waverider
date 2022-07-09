--[[
  
  This is the main file for the wave rider games.

]]

function math.round(n, deci) deci = 10^(deci or 0) return math.floor(n*deci+.5)/deci end
function int(n)
  return math.floor(n+.5)
end


FrameController = require("src/frame_controller")
Utils = require "src/utils"
Ammo = require "src/ammo"
Zombie = require "src/Zombie"
Bullet = require "src/bullet"
Player = require "src/player"
Tower = require("src/tower")
FirstAid = require("src/first_aid")
Money = require("src/dataclass/money")
Trooper = require("src/dataclass/trooper")

NonInteractionObject = require("src/non_interaction_object")
GameData = require("game_data")
---
WaveGame = require("game_view/wave_game")
MainMenu = require("game_view/main_menu")
Campaign = require("game_view/campaign")
---
Button = require("src/ui/button")
Tile = require("src/core/Tile")
Item = require("src/core/Item")
Building = require("src/core/Building")
--Faction = require("src/core/Faction")
Mob = require("src/core/Mob")

-- InventoryItem = require("src/dataclass/InventoryItem")

--- require all protocols
CollisionProtocol = require("src/protocols/old/CollisionProtocol")
DrawProtocol = require("src/protocols/old/DrawProtocol")
FloatingProtocol = require("src/protocols/old/FloatingProtocol")
PickupProtocol = require("src/protocols/old/PickupProtocol")
LookAtProtocol = require("src/protocols/old/LookAtProtocol")

--- require the controller
NonInteractionObjectController = require("src/controller/non_interaction_object_controller")
ExplosionController = require("src/controller/weapon_controller/explosion_controller")
PlayerAirStrikeController = require("src/controller/player_controller/player_airstrike_controller")
MinimapController = require("src/controller/ui/minimap_controller")
ZombieSpawnController = require("src/controller/zombie_controller/zombie_spawn_controller")
ZombieWaveController = require("src/controller/zombie_controller/zombie_wave_controller")
--ZombieMoveController = require("src/controller/zombie_controller/zombie_move_controller")
--ZombieFightController = require("src/controller/zombie_controller/zombie_fight_controller")
InventoryController = require("src/controller/ui/inventory_controller")
PlayerPlaceBuildingsController = require("src/controller/player_controller/player_place_buildings_controller")

MobController = require("src/controller/mob_controller/MobController")

DebugController = require("src/controller/debug_controller/debug_controller")

--- Campaign
CampaignTile = require("src/campaign_data/campaign_tile")
CampaignViewController = require("src/campaign_controller/campaign_view_controller")
NextRoundController = require("src/campaign_controller/next_round_controller")
--- CampaignLoadSaver = require("src/campaign_controller/campaign_load_saver")

-- put stuff into the console
io.stdout:setvbuf('no')

local profile = require("lib/profile")

--[[
  LOVE LOAD
]]
function love.load()

  --profile.start()
  -- execute code that will be profiled

  love.audio.setVolume(0.3)
  love.window.setFullscreen(true, "desktop")
  love.window.setVSync(1)

  print("Load resources ...")

  for name, val in pairs(GameData.textures) do
    for _name, path in pairs(GameData.textures[name]) do
      GameData.textures[name][_name] = love.graphics.newImage(
        GameData.textures[name][_name]
      )
      print("Loaded " .. name .. " from '" .. path .. "'")
    end
  end

  for name, val in pairs(GameData.sounds) do
    for _name, path in pairs(GameData.sounds[name]) do
      GameData.sounds[name][_name] = love.audio.newSource(
        GameData.sounds[name][_name], "static"
      )
      print("Loaded " .. name .. " from '" .. path .. "'")
    end
  end

  font = love.graphics.newImageFont(
    "images/font.png",
    " abcdefghijklmnopqrstuvwxyz" ..
      "ABCDEFGHIJKLMNOPQRSTUVWXYZ0" ..
      "123456789.,!?-+/():;%&`'*#=[]\""
  )
  love.graphics.setFont(font)

  --Campaign.init("")

  love.mouse.setCursor(GameData.cursor.cursor_target, 16, 16)

end


--[[
  UPDATE FUNCTION
]]
--love.frame = 0
function love.update(delta_frame)
  --love.frame = love.frame + 1
  --if love.frame%100 == 0 then
  ----  love.report = love.profiler.report(20)
  -- love.profiler.reset()
  --end
  Button.update_all_buttons(delta_frame)
  if GameData.game_view_mode == "campaign" then
    Campaign.update(delta_frame)
  elseif GameData.game_view_mode == "battle" then
    WaveGame.update(delta_frame)
  elseif GameData.game_view_mode == "main_menu" then
    MainMenu.update(delta_frame)
  end



  --[[if love.keyboard.isDown("f12") then
    profile.stop()
    -- report for the top 10 functions, sorted by execution time
    print(profile.report(16))
    os.exit()
  end]]
end

local buffer = love.graphics.newCanvas(
  GameData.settings.screen_w +20,
  GameData.settings.screen_h
)

function love.draw()
  --love.graphics.setCanvas(buffer)
  --love.graphics.clear()
  if GameData.game_view_mode == "campaign" then
    Campaign.draw(delta_frame)
  elseif GameData.game_view_mode == "battle" then
    WaveGame.display(delta_frame)
  elseif GameData.game_view_mode == "main_menu" then
    MainMenu.display(delta_frame)
  end
  Button.draw_all_buttons(delta_frame)
  --love.graphics.setCanvas()
  --love.graphics.draw(buffer, 0,0)
end
