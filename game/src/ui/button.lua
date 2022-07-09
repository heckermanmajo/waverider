local Button={
  all_buttons={},
  --__index = Button
}

function Button.new(
  internal_label,
  text,
  callback,
  x_in_percent,
  y_in_percent,
  padding_in_px
)
  assert(x_in_percent <= 1)
  assert(y_in_percent <= 1)
  local font = love.graphics.getFont()
  local this={}
  this.text=text
  this.internal_label=internal_label
  this.callback=callback
  this.x=x_in_percent * GameData.settings.screen_w
  this.y=y_in_percent * GameData.settings.screen_h
  this.w=font:getWidth(this.text) + padding_in_px * 2
  this.h=font:getHeight() + padding_in_px * 2
  this.last_click=0
  -- i test all at 1900x1078, so adjust the text scale
  local my_scale=1  -- todo: find a good scale, and offer big, normal and small
  this.text_scale_x= my_scale * (GameData.settings.screen_h / GameData.settings.screen_w)
  this.text_scale_y= my_scale * (GameData.settings.screen_w / GameData.settings.screen_h)-- todo

  --local font = love.graphics.getFont()
  -- use this to put the text into the middle of the button
  table.insert(Button.all_buttons, this)
  setmetatable(this,Button)
  return this
end

function Button.update(self,delta_frame)
  self.last_click=self.last_click - 1
  if self.last_click <= 0 then
    if Utils.CheckCollision(
      love.mouse.getX(),
      love.mouse.getY(),
      3,
      3,
      self.x,
      self.y,
      self.w,
      self.h
    ) and love.mouse.isDown(1) then
      self.last_click=1
      self.callback()
    end
  end
end

function Button.draw(self, delta_frame)

  --love.graphics.setColor(1, 0, 0)

  love.graphics.rectangle(
    "fill",
    self.x,
    self.y,
    self.w,
    self.h
  )

  love.graphics.print(
    {{0,0,0},self.text},
    self.x,
    self.y,
    0,
    self.text_scale_x,
    self.text_scale_y
  )

end

function Button:destroy()
  table.remove(Button.all_buttons,self.internal_label)
end

function Button.clear_all_buttons()
  Button.all_buttons={}
end

function Button.update_all_buttons(delta_frame)
  for key,b in ipairs(Button.all_buttons) do
    Button.update(b,delta_frame)
  end
end

function Button.draw_all_buttons(delta_frame)

  for key,b in ipairs(Button.all_buttons) do
    Button.draw(b,delta_frame)
  end

end

return Button
