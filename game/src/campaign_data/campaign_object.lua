---@class CampaignObject
--- IMPORTANT: NO BODY IN THE CAMPAIGN IS ALLOWED TO HOLD A REFERENCE TO THIS

local CampaignObject = {
  instances = {},
  types = {}
}


function CampaignObject:new() end
function CampaignObject:load_all_types_from_data_folder() end
function CampaignObject:load_all_instances_for_tile()end
function CampaignObject:clear_all_instances()end


return CampaignObject