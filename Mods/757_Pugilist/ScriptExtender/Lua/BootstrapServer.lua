Ext.Osiris.RegisterListener("ObjectTimerFinished", 2, "after", function (charGUID, name)
    if name == "757_Remove_RageAnimTag" then 
        RemoveStatus(charGUID, "757RAGE_ANIMATION_TAGS")
    end  
 end)

Ext.Osiris.RegisterListener("UsingSpell", 5, "after", function (charGUID, spell, ...)
    if spell == "757_Projectile_TopRope" then 
        ApplyStatus(charGUID, "757RAGE_ANIMATION_TAGS", -1, 1, charGUID) 
    end
end)

Ext.Osiris.RegisterListener("CastedSpell", 5, "after", function(char, spell, type, school, int) 
    if spell == "757_Projectile_TopRope" then 
        Osi.RealTimeObjectTimerLaunch(char, "757_Remove_RageAnimTag",1500)
    end
end)

Ext.Osiris.RegisterListener("ObjectTimerFinished", 2, "after", function (charGUID, name)
    if name == "757_Remove_OneTwoAnimTag" then 
        RemoveStatus(charGUID, "757ONETWO_ANIMATION_TAGS")
    end  
 end)

Ext.Osiris.RegisterListener("UsingSpell", 5, "after", function (charGUID, spell, ...)
    if spell == "757_Target_OldOneTwo" then 
        ApplyStatus(charGUID, "757ONETWO_ANIMATION_TAGS", -1, 1, charGUID) 
    end
end)

Ext.Osiris.RegisterListener("CastedSpell", 5, "after", function(char, spell, type, school, int) 
    if spell == "757_Target_OldOneTwo" then 
        Osi.RealTimeObjectTimerLaunch(char, "757_Remove_OneTwoAnimTag",1500)
    end
end)

--Thank you Focus --

local MONK_SKILLS = {
Target_Counter_757 = true,
Target_ScrapLikeASleuth_757 = true,
Target_Sweep_757 = true,
}

--local progression = "bf46d73f-d406-4cb8-9a1d-e6e758ca02c7" -- Shadow
--local progression = "2a5e3097-384c-4d29-8d6e-054fdfd26b80" -- OpenHand
--local progression = "22894c32-54cf-49ea-b366-44bfcf01bb2a" -- FourElements
local progression = "c4598bdb-fc07-40dd-a62c-90cc138bd76f" -- Monk
local source = "Progression1"
local spellUUID = "d136c5d9-0ff0-43da-acce-a74a07f8d6bf"

Ext.Entity.Subscribe("SpellContainer", function(entity)
    for _, entry in pairs(entity.SpellContainer.Spells) do
        if MONK_SKILLS[entry.SpellId.OriginatorPrototype] then
            --entry.SpellId.SourceType = source
            entry.SpellId.ProgressionSource = progression
            entry.SpellUUID = spellUUID
        end
    end
end)

--Prevents actions from being removed from hotbars
Ext.Entity.Subscribe("HotbarContainer", function(entity)
    for _, container in pairs(entity.HotbarContainer.Containers) do
        for _, containerInfo in pairs(container) do
            for _, entry in pairs (containerInfo.Elements) do
                if MONK_SKILLS[entry.SpellId.OriginatorPrototype] then
                    entry.SpellId.SourceType = source
                end
            end
        end
    end
end)

Ext.Entity.Subscribe("SpellBook", function(entity)
    for _, spell in pairs(entity.SpellBook.Spells) do
        if MONK_SKILLS[spell.Id.OriginatorPrototype] then
            --spell.Id.SourceType = source
            spell.Id.ProgressionSource = progression
            spell.SpellUUID = spellUUID
        end
    end

    for _, entry in pairs(entity.AddedSpells.Spells) do
        if MONK_SKILLS[entry.SpellId.OriginatorPrototype] then
            --entry.SpellId.SourceType = source
            entry.SpellId.ProgressionSource = progression
            entry.SpellUUID = spellUUID
        end
    end
end)

Ext.Entity.Subscribe("SpellBookPrepares", function(entity)
    for _, spell in pairs(entity.SpellBookPrepares.PreparedSpells) do
        if MONK_SKILLS[spell.OriginatorPrototype] then
            --spell.SourceType = source
            spell.ProgressionSource = progression
        end
    end
end)


Ext.RegisterConsoleCommand("anim", function ( cmd, uuid )
	local host = Osi.GetHostCharacter()
    Osi.PlayAnimation(host, uuid, "")
end)






