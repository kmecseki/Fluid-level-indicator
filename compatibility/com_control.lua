fluidentities = 
{
  "fluid-level-indicator",
  "fluid-level-indicator-straight"
}

if script.active_mods["Krastorio2"] then
  table.insert(fluidentities, 
  {
    "fluid-level-indicator-k2",
    "fluid-level-indicator-straight-k2"
  })
end

if script.active_mods["boblogistics"] then
  if settings.startup["bobmods-logistics-highpipes"].value == true then
    table.insert(fluidentities, 
    {
      "fluid-level-indicator-st-bobs-steel",
      "fluid-level-indicator-st-bobs-plastic",
    })
  end
end

if script.active_mods["boblogistics"] and mods["bobores"] and mods["bobplates"] then
  if settings.startup["bobmods-logistics-highpipes"].value == true then
    table.insert(fluidentities, 
    {
      "fluid-level-indicator-st-bobs-tungsten",
      "fluid-level-indicator-st-bobs-coppertungsten"
    })
  end
end
