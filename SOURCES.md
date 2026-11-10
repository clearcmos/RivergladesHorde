# Sources

Facts behind the route and their limits. Route prose is original; no RestedXP, Questie or third-party guide text is reproduced, and no RXP source is bundled.

## Quest data, v0.1.0

Read on 2026-11-10 for the installed Forever build and RXP v4.11.34. RestedXP has no Riverglades guide (none in the shipped files or the account's delivered guides), and the installed QuestieDB has the zone's NPC spawns but none of its quests. The client quest cache held only the two breadcrumbs, Report to Rog'mar 95141 and Finding Tan'jani 95143. Route prose is original; no third-party guide text is reproduced.

Evidence, in order of use:

- [ForeverChanges](https://foreverchanges.pro/quests/riverglades): the zone's 170 quest IDs with side, quest level and minimum level, and each Horde or neutral quest page's objectives, description, chain and, where players' addon data has it, giver and ender with coordinates. Minimum levels for the `.xp` gates come from here.
- Wowhead's Forever quest map data (start, end and objective points with NPC IDs), captured 2026-11-10 in the `scripts/data/forever_quest_maps.json` file of the public PhatZero/Wayforth repository. WebFetch of Wowhead pages does not expose these points. All NPC and objective coordinates in the guide come from here when present.
- ahledger.com giver and turn-in reports from the same repository's `forever_quest_reports.json`, used for quests absent from the map data (Bloodmaster's Ring 94668, Our Ogre Friend 94733, Land of Giants 95420, Jom-jom's Escape 94556).
- AllTheThings `riverglades.lua` `sourceQuest` links for prerequisites, and its item IDs for the use items: Hearty Stew 265066, Swineherd's Staff 268521, Big Ball o' Bait 268647, Head of Scaldaron 271613, Tallstrider Call 271779.
- Questie's master-branch Forever corrections (starters and finishers for Clugfist's Decree 95428, WANTED: Trapclaw 95254 and WANTED: Scoutmaster Vargas 95882) and the installed QuestieDB spawns for mob areas not in the map data.
- Frames from Alliance YouTube streams with on-screen coordinates (videos `_X_xywiZ0cU`, `z3--_goqLWA`, `l1cid3JF6dM`, `BSzcYd_pn6A`, `ie6o0KcWJoI`) for the neutral port quests: the powder kegs inside the Windstead buildings, Admiral Lamora and his stash on the second ship, the Rotflesh Mushrooms in Twilight Hollow, the Marsh Gas vents, the Cubic Draconia and the Tallstrider Call spot.
- A YouTube playthrough (video `f88IUsWXYuQ`) reporting that Tran'gul's Twilight quests appear only after Show Them How It's Done 94483 is turned in, and that the Bloodmaster's Ring entry costs 1 gold.

Prerequisite decisions:

- The quest-series order published for the ogre storyline (Rise Up! first, Land of Giants last) runs against its givers: Land of Giants is Tran'gul's quest to Clugfist, and Clugfist then gives Might Makes Right. The route follows the giver flow (Digging for Answers, Clubtoe's chain, Spread the Word, Land of Giants, Clugfist), which the playthrough also reports. AllTheThings' The Purple Ones 95417 ← Might Makes Right 95424 link comes from that reversed series and is not used.
- Twilight No More! requires both The Purple Ones 95601 and Sickening Lights 95602. Bring Me His Head requires Carving a Path and Break Their Chains. Gnoll Infestation and Snargl's Snout are offered after A Hunter's Quiver, and Show Them How It's Done after Food for the Taking, on single player recordings (fitzforge/polestar); the route offers Show Them How It's Done earlier with a skip note and again after Food for the Taking.
- Whizzbuzz's pirate quests unlock in pairs, as seen in a stream's quest tracker: Saltwater Savages and Unfriendly Competition first; Unchecked Expansion and A Blast Ye Scurvy Dogs! once Unfriendly Competition is turned in; See Ya, Scallywags! and Admiral Lamora once both of those are turned in (they were handed in together, so the route waits for both). Rock 'em and Sock 'em appeared on the Gaseous Gold turn-in. The Gaseous Gold tracker counts 8 vials, not the 5 in the quest text.

Not routed: Krol'dok Stronghold's dungeon quests; I Know a Guy and Shipping and Handling and their Booty Bay and Tanaris continuations; On the Other Side 95033 (Feralas); Armory of Sunnyglade 97884 (Undercity). No coordinates are published for the Jom-jom pickup (estimated at the east end of his escort path near the Twilight camp east of Bolder'ok), the Sweetberry and Riverweed nodes and the Twilight Ritual Circles; those steps describe the area instead. Trapclaw, Scoutmaster Vargas and Ghostmaw use QuestieDB spawns. What drops the Farholde Scouting Report 93971 is unknown, so it is turned in only if the character has it.

These are parser and API-stand-in checks against crowd-sourced data from the first week after launch. Quest offers, unlock order, objective positions, the caves under Sunnyglade and the Twilight's Shroud interior need an in-game run.
