--[[
  The frame controller allows controlling the execution of update functions
  based on the current time.
]]
local FrameController = {
  counter_100 = 0,
  is_100 = false,
  counter_200 = 0,
  is_200 = false,
  counter_300 = 0,
  is_300 = false,
  counter_400 = 0,
  is_400 = false,
  counter_500 = 0,
  is_500 = false
}

function FrameController:update(delta_frame)
  self.counter_100 = self.counter_100 + delta_frame
  self.counter_200 = self.counter_200 + delta_frame
  self.counter_300 = self.counter_300 + delta_frame
  self.counter_400 = self.counter_400 + delta_frame
  self.counter_500 = self.counter_500 + delta_frame

  if self.counter_100 > 0.1 then
    counter_100 = true
    self.counter_100 = 0
  else
    self.counter_100 = false
  end

  if self.counter_200 > 0.2 then
    counter_200 = true
    self.counter_200 = 0
  else
    self.counter_200 = false
  end

  if self.counter_300 > 0.3 then
    counter_300 = true
    self.counter_300 = 0
  else
    self.counter_300 = false
  end

  if self.counter_400 > 0.4 then
    counter_400 = true
    self.counter_400 = 0
  else
    self.counter_400 = false
  end

  if self.counter_500 > 0.5 then
    counter_500 = true
    self.counter_500 = 0
  else
    self.counter_500 = false
  end
end

return FrameController

