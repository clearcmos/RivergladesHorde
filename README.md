# Riverglades Horde

A Horde questing guide for the Riverglades zone in WoW Forever, levels 36 to 46, shown inside the RestedXP Guides addon.

> **Experimental.** Riverglades is new content in WoW Forever. This guide was written from public quest data in the zone's first week, before any established guide covered it. There is no guarantee that every step, location, quest order or prerequisite is right, or that it works well at all. Skip any step that does not match the game. Horde only.

## Requirements

- WoW Forever.
- **[RestedXP Guide](https://www.curseforge.com/wow/addons/restedxp-guide)** (RXPGuides) installed and enabled. This addon only adds a guide to it and does nothing on its own. The CurseForge app installs it as a required dependency.
- A Horde character.

## Install

- **CurseForge app:** install Riverglades Horde and it updates with each release.
- **Manually:** unzip the release into `World of Warcraft/_forever_/Interface/AddOns/` so the folder is `AddOns/RivergladesHorde`, then restart the game. To update, replace the folder.

In RXP's guide picker, select **Riverglades Horde**, then **Riverglades 36-46**, and start at **1. Rog'mar and the River**.

## Chapters

1. **Rog'mar and the River (36-41)**: arrival from the Badlands, the Rog'mar quest givers, Sleebo's gas vents, Turner's Logging Camp, Meadowsbrook, Sunnyglade, Gelinda Coppergleam's dragon caves and the Bristle Hills.
2. **Sunnyglade and Bolder'ok (40-45)**: the caves under Sunnyglade with Clubtoe, Na'zok's farm, Clugfist, and the Bloodmaster's Ring.
3. **Powderfuse Port and the Coast (40-45)**: Friz's smuggling chain, Wharfmaster Whizzbuzz's pirate quests, the murlocs and the sea monster.
4. **Twilight's Shroud (42-46)**: Da'grosh, Crag'rog, Executioner Morg and Overlord Kilgar; picks up the Krol'dok Stronghold quests and On the Other Side (Feralas).
5. **Krol'dok Stronghold (dungeon, 40-45)**: optional group run for Eye of Mugg, Tome of Twilight, A Token of Vengeance and the Krol'dok Moulding found inside, with the turn-ins afterwards.

## What the guide does and does not do

- Turn-ins appear only for quests that are ready, and follow-up pickups wait for the quest that unlocks them. Objective steps show RXP's live progress counters.
- Each hunting area is one step listing every objective there, so nothing appears twice in RXP's step list. Objectives for quests you do not have are skipped.
- Quest items you use (Wood Bundle, Makeshift Stickin' Spear, Hearty Stew, Swineherd's Staff, Remote Explosive Charge, Tallstrider Call, Big Ball o' Bait) and items that start quests (Head of Scaldaron, the Krol'dok Moulding, the Farholde Scouting Report) get RXP's clickable item button.
- Kill and collect steps use RXP's loop waypoints, so the arrow cycles around the area instead of stopping at one point: most outline where their mobs or objects were seen, and steps with only one or two known spots circle them. The arrow points in a straight line and does not route around terrain. The areas come from early player traces and are approximate. Named bosses, ring fights, caves and one-spot objectives show a single marker.
- Elite kills (Snargl, Ghostmaw, Ombassa, Scaldaron, Old Rot-Chum, Scoutmaster Vargas), Step Two: More Rock (Heavy Weightstones) and Not My Circus (Cooking 200) are optional steps.
- Show Them How It's Done is offered after Food for the Taking, when Krom'rosh gives it (checked in game). Bristle Hills Bandits has no documented prerequisite and is offered at the second Kreza visit, after its likely unlocks.
- The Farholde Scouting Report starts from a drop with no published drop rate, so the guide reminds you to loot it only while you fight Farholde's soldiers, and turns it in if you have it.
- Arrival is a zone step with written directions (the road south from the Badlands, or the Kargath flight once Rog'mar is known), then an arrow to Rog'mar. The Rog'mar flight path step finishes when you reach the flight master, because RXP cannot yet detect that flight path.
- Not included: Friz's chains that continue to Booty Bay and Tanaris, and Armory of Sunnyglade (starts in Undercity). Not yet routed because nobody has published where they start: Twilight Scouting Report (Azka's message for Krom'rosh), and Might Over Magic and Magic Over Might (Bal'mog).
- The Jom-jom pickup, the Sweetberry and Riverweed spots and the Twilight Ritual Circles have no recorded coordinates; those steps describe the area.

Data sources and the decisions behind the quest order are in [SOURCES.md](SOURCES.md). Report problems on the project's CurseForge page or GitHub issues.

## Development

- `bash tools/check.sh`: Lua 5.1 syntax, the guide test against an installed RXPGuides (set `RXP_GUIDES_DIR` to its folder), and the tool tests. Needs LuaJIT, the Lua 5.1 compiler and Python 3. The guide test loads RXP's own parser and directive functions with WoW API stand-ins; it checks chapter links, readiness-gated turn-ins, prerequisite links, level gates, breadcrumb turn-ins, in-zone waypoints, progress counters and the arrival order, not in-game behavior. `tests/test_route.py` also audits the route for objectives left for a later visit to an area you have already worked, and `tests/test_progress.py` checks that a patch keeps released steps where RXP expects them, or that the changelog tells players to click their current step.
- `luacheck RivergladesHorde.lua tests --config .luacheckrc` (lint) and `stylua --check --config-path stylua.toml RivergladesHorde.lua tests` (format).
- `python3 tools/install.py <path to Interface/AddOns>`: replaces the local `RivergladesHorde` folder with the files the packager ships.
- Releases: see [CI.md](CI.md).

## License

MIT. The guide text, tests and tools are original. World of Warcraft content belongs to Blizzard Entertainment. RestedXP Guides is a separate addon and is not included.
