local CampaignTile = {

  instances = {},

  minimap_canvas = love.graphics.newCanvas(600, 600),

  usable_tiles = 0
}

---@param tile CampaignTile
function CampaignTile.load_details(tile)
  local path = "ct_" .. tostring(tile.x) .. "_" .. tostring(tile.y).. ".lua"
  local rts_tile_map = require(path)
  tile.mobs = rts_tile_map.mobs
  tile.buildings = rts_tile_map.buildings
  tile.objects = rts_tile_map.objects
end

---@param tile CampaignTile
function CampaignTile.unload_details(tile)
  tile.mobs = {}
  tile.buildings = {}
  tile.objects = {}
  collectgarbage()
end


---@class CampaignTile Basically all data needed to create an rts map and to manage it from the campaign view
--- @field x
--- @field y
--- @field tile_type
--- @field buildings  table<string, CampaignBuilding> list of buildings with number
--- @field objects table<string, CampaignObject>
--- @field mobs table<string, CampaignMob>


--- todo: it is important to load and unload mobs objects and buildings
---       each tme we close the tile detail view
---       Otherwise we will use way to much memory at once

--- all campaign data about missions and maps are in th campaign tiles
--- Campaign tiles are 96 pixels
--- They are split into 4 fields, separated by the faction color
function CampaignTile:new(
  data
)
  local this = {}
  this.x = data.x
  this.y = data.y
  this.w = 64
  this.h = 64
  this.buildings = {}
  this.objects = {}
  this.mobs = {}
  -- can be: camp, village, alchemy_hut, war_camp
  -- chapel, church, monastery
  -- moth, castle, fortress
  -- town, big town, capital city
  this.state = "empty"

  this.tile_type = data.tile_type  --
  table.insert(self.instances, this)
end

function CampaignTile:create_from_image()
  --- read the campaign tiles from the default start file
  -- local tiles_from_file = require("data/default_campaign_tiles")
  --- a dict with the y row
  --- then the x row
  local map = love.image.newImageData("images/map.png")
  for px = 0, map:getWidth() - 1 do
    for py = 0, map:getHeight() - 1 do
      local r, g, b, a = map:getPixel(px, py)
      self.usable_tiles = self.usable_tiles + 1
      if a ~= 0 then
        if r == 215 / 255 and g == 204 / 255 and b == 26 / 255 then
          self:new({ x = px * 64, y = py * 64 + 100, tile_type = "sand" })
        elseif r == 90 / 255 and g == 1.0 and b == 160 / 255 then
          self:new({ x = px * 64, y = py * 64 + 100, tile_type = "step" })
        elseif r == 97 / 255 and g == 166 / 255 and b == 95 / 255 then
          self:new({ x = px * 64, y = py * 64 + 100, tile_type = "gras" })
        elseif r == 107 / 255 and g == 108 / 255 and b == 107 / 255 then
          self:new({ x = px * 64, y = py * 64 + 100, tile_type = "stone" })
        elseif r == 43 / 255 and g == 158 / 255 and b == 141 / 255 then
          self:new({ x = px * 64, y = py * 64 + 100, tile_type = "ice" })
        elseif r == 4 / 255 and g == 113 / 255 and b == 0 / 255 then
          self:new({ x = px * 64, y = py * 64 + 100, tile_type = "forest" })
        elseif r == 0. and g == 0. and b == 0. then
          self.usable_tiles = self.usable_tiles - 1
          self:new({ x = px * 64, y = py * 64 + 100, tile_type = "mountain" })
        else
          self:new({ x = px * 64, y = py * 64 + 100, tile_type = "gras" })
        end
      else
        self.usable_tiles = self.usable_tiles - 1
        self:new({ x = px * 64, y = py * 64 + 100, tile_type = "water" })
      end
    end
  end


  --print(self.usable_tiles)
  --os.exit()

  --for x=1, #tiles_from_file do
  --  for y = 1, #tiles_from_file[x] do
  --    local raw_tile_data = tiles_from_file[x][y]
  --   self:new(raw_tile_data)  end
  -- end
  --end

end




function CampaignTile:draw_all()

  -- todo: draw faction color around
  -- todo: draw the icons on at a time
  -- todo: display a commander unit if it stands on the tile

  local screen_collider = {
    x = GameData.campaign_data.screen_x_view_factor,
    y = GameData.campaign_data.screen_y_view_factor,
    w = GameData.settings.screen_w,
    h = GameData.settings.screen_h
  }

  for i = 1, #self.instances do

    local tile = self.instances[i]

    local texture = GameData.textures.campaign_tiles.gras_tile

    if Utils.collision(tile, screen_collider) then

      if tile.tile_type == "ice" then
        texture = GameData.textures.campaign_tiles.ice_tile
      end

      if tile.tile_type == "water" then
        texture = GameData.textures.campaign_tiles.water_tile
      end

      if tile.tile_type == "gras" then
        texture = GameData.textures.campaign_tiles.gras_tile
      end
      if tile.tile_type == "ice" then
        texture = GameData.textures.campaign_tiles.gras_tile
      end
      if tile.tile_type == "stone" then
        texture = GameData.textures.campaign_tiles.stone_tile
      end

      if tile.tile_type == "step" then
        texture = GameData.textures.campaign_tiles.step_tile
      end

      if tile.tile_type == "forest" then
        texture = GameData.textures.campaign_tiles.forest_tile
      end

      if tile.tile_type == "water" then
        texture = GameData.textures.campaign_tiles.water_tile
      end

      if tile.tile_type == "sand" then
        texture = GameData.textures.campaign_tiles.sand_tile
      end

      if tile.tile_type == "mountain" then
        texture = GameData.textures.campaign_tiles.mountain_tile
      end

      if GameData.campaign_data.tile_view_mode == "details" then
        -- todo: assemble the icons
        texture = GameData.textures.campaign_tiles.test_tile
      end

      love.graphics.draw(
        texture,
        tile.x - GameData.campaign_data.screen_x_view_factor,
        tile.y - GameData.campaign_data.screen_y_view_factor
      )

      love.graphics.rectangle(
        "line",
        tile.x  - GameData.campaign_data.screen_x_view_factor,
        tile.y  - GameData.campaign_data.screen_y_view_factor,
        64,
        64
      )

      if tile.tile_type ~= "water" and tile.tile_type ~= "mountain" then
        love.graphics.print(
          tile.state,
          tile.x+5 - GameData.campaign_data.screen_x_view_factor,
          tile.y+5 - GameData.campaign_data.screen_y_view_factor
        )
      end

      if GameData.campaign_data.tile_view_mode == "owner_relation" then
        -- todo: read the relation to all owners
        love.graphics.setColor(1, 0, 0, 0.4)
        love.graphics.rectangle(
          "fill",
          tile.x + 2 - GameData.campaign_data.screen_x_view_factor,
          tile.y + 2 - GameData.campaign_data.screen_y_view_factor,
          60,
          60
        )
        love.graphics.setColor(1, 1, 1, 1)
      end
    end
  end
end



--- @return CampaignTile
--- get the right tile y by x and y value (f.e. mouseclick)
function CampaignTile:get(x, y)
  --print(x)
  --print(y)
  local value = self.get_tile_index(x,y)
  --print(value)
  --os.exit()
  return self.instances[value]

end



function CampaignTile:minimap()
  -- add minimap mode owner and minimap mode terrain
  -- and highlight cities

  -- minimap mode: Ein Commander kann bis zu 5 fiefs verwalten,
  -- Map Modi: Einfärben nach fiefs, commander wer einen mag von ganz rot zu grün

  love.graphics.setCanvas(self.minimap_canvas)
  love.graphics.clear()

  -- todo: also apply who likes you in them minimpa
  -- todo: add current positon on minimap

  for i = 1, #self.instances do
    local tile = self.instances[i]
    ---love.graphics.setColor(0.5, 0.5, 0.5, 1)
    if tile.tile_type == "gras" then
      love.graphics.setColor(96 / 255, 166 / 255, 95 / 255, 1)
    elseif tile.tile_type == "ice" then
      love.graphics.setColor(43 / 255, 185 / 255, 141 / 255, 1)
    elseif tile.tile_type == "sand" then
      love.graphics.setColor(215 / 255, 204 / 255, 26 / 255, 1)
    elseif tile.tile_type == "step" then
      love.graphics.setColor(90 / 255, 255 / 255, 160 / 255, 1)
    elseif tile.tile_type == "mountain" then
      love.graphics.setColor(0, 0, 0, 1)
    elseif tile.tile_type == "stone" then
      love.graphics.setColor(107 / 255, 108 / 255, 107 / 255, 1)
    elseif tile.tile_type == "water" then
      love.graphics.setColor(0, 0, 1, 1)
    elseif tile.tile_type == "forest" then
      love.graphics.setColor(4 / 255, 133 / 255, 0, 1)
    end
    love.graphics.rectangle(
      "fill",
      tile.x / (64 / 3),
      (tile.y - 100) / (64 / 3),
      3,
      3
    )
  end
  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.setCanvas()
  love.graphics.draw(
    self.minimap_canvas,
    GameData.settings.screen_w - 600,
    GameData.settings.screen_h - 600
  )

  --- draw  the screen rect

  local width = GameData.settings.screen_w / (64 / 3)
  local height = GameData.settings.screen_h / (64 / 3)
  local x = GameData.campaign_data.screen_x_view_factor / (64 / 3) + GameData.settings.screen_w - 600
  local y = GameData.campaign_data.screen_y_view_factor / (64 / 3) + GameData.settings.screen_h - 600
  love.graphics.setColor(1, 1, 1, 1)

  love.graphics.rectangle("line", x, y, width, height)
  love.graphics.rectangle("line", x + 1, y + 1, width - 1, height - 1)

end


function CampaignTile.get_tile_index(x,y)
  return math.floor(
    math.floor(x / 64)
    * GameData.campaign_data.campaign_world_y / 64
    + math.floor(y / 64)
  )
end

return CampaignTile