mod_gui = require("mod-gui")
require "fli/fli"

local picker_dollies_names = {}

local function picker_dollies_moved(event)
    if not event.moved_entity or not event.moved_entity.valid then return end
    if not picker_dollies_names[event.moved_entity.name] then return end

    move_textbox(event.moved_entity)
end

local function picker_dollies_init()
    if remote.interfaces['PickerDollies'] then
        script.on_event(remote.call('PickerDollies', 'dolly_moved_entity_id'), picker_dollies_moved)

        for _, name in pairs(fluidentities) do
            picker_dollies_names[name] = true
        end
    end
end

script.on_event(defines.events.on_built_entity, function(event) placedfli(event.entity) end)
script.on_event(defines.events.on_robot_built_entity, function(event) placedfli(event.entity) end)
script.on_event(defines.events.script_raised_built, function(event) placedfli(event.entity) end)
script.on_event(defines.events.script_raised_revive, function(event) placedfli(event.entity) end)
script.on_event(defines.events.on_entity_cloned, function(event) placedfli(event.destination) end)

script.on_event(defines.events.on_pre_player_mined_item, function(event) removedfli(event.entity) end)
script.on_event(defines.events.on_robot_pre_mined, function(event) removedfli(event.entity) end)
script.on_event(defines.events.on_entity_died, function(event) removedfli(event.entity) end)
script.on_event(defines.events.script_raised_destroy, function(event) removedfli(event.entity) end)

script.on_event(defines.events.on_pre_chunk_deleted, function(event)
    local surface = game.surfaces[event.surface_index]
    for _,chunk in pairs(event.positions) do
      local x = chunk.x
      local y = chunk.y
      local area = {{x*32,y*32},{31+x*32,31+y*32}}
      for _,ent in pairs(surface.find_entities_filtered{name = fluidentities,area = area}) do
        removedfli(ent)
      end
    end
end)

script.on_event(defines.events.on_pre_surface_cleared,function(event)
    local surface = game.surfaces[event.surface_index]
    for _,ent in pairs(surface.find_entities_filtered(surface.find_entities_filtered({name = fluidentities}))) do
        removedfli(ent)
    end
end)

script.on_event(defines.events.on_pre_surface_deleted,function(event)
    local surface = game.surfaces[event.surface_index]
    for _,ent in pairs(surface.find_entities_filtered(surface.find_entities_filtered({name = fluidentities}))) do
        removedfli(ent)
    end
end)

script.on_configuration_changed(function(data)
    storage.flis = {}
    storage.flitexts = {}
    storage.flidig1 = {}
    storage.flidig10 = {}
    storage.flidig100 = {}
    storage.flidigpc = {}
    storage.fliindex = 1
    if storage.flitype == nil then
        -- to keep settings
        storage.flitype = {}
    end
    storage.currentfliunitnumber = nil
    register_flis()
end)

script.on_init(function() 
    storage.flis = {}
    storage.flitexts = {}
    storage.flidig1 = {}
    storage.flidig10 = {}
    storage.flidig100 = {}
    storage.flidigpc = {}
    storage.fliindex = 1
    storage.flitype = {}
    storage.currentfliunitnumber = nil

    picker_dollies_init()
    end)

script.on_load(function()
    picker_dollies_init()
end)

script.on_event(defines.events.on_tick, flion_tick)

script.on_event(defines.events.on_gui_selection_state_changed, function(event)
    local player = game.players[event.player_index]
    if (event.element.name == "fli_dropdown") then
        set_fli_type(event)
    end
end)

script.on_event(defines.events.on_gui_opened, function(event)
    local player = game.players[event.player_index]
    local ent = event.entity
    if (event.gui_type == defines.gui_type.entity) and ((ent.name == "fluid-level-indicator") or (ent.name == "fluid-level-indicator-straight") or (ent.name == "fluid-level-indicator-k2") or (ent.name == "fluid-level-indicator-straight-k2") or (ent.name == "fluid-level-indicator-st-bobs-steel") or (ent.name == "fluid-level-indicator-st-bobs-plastic") or (ent.name == "fluid-level-indicator-st-bobs-tungsten") or (ent.name == "fluid-level-indicator-st-bobs-coppertungsten")) then
        open_fli_gui(player, ent)
    end
end)

script.on_event(defines.events.on_gui_closed, function(event)
    local player = game.players[event.player_index]
    local ent = event.entity
    if (event.gui_type == defines.gui_type.entity) and ((ent.name == "fluid-level-indicator") or (ent.name == "fluid-level-indicator-straight") or (ent.name == "fluid-level-indicator-k2") or (ent.name == "fluid-level-indicator-straight-k2") or (ent.name == "fluid-level-indicator-st-bobs-steel") or (ent.name == "fluid-level-indicator-st-bobs-plastic") or (ent.name == "fluid-level-indicator-st-bobs-tungsten") or (ent.name == "fluid-level-indicator-st-bobs-coppertungsten")) then
        close_fli_gui(player, ent)
    end
end)