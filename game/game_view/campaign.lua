local Campaign = {}


function Campaign.load(folder_path)
  CampaignLoadSaver.load()
  NextRoundController.init()
end


function Campaign.create_new_one()
  CampaignTile:create_from_image()

  ---@type CampaignTile
  local tile = CampaignTile.instances[1005]

  tile.mobs = {"text"}
  NextRoundController.init()
end



function Campaign.update(delta_frame)
  CampaignViewController.update(delta_frame)
  Player.number_cool_down = Player.number_cool_down- delta_frame
  NextRoundController.update(delta_frame)
end

function Campaign.draw(delta_frame)
  CampaignViewController.draw()
  NextRoundController.draw()
end

function Campaign.save()

end


return Campaign