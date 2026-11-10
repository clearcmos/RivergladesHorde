-- Load the user's actual RXP parser and directives without loading the game UI.
-- No RXP source or paid guide content is bundled in this repository.
local Harness = {}
-- Client map rectangles (world, then world-coordinate bounds) for the maps the guide uses.
local bounds = {
    [1418] = { 0, -7547.9165, -4566.6665, -5889.583, -2079.1665 },
    [2548] = { 0, -9700, -6741.666, -6466.666, -1891.666 },
}
local root = os.getenv("RXP_GUIDES_DIR") or "/mnt/data/games/World of Warcraft/_forever_/Interface/AddOns/RXPGuides"

function Harness.Load(class, race, faction, level)
    local state = {
        class = class or "WARRIOR",
        race = race or "Orc",
        faction = faction or "Horde",
        level = level or 25,
        log = {},
        done = {},
        ready = {},
        map = 1413,
        x = 50,
        y = 30,
        instance = 1,
        flightPaths = {},
        flightNodes = {},
        taxiNodes = {},
        mapInfo = {},
    }
    _G.bit = require("bit")
    strlower, strupper, tinsert, tremove = string.lower, string.upper, table.insert, table.remove
    UnitClass = function()
        return state.class, state.class
    end
    UnitFactionGroup = function()
        return state.faction
    end
    UnitLevel = function()
        return state.level
    end
    UnitSex = function()
        return 2
    end
    UnitXP, UnitXPMax = function()
        return 0
    end, function()
        return 100
    end
    GetLocale = function()
        return "enUS"
    end
    GetBuildInfo = function()
        return "1.60.1", "70840", "", 16001
    end
    GetTime = function()
        return state.time or 100
    end
    IsInInstance = function()
        return state.inInstance == true
    end
    UnitOnTaxi = function()
        return state.onTaxi == true
    end
    QUEST_MONSTERS_KILLED, QUEST_ITEMS_NEEDED = "%s slain: %d/%d", "%s: %d/%d"
    CreateVector2D = function()
        return {}
    end
    StaticPopupDialogs, C_GossipInfo, C_DateAndTime = {}, {}, {}
    ACCEPT, CANCEL, TURN_IN_QUEST = "Accept", "Cancel", "Turn in"
    RXPData = {}
    RXPCData = { flightPaths = state.flightPaths }
    Enum = { FlightPathState = { Current = 0, Reachable = 1, Unreachable = 2 } }
    C_TaxiMap = {
        GetTaxiNodesForMap = function()
            return state.flightNodes
        end,
        GetAllTaxiNodes = function()
            return state.taxiNodes
        end,
    }
    C_Item = {
        GetItemInfo = function(id)
            return "Item " .. id
        end,
    }
    C_QuestLog = {
        GetNumQuestLogEntries = function()
            return 0
        end,
        IsOnQuest = function(id)
            return state.log[id] == true
        end,
        IsQuestFlaggedCompleted = function(id)
            return state.done[id] == true
        end,
        IsComplete = function(id)
            return state.ready[id] == true
        end,
    }
    C_Map = {
        GetMapInfo = function(map)
            return state.mapInfo[map]
        end,
        GetBestMapForUnit = function()
            return state.map
        end,
        GetPlayerMapPosition = function()
            if state.x and state.y then
                return {
                    GetXY = function()
                        return state.x / 100, state.y / 100
                    end,
                }
            end
        end,
        GetAreaInfo = function(id)
            error("Unexpected area ID: " .. tostring(id))
        end,
    }
    local hbd = {
        GetWorldCoordinatesFromZone = function(_, x, y, map)
            local rectangle = bounds[map]
            if rectangle then
                return rectangle[5] - x * (rectangle[5] - rectangle[3]),
                    rectangle[4] - y * (rectangle[4] - rectangle[2]),
                    rectangle[1]
            end
        end,
        GetZoneCoordinatesFromWorld = function(_, x, y, map)
            local rectangle = bounds[map]
            if rectangle then
                return (rectangle[5] - x) / (rectangle[5] - rectangle[3]),
                    (rectangle[4] - y) / (rectangle[4] - rectangle[2])
            end
        end,
        GetPlayerWorldPosition = function(self)
            if state.worldPosition then
                return unpack(state.worldPosition)
            end
            if state.map and state.x and state.y then
                local x, y = self:GetWorldCoordinatesFromZone(state.x / 100, state.y / 100, state.map)
                return x or state.x * 100, y or state.y * 100, state.instance
            end
        end,
        GetWorldVector = function(_, _, x, y, targetX, targetY)
            return 0, math.sqrt((x - targetX) ^ 2 + (y - targetY) ^ 2)
        end,
    }
    LibStub = function(name)
        return name == "HereBeDragons-2.0" and hbd or {}
    end
    RXPGuides = {}
    local ns = {
        player = { class = state.class, race = state.race, faction = state.faction, lang = "en" },
        game = "FOREVER",
        gameVersion = 16001,
        addonLoaded = true,
        functions = {},
        separators = {},
        mapConversion = {},
        questConversion = {},
        locale = {
            Get = function(text)
                return text
            end,
        },
        settings = {
            profile = { enableXpStepSkipping = true },
            ReplaceColors = function(text)
                return text
            end,
        },
        comms = {
            PrettyDebug = function(...)
                error(string.format(...))
            end,
            grouping = { ShareQuest = function() end },
        },
        RXPGuides = RXPGuides,
    }
    ns.NewModule = function()
        return {}
    end
    ns.GetMapInfo = function(zone, x, y)
        return tonumber(zone), tonumber(x), tonumber(y)
    end
    ns.GetMapId = function(zone)
        return tonumber(zone)
    end
    ns.disabledQuests, ns.questAccept, ns.questAcceptItems, ns.questTurnInItems = {}, {}, {}, {}
    ns.UpdateItemFrame = function() end
    assert(loadfile(root .. "/functions.lua"), "Set RXP_GUIDES_DIR to an installed RXPGuides folder")("RXPGuides", ns)
    assert(loadfile(root .. "/GuideLoader.lua"))("RXPGuides", ns)
    ns.GetQuestName = function(id)
        return "Quest " .. id
    end
    -- UI side effects are replaced; acceptance and condition logic stay original.
    ns.SetElementComplete = function(frame)
        frame.element.completed = true
    end
    ns.UpdateStepText = function() end
    ns.UpdateMap = function()
        state.mapUpdates = (state.mapUpdates or 0) + 1
    end
    -- The .fp directive resolves flight masters through RXP's own flight database.
    assert(loadfile(root .. "/DB/forever/flightData.lua"))("RXPGuides", ns)
    assert(loadfile("RivergladesHorde.lua"))("RXPGuides", ns)
    return ns, state
end

function Harness.Step(ns, name, tag, questID, occurrence)
    occurrence = occurrence or 1
    for _, guide in pairs(ns.guides) do
        if guide.name == name then
            for _, step in ipairs(guide.steps) do
                for _, element in ipairs(step.elements) do
                    if element.tag == tag and element.questId == questID then
                        occurrence = occurrence - 1
                        if occurrence == 0 then
                            return step, element
                        end
                    end
                end
            end
        end
    end
end

function Harness.Allowed(ns, step)
    assert(step, "Missing step")
    step.active, step.completed = true, false
    for _, element in ipairs(step.elements) do
        if element.tag and (element.tag == "xp" or element.tag:match("^is")) then
            ns.functions[element.tag]({ element = element }, "QUEST_LOG_UPDATE")
        end
    end
    return not step.completed
end

return Harness
