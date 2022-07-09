--- @class CampaignFaction
--- @field name
--- @field king string
--- @field sub_factions
--- @field color
--- @field direct_vassals
--- @field relations
--- @field short_desc
--- @field display_name
--- @field banner
--- @field possessions CampaignTile[]
--- @field races table[string]
local CampaignFaction = {}


function CampaignFaction:new()

end

function CampaignFaction.load_initial_factions_from_data()
    
end


function CampaignFaction.load_all_factions_from_save_game()

  --local raw_data = require()

  --for i=0, #raw_data do

    --- load all factions

  --end


end






return CampaignFaction