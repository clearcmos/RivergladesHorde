local H = dofile("tests/rxp_harness.lua")
local CHAPTERS = {
    "RG - 01 Rog'mar and the River",
    "RG - 02 Sunnyglade and Bolder'ok",
    "RG - 03 Powderfuse Port",
    "RG - 04 Twilight's Shroud",
    "RG - 05 Krol'dok Stronghold",
}
local assertions = 0
local function check(condition, message)
    assertions = assertions + 1
    assert(condition, message)
end
local function chapter(ns, name)
    for _, guide in pairs(ns.guides) do
        if guide.name == name then
            return guide
        end
    end
    error("Missing Riverglades chapter: " .. name)
end
-- Quests turned in with items in the bags: the turn-in must wait until the quest is ready, not just in the log.
local ITEM_TURNINS = {
    [96026] = true, -- Step Two: More Rock, 10 Heavy Weightstones
    [95982] = true, -- Not My Circus, 10 Briny Seafood Stew
    [95936] = true, -- Hail the Dragonslayer, Head of Scaldaron
}
local function gate(step, tag, id)
    for _, element in ipairs(step.elements) do
        if element.tag == tag then
            if id == nil or element.questId == id then
                return element
            end
            for _, gated in ipairs(element.questIds or {}) do
                if gated == id then
                    return element
                end
            end
        end
    end
end
local function find(ns, tag, id)
    for _, name in ipairs(CHAPTERS) do
        local step = H.Step(ns, name, tag, id)
        if step then
            return step, name
        end
    end
end

-- Structure: four linked chapters, Horde only, every waypoint inside Riverglades.
local ns, state = H.Load("PALADIN", "Scourge", "Horde", 40)
for index, name in ipairs(CHAPTERS) do
    local guide = chapter(ns, name)
    check(guide.next == CHAPTERS[index + 1], "Riverglades chapter link is wrong after " .. name)
    check(guide.group == "Riverglades Horde", "Chapter is outside the Riverglades Horde group")
    local labels = {}
    for _, step in ipairs(guide.steps) do
        if step.label then
            labels[step.label] = true
        end
    end
    for _, step in ipairs(guide.steps) do
        if step.loop then
            local points = 0
            for _, element in ipairs(step.elements) do
                points = points + (element.tag == "goto" and 1 or 0)
            end
            -- A loop outline needs an anchor plus at least three ring points to enclose an area.
            check(points >= 4, "Loop outline with too few points in " .. name)
        end
        if step.completewith and step.completewith ~= "next" then
            check(labels[step.completewith], "Missing sticky-step destination in " .. name)
        end
        for _, element in ipairs(step.elements) do
            if element.tag == "goto" then
                check(element.zone == 2548, "Waypoint outside Riverglades in " .. name)
                check(element.x > 0 and element.x < 100 and element.y > 0 and element.y < 100, "Invalid coordinates")
            elseif element.tag == "complete" then
                -- Regression: text on a .complete line replaces RXP's live objective counter (e.g. 3/6).
                check(not element.rawtext or element.rawtext == "", "Objective text hides the progress counter")
            elseif element.tag and element.tag:match("^cmos") then
                check(false, "Standalone guide uses a CMOS Dungeon Guides travel directive")
            elseif element.tag == "turnin" then
                -- A reward trip needs the same quest ready, or in the log for delivery quests.
                local id = element.questId
                check(
                    gate(step, "isQuestComplete", id) or gate(step, "isOnQuest", id),
                    "Turn-in without a readiness gate: " .. id
                )
                -- Regression: Step Two: More Rock's turn-in showed on accepting it, before any Heavy Weightstones.
                if ITEM_TURNINS[id] then
                    check(gate(step, "isQuestComplete", id), "Item turn-in shown before the items: " .. id)
                    state.log[id], state.ready[id], state.done[id] = true, nil, nil
                    check(not H.Allowed(ns, step), "Item turn-in shown without the items: " .. id)
                end
                state.log[id], state.ready[id], state.done[id] = nil, nil, nil
                check(not H.Allowed(ns, step), "Turn-in shown for a quest not in the log: " .. id)
                state.log[id], state.ready[id] = true, true
                check(H.Allowed(ns, step), "Ready turn-in hidden: " .. id)
                state.log[id], state.ready[id], state.done[id] = nil, nil, true
                check(not H.Allowed(ns, step), "Turned-in quest still routed: " .. id)
                state.done[id] = nil
            end
        end
    end
end
check(next(H.Load("WARRIOR", "Human", "Alliance").guides) == nil, "Horde guide appeared for Alliance")

-- Follow-up pickups wait for the quest that unlocks them; level gates follow the client minimums.
local followups = {
    { 93787, 93786 },
    { 94480, 93787 },
    -- Regression: step 41 offered this early with a skip note; Krom'rosh does not offer it while 93787 is open (in game 2026-11-10).
    { 94483, 93787 },
    { 94481, 94480 },
    { 94672, 94483 },
    { 93976, 93788 },
    { 95955, 95951 },
    { 96108, 96107 },
    { 96109, 96108 },
    { 96104, 96103 },
    { 96105, 96104 },
    { 94532, 96109 },
    { 94727, 94680 },
    { 94963, 94961 },
    { 95417, 94727 },
    { 95602, 94727 },
    { 95601, 95417 },
    { 95427, 95601, 95602 },
    { 95418, 95427 },
    { 95420, 95418 },
    { 95424, 95420 },
    { 94668, 95424 },
    { 95428, 95424 },
    { 94669, 94668 },
    { 94670, 94669 },
    { 94739, 94670 },
    { 94962, 94739 },
    { 94964, 94962 },
    { 94733, 94964 },
    { 94734, 94733 },
    { 94737, 94734 },
    { 94965, 94737 },
    { 95063, 94965 },
    { 96026, 95183 },
    { 95288, 93976 },
    { 95293, 95288 },
    { 95294, 95293 },
    { 95261, 95260 },
    { 96067, 96063 },
    { 95122, 95119 },
    { 95123, 95119 },
    { 95165, 95122, 95123 },
    { 95124, 95122, 95123 },
    { 95267, 95261 },
    { 95982, 95121 },
    { 94744, 95428 },
    { 94745, 94744 },
    { 94748, 94744 },
    { 95431, 94744 },
    { 95432, 95431 },
    { 95433, 95432 },
    { 94768, 94745, 94748 },
    { 95278, 94768 },
    { 94975, 94768 },
    { 94968, 95278 },
    { 94974, 94973 },
}
for _, chain in ipairs(followups) do
    local follow = chain[1]
    ns, state = H.Load("PALADIN", "Scourge", "Horde", 45)
    local step = find(ns, "accept", follow)
    check(step, "Missing pickup " .. follow)
    check(not H.Allowed(ns, step), follow .. " offered before its prerequisites were turned in")
    for index = 2, #chain - 1 do
        state.done[chain[index]] = true
    end
    check(#chain == 2 or not H.Allowed(ns, step), follow .. " offered with only part of its prerequisites")
    state.done[chain[#chain]] = true
    check(H.Allowed(ns, step), follow .. " hidden after its prerequisites were turned in")
    state.log[follow] = true
    local element = gate(step, "accept", follow)
    step.active = true
    ns.functions.accept({ element = element }, "QUEST_LOG_UPDATE")
    check(element.completed, "Accepted quest " .. follow .. " still waits at its giver")
end
ns, state = H.Load("PALADIN", "Scourge", "Horde", 35)
check(H.Allowed(ns, find(ns, "accept", 93786)), "A Message in Blood needs level 35")
check(not H.Allowed(ns, find(ns, "accept", 93788)), "Level 36 pickup shown at level 35")
state.level = 36
check(H.Allowed(ns, find(ns, "accept", 93788)), "Level 36 pickup hidden at 36")

-- Breadcrumbs from other zones are turned in only when the character has them.
for _, id in ipairs({ 95141, 95143 }) do
    local step = find(ns, "turnin", id)
    check(not H.Allowed(ns, step), "Missing breadcrumb still routed: " .. id)
    state.log[id] = true
    check(H.Allowed(ns, step), "Breadcrumb turn-in hidden: " .. id)
    state.log[id] = nil
end

-- Quest items you click get RXP's item button on every step that works the objective.
local USE_ITEMS = {
    [95951] = 271629, -- Wood Bundle
    [95955] = 271639, -- Makeshift Stickin' Spear
    [95165] = 268505, -- Remote Explosive Charge
    [94481] = 265066, -- Hearty Stew
    [95163] = 268521, -- Swineherd's Staff
    [96105] = 271779, -- Tallstrider Call
    [95267] = 268647, -- Big Ball o' Bait
}
ns = H.Load("PALADIN", "Scourge", "Horde", 40)
for _, name in ipairs(CHAPTERS) do
    for _, step in ipairs(chapter(ns, name).steps) do
        for _, element in ipairs(step.elements) do
            local item = element.tag == "complete" and not step.completewith and USE_ITEMS[element.questId]
            if item then
                local button = false
                for _, other in ipairs(step.elements) do
                    button = button or (other.tag == "use" and other.activeItems[item] ~= nil)
                end
                check(button, "No item button for quest " .. element.questId)
            end
        end
    end
end

-- Regression: a "while you're here" sticky plus a "finish" step listed the same objective twice in
-- RXP's step list, and the copy that was not active kept a stale counter after the quest was done.
for _, name in ipairs(CHAPTERS) do
    local steps = chapter(ns, name).steps
    for i, step in ipairs(steps) do
        if step.completewith then
            for _, element in ipairs(step.elements) do
                if element.tag == "complete" then
                    for j, other in ipairs(steps) do
                        for _, o in ipairs(j ~= i and other.elements or {}) do
                            check(
                                not (o.tag == "complete" and o.questId == element.questId and o.obj == element.obj),
                                string.format(
                                    "%s step %d repeats objective %d,%d of sticky step %d",
                                    name,
                                    j,
                                    element.questId,
                                    element.obj,
                                    i
                                )
                            )
                        end
                    end
                end
            end
        end
    end
end

-- Regression: Kreza did not offer Bristle Hills Bandits at the first visit (in game 2026-11-10); the only
-- pickup comes after Borrowed Blades and A Hunter's Quiver, its likely unlocks.
do
    local first = chapter(ns, CHAPTERS[1]).steps
    local pickup, blades, quiver
    for index, step in ipairs(first) do
        for _, element in ipairs(step.elements) do
            if element.tag == "accept" and element.questId == 94535 then
                check(not pickup, "Bristle Hills Bandits is offered twice")
                pickup = index
            elseif element.tag == "turnin" and element.questId == 93788 then
                blades = index
            elseif element.tag == "turnin" and element.questId == 96109 then
                quiver = index
            end
        end
    end
    check(
        pickup and blades and quiver and pickup > blades and pickup > quiver,
        "Bristle Hills Bandits offered too early"
    )
end

-- Arrival: the zone-entry step comes before the flight path and the first quest.
ns = H.Load("PALADIN", "Scourge", "Horde", 40)
local first = chapter(ns, CHAPTERS[1])
local arrival, flight, pickup
for index, step in ipairs(first.steps) do
    for _, element in ipairs(step.elements) do
        if element.tag == "zone" and element.map == 2548 then
            arrival = arrival or index
        elseif element.tag == "goto" and element.x == 59.6 and element.y == 45.1 then
            flight = flight or index
        elseif element.tag == "fp" then
            -- Regression: RXP's flight database has no Rog'mar node, so an .fp step never completes for a known path.
            check(false, "Rog'mar .fp step cannot detect a known flight path")
        elseif element.tag == "accept" then
            pickup = pickup or index
        end
    end
end
check(
    arrival and flight and pickup and arrival < flight and flight < pickup,
    "Arrival must precede the Grakna stop and pickups"
)

print(string.format("Riverglades: %d assertions over chapters, gates, rewards and arrival passed", assertions))
