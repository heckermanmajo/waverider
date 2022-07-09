---@class CampaignBuildingType Building in the campaign view, that can be converted into an rts building
--- @field scene_texture
--- @field icon_texture
--- @field max_health
--- @field name
--- @field

---@class CampaignBuilding Building in the campaign view, that can be converted into an rts building
--- @field type
--- @field x
--- @field y
--- @field health
--- @field

local CampaignBuilding = {
  types = {},
  instances = {}
}

--- load the different types from the data-folder
--- @see GameData.
function CampaignBuilding:init()

end

function CampaignBuilding:new()
  
end

function CampaignBuilding:load_all_instances_for_one_scene(x,y)

end

function CampaignBuilding:clear_current_instances()
  
end

return CampaignBuilding



