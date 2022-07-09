
--- @class CampaignMob
--- The campaign mob can be translated into a rts mob and reverse.
--- So the campaign mob is part of a tile as garrison or part on an army.
--- @field health
--- @field max_health
--- @field weapon
--- @field training_level
--- @field experience
--- @field armor
--- @field race
--- @field x
--- @field y
--- IMPORTANT: NO BODY IN THE CAMPAIGN IS ALLOWED TO HOLD A REFERENCE TO THIS


local CampaignMob = {
  instances = {},
}

function CampaignMob:new() end
function CampaignMob:load_all_instances_for_tile()end
function CampaignMob:clear_all_instances()end

return CampaignObject