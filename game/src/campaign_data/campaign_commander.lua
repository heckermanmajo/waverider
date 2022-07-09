local CampaignCommander = {}



---@class CampaignCommander
---@field current_x_pos number  -- x pos on big world, tile is inferred by this var
---@field current_y_pos number  -- y pos on big world, tile is inferred by this var
---@field name
---@field display_name
---@field description string Each commander has a little backstory
---@field knowledge_of_war
---@field knowledge_of_religion
---@field knowledge_of_economics
---@field possessions
---@field mana
---@field faith
---@field health
---@field fear_values table<string, number> Race name mapped on the fear value
---@field honor_values table<string, number> Race name mapped on the honor value
---@field prestige_values table<string, number> Race name mapped on the Prestige value
---@field diplomacy_skill number
---@field administration_skill number
---@field faction string
---@field campaign_texture string the path to te texture this commander uses on the campaign map
---@field follower table<string> Other commanders which follow this commander
---@field prisoner_tile CampaignTile The tile this commander is prisoner in
---@field cross_water_skill number This number determines if and how fast a commander with his army can cross a water tile

function CampaignCommander:new()

end


--- read the mobs from file and return the mob array
------ Use GameData.path_to_current_game_files
----- @see GameData.path_to_current_game_files
function CampaignCommander.get_mobs()
  
end

--- Write a given mob into the mob file of this commander
--- Use GameData.path_to_current_game_files
--- @see GameData.path_to_current_game_files
function CampaignCommander.add_mob()

end

--- Write the given mobs into the file of this commander
--- Use GameData.path_to_current_game_files
--- @see GameData.path_to_current_game_files
function CampaignCommander.set_mobs()
  
end


return CampaignCommander