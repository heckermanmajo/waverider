---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by majo.
--- DateTime: 21.06.22 08:51
---

--- @class PickupObjectProtocolInstance
--- @field x
--- @field y
--- @field w
--- @field h
--- @field pickup_sound
--- @field callback function(actor)


--- @class PickupActorProtocolInstance
--- @field x
--- @field y
--- @field w
--- @field h

--- @param instance PickupObjectProtocolInstance
--- @param actor PickupActorProtocolInstance
---  use a callback for the action to be performed is the player pick it up
function PickupProtocol(instance, actor)

  -- todo: add asserts for the protocol

  if Utils.CheckCollision(
    instance.x,
    instance.y,
    instance.w,
    instance.h,
    actor.x,
    actor.y,
    actor.w,
    actor.h
  ) then
    instance.pickup_sound:stop()
    instance.pickup_sound:play()
    instance.callback(instance, actor)
  end

end

return PickupProtocol