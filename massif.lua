--
-- 8 resonant peaks
--
-- be careful with the 
-- amp settings
--
-- use the param menu to 
-- map things to an external
-- controller
--

engine.name = "ResonatorBank"
local MU = require "musicutil"

local current_res = 1

local mode = 0 -- 0 = play, 1 = edit
local alt = false
local midi_tune = false

local dirty = true

local scale_options = {}


local function pitch_tune(freq)
  -- set the freq of the currently selected resonator
  -- only relevant in edit mode
  params:set("freq" .. current_res, freq)
end


local function pitch_multi_tune(freq)
  -- set the freqs of the entier bank
  -- use musicutils to get the closest midi note
  -- treat this as the root and tune the resonators to a scale
  local note = MU.freq_to_note_num(freq)
  local scale = MU.generate_scale_of_length(note, params:get("scale"), 32)
  
  for i = 1, 8 do
    local n = math.random(1, #scale)
    local f = MU.note_num_to_freq(scale[n])

    params:set("freq" .. i, f)
  end
end


function init()
  m = midi.connect()
  m.event = midi_event
  
  for _, v in ipairs(MU.SCALES) do
    table.insert(scale_options, v.name)
  end
  --params:add_control("amp", "amp", controlspec.new(0.0, 1.0, "lin", 0.01, .05))
  --params:set_action("amp", function(v) engine.amp(v) end)
  params:add_separator()
    
  params:add_group("tuning", 8)
  params:add_control("freq1", "freq1", controlspec.new(20, 10000, "lin", 1, 50, "hz"))
  params:set_action("freq1", function(v) engine.freq1(v) dirty = true end)

  params:add_control("freq2", "freq2", controlspec.new(20, 10000, "lin", 1, 110, "hz"))
  params:set_action("freq2", function(v) engine.freq2(v) dirty = true end)
  
  params:add_control("freq3", "freq3", controlspec.new(20, 10000, "lin", 1, 220, "hz"))
  params:set_action("freq3", function(v) engine.freq3(v) dirty = true end)
  
  params:add_control("freq4", "freq4", controlspec.new(20, 10000, "lin", 1, 500, "hz"))
  params:set_action("freq4", function(v) engine.freq4(v) dirty = true end)
  
  params:add_control("freq5", "freq5", controlspec.new(20, 10000, "lin", 1, 1100, "hz"))
  params:set_action("freq5", function(v) engine.freq5(v) dirty = true end)
  
  params:add_control("freq6", "freq6", controlspec.new(20, 10000, "lin", 1, 2200, "hz"))
  params:set_action("freq6", function(v) engine.freq6(v) dirty = true end)
  
  params:add_control("freq7", "freq7", controlspec.new(20, 10000, "lin", 1, 5200, "hz"))
  params:set_action("freq7", function(v) engine.freq7(v) dirty = true end)
  
  params:add_control("freq8", "freq8", controlspec.new(20, 10000, "lin", 1, 11000, "hz"))
  params:set_action("freq8", function(v) engine.freq8(v) dirty = true end)

  params:add_group("amplitudes", 8)
  params:add_control("amp1", "amp1", controlspec.new(0, 1, "lin", 0.01, .15))
  params:set_action("amp1", function(v) engine.amp1(v) dirty = true end)
  
  params:add_control("amp2", "amp2", controlspec.new(0, 1, "lin", 0.01, .15))
  params:set_action("amp2", function(v) engine.amp2(v) dirty = true end)
  
  params:add_control("amp3", "amp3", controlspec.new(0, 1, "lin", 0.01, .15))
  params:set_action("amp3", function(v) engine.amp3(v) dirty = true end)
  
  params:add_control("amp4", "amp4", controlspec.new(0, 1, "lin", 0.01, .15))
  params:set_action("amp4", function(v) engine.amp4(v) dirty = true end)
  
  params:add_control("amp5", "amp5", controlspec.new(0, 1, "lin", 0.01, .15))
  params:set_action("amp5", function(v) engine.amp5(v) dirty = true end)
  
  params:add_control("amp6", "amp6", controlspec.new(0, 1, "lin", 0.01, .15))
  params:set_action("amp6", function(v) engine.amp6(v) dirty = true end)
  
  params:add_control("amp7", "amp7", controlspec.new(0, 1, "lin", 0.01, .15))
  params:set_action("amp7", function(v) engine.amp7(v) dirty = true end)
  
  params:add_control("amp8", "amp8", controlspec.new(0, 1, "lin", 0.01, .15))
  params:set_action("amp8", function(v) engine.amp8(v) dirty = true end)

  params:add_group("ring times", 8)
  params:add_control("ring1", "ring1", controlspec.new(0, 5, "lin", 0.01, .05))
  params:set_action("ring1", function(v) engine.ring1(v) dirty = true end) 
  
  params:add_control("ring2", "ring2", controlspec.new(0, 5, "lin", 0.01, .05))
  params:set_action("ring2", function(v) engine.ring2(v) dirty = true end)
  
  params:add_control("ring3", "ring3", controlspec.new(0, 5, "lin", 0.01, .05))
  params:set_action("ring3", function(v) engine.ring3(v) dirty = true end) 
  
  params:add_control("ring4", "ring4", controlspec.new(0, 5, "lin", 0.01, .05))
  params:set_action("ring4", function(v) engine.ring4(v) dirty = true end) 
  
  params:add_control("ring5", "ring5", controlspec.new(0, 5, "lin", 0.01, .05))
  params:set_action("ring5", function(v) engine.ring5(v) dirty = true end) 
  
  params:add_control("ring6", "ring6", controlspec.new(0, 5, "lin", 0.01, .05))
  params:set_action("ring6", function(v) engine.ring6(v) dirty = true end) 
  
  params:add_control("ring7", "ring7", controlspec.new(0, 5, "lin", 0.01, .05))
  params:set_action("ring7", function(v) engine.ring7(v) dirty = true end) 
  
  params:add_control("ring8", "ring8", controlspec.new(0, 5, "lin", 0.01, .05))
  params:set_action("ring8", function(v) engine.ring8(v) dirty = true end)

  params:add_separator("auto tune settings")
  params:add_option("scale", "scale", scale_options, 1)
  params:bang()
  
  local screen_metro = metro.init()
  screen_metro.time = 1/30
  screen_metro.event = function()
    if _menu.mode then dirty = true end
    redraw()
  end
  screen_metro:start()
  
  pitch_tracker = poll.set("pitch_in_l")
  pitch_tracker.callback = function(x)
    if x > 0 then

      if mode == 1 then
        --params:set("freq" .. current_page, x)
        pitch_tune(x)
      else
        pitch_multi_tune(x)
      end
    end
  end
end


function key(n, z)
  if n == 1 then alt = z == 1 and true or false end
  if alt then
    if n == 2 and z == 1 then
      mode = 0
    elseif n == 3 and z == 1 then
      mode = 1
    end
  else
    if mode == 1 then
      if n == 2 and z == 1 then 
        pitch_tracker:update()
      elseif n == 3 and z == 1 then
        midi_tune = z == 1 and true or false
      end
    elseif mode == 0 then
      if n == 2 and z == 1 then
        pitch_tracker:update()
      end
    end
  end
  dirty = true
end


function enc(n, d)
  if mode == 1 and alt then
    if n == 1 then
      current_res = util.clamp(current_res + d, 1, 8)
    end
  elseif mode == 1 then
    if n == 1 then
      params:delta("freq" .. current_res, d)
    elseif n == 2 then
      params:delta("amp" .. current_res, d)
    elseif n == 3 then
      params:delta("ring" .. current_res, d)
    end
  end
  dirty = true
end


local function draw_edit()
  screen.display_png("/home/we/dust/code/massif/assets/massif.png", 0, 0)
  screen.level(0)
  screen.move(64, 16)
  screen.font_size(24)
  screen.font_face(1)
  screen.text_center(current_res)
  screen.move(64, 22)
  screen.text_center(".................")
  screen.font_size(13)
  screen.font_face(29)
  screen.move(15, 36)
  screen.text("freq: ")
  screen.move(115, 36)
  screen.text_right(params:get("freq" .. current_res) .. " hz")
  screen.move(15, 48)
  screen.text("amp: ")
  screen.move(115, 48)
  screen.text_right(params:get("amp" .. current_res))
  screen.move(15, 60)
  screen.text("ring: ")
  screen.move(115, 60)
  screen.text_right(params:get("ring" .. current_res))
end


local function draw_play()
  screen.display_png("/home/we/dust/code/massif/assets/massif-4.png", 0, 0)
  screen.level(0)
  screen.font_size(13)
  screen.move(120, 60)
  screen.text_right("massif")
end


function redraw()
  screen.aa(1)
  if dirty then
    screen.clear()
    if mode == 1 then
      draw_edit()
    elseif mode == 0 then
      draw_play()
    end
  end
  screen.update()
  dirty = false
end


function midi_event(data)
  if #data == 0 then return end
  local msg = midi.to_msg(data)

  -- Note off
  if msg.type == "note_off" then
    --note_off(msg.note)

    -- Note on
  elseif msg.type == "note_on" then
    --print("yes")
    --note_on(msg.note, msg.vel / 127)
    if midi_tune == true then
      params:set("freq" .. current_res, MU.note_num_to_freq(msg.note))
    end
  end
end

