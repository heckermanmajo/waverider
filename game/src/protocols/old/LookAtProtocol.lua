---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by majo.
--- DateTime: 21.06.22 12:04
---

--- @class LootAtInstance
--- @field rotation
--- @field x
--- @field y

--- @param instance LootAtInstance
--- Chnageb the direction to the target pos
function LootAtProtocol(instance, target_x, target_y)

  instance.rotation = Utils.get_rotation(instance.x, instance.y, target_x, target_y)

end