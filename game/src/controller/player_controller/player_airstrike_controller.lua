---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by majo.
--- DateTime: 23.06.22 22:23
---

local PlayerAirStrikeController = {}

function PlayerAirStrikeController.strike()


  if love.keyboard.isDown("f2")  and Player.number_cool_down <= 0 then

    local mx = love.mouse.getX() + GameData.settings.screen_x_view_factor
    local my = love.mouse.getY() + GameData.settings.screen_y_view_factor
    -- todo : make his aircraft fly over the screen
    --        just before dropping the bombs
    GameData.aircraft = {x = mx,y = my
    }
    ExplosionController.explosion(
      mx,
      my,
      100,
      400
    )
    ExplosionController.explosion(
      mx +  300,
      my,
      100,
      400
    )
    WaveGame.delay(function()
      ExplosionController.explosion(
        mx + 300,
        my + 100,100,
        400)
    end, 0.5)

    WaveGame.delay(function()
      ExplosionController.explosion(
        mx + 100,
        my + 100,100,
        400)
    end, 0.5)

    WaveGame.delay(function()
      ExplosionController.explosion(
        mx + 400,
        my + 200,100,
        400)
    end, 1)

    WaveGame.delay(function()
      ExplosionController.explosion(
        mx + 200,
        my + 200,100,
        400)
    end, 1)

    WaveGame.delay(function()
      ExplosionController.explosion(
        mx + 300,
        my + 300,100,
        400)
    end, 1.5)

    WaveGame.delay(function()
      ExplosionController.explosion(
        mx + 600,
        my + 300,100,
        400)
    end, 1.5)

    WaveGame.delay(function()
      ExplosionController.explosion(
        mx + 400,
        my + 400,100,
        400)
    end, 2)
    WaveGame.delay(function()
      ExplosionController.explosion(
        mx + 700,
        my + 400,100,
        400)
    end, 2)


    Player.number_cool_down = 0.3
  end

end

return PlayerAirStrikeController