--[[
  Basically every aspect in a game can
  be handeld ui-wise, with a button or multiple buttons.
  So A button is the only ui element we need, if we
  dont want to create a complex editor.

  But for a complex editor you would use
  nowerdays the web i guess.
]]


--- @class ButtonProtocolButton
--- @field x number
--- @field y number
--- @field onclick_callback function
--- @field button_image
--- @field button_hover_image
--- @field button_click_sound
--- @field button_disabled_image
--- @field button_disabled_click_sound
--- @field button_hide boolean
--- @field disabled boolean

---@param btn ButtonProtocolButton
function ButtonProtocolUpadte(btn, mx, my)

end

---@param btn ButtonProtocolButton
function ButtonProtocolDraw(btn, mx, my)

end