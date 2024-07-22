if mods["Krastorio2"] then
    require("compatibility/krastorio2/items.lua")
    require("compatibility/krastorio2/recipes.lua")
    require("compatibility/krastorio2/technologies.lua")
end


if mods["boblogistics"] then
    if settings.startup["bobmods-logistics-highpipes"] ~= nil then
        if settings.startup["bobmods-logistics-highpipes"].value == true then
            require("compatibility/bobsmods/boblogistics/items.lua")
            require("compatibility/bobsmods/boblogistics/recipes.lua")
            require("compatibility/bobsmods/boblogistics/technologies.lua")
        end
    end
end

if mods["boblogistics"] and mods["bobores"] and mods["bobplates"] then
    if settings.startup["bobmods-logistics-highpipes"] ~= nil then
        if settings.startup["bobmods-logistics-highpipes"].value == true then
            require("compatibility/bobsmods/bobores/items.lua")
            require("compatibility/bobsmods/bobores/recipes.lua")
            require("compatibility/bobsmods/bobores/technologies.lua")
        end
    end
end