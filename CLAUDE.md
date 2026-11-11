# Riverglades Horde

Companion addon for RXPGuides on WoW Forever: a Horde questing route through the Riverglades zone, released on CurseForge and GitHub. Split from the CMOS Dungeon Guides pack on 2026-11-10 because it is a zone route, not a dungeon. Every public description says it is experimental with no guarantee, Horde only, and requires RestedXP Guide. The repository (`clearcmos/RivergladesHorde`, local `~/git/RivergladesHorde`) and the addon folder are both `RivergladesHorde`. Original guide content; no RXP source, paid guide exports or account state belong here.

## Structure

The repository root is the addon folder; `.pkgmeta` packages it as `RivergladesHorde` and ignores everything else.

- `RivergladesHorde.toc`: Interface 16001, `AllowLoadGameType: camelot`, `Dependencies: RXPGuides`, Version. The title says Horde; the Notes say experimental.
- `RivergladesHorde.lua`: five `RXPGuides.RegisterGuide` chapters, group `Riverglades Horde`, subgroup `Riverglades 36-46`, names `RG - 01` to `RG - 05` (chapter 5 is the optional Krol'dok Stronghold dungeon run).
- `.github/workflows/release.yml`, `.pkgmeta`, `CI.md`: tag-driven packaging and CurseForge upload.
- `assets/logo.png`: the CurseForge project logo (not packaged).
- `tools/install.py`: replaces `AddOns/RivergladesHorde` locally with the files the packager ships; refuses an AddOns folder without RXPGuides.
- `tests/rxp_harness.lua`: loads the installed RXP `functions.lua`, `GuideLoader.lua` and flight database with WoW API stand-ins (`RXP_GUIDES_DIR` overrides the default path).
- `tests/riverglades.lua`: chapter links and group, readiness-gated turn-ins, prerequisite links, level gates, breadcrumb turn-ins, in-zone waypoints, bare `.complete` lines, item buttons on use-item steps, item turn-ins gated on readiness, no loop around a named mob, no sticky that repeats another step's objective, the single Bristle Hills Bandits pickup, arrival order, and no CMOS Dungeon Guides directives.
- `tests/test_route.py`: route audit. Fails when a quest already in the log, or free to take from a giver the route has already passed, has its objective area worked on an earlier, separate visit (the Gaseous Gold vents regression). Reviewed exceptions go in `REVIEWED` with the reason.
- `tests/test_progress.py`: compares step lines with the last release tag, because RXP restores a player's place by the line a step starts on and falls back to the step number. It replays that lookup for every released step and compares what the landing step does (its quest, item, zone and NPC directives); it fails when a player would land on a different step unless a changelog entry newer than that tag tells players to click their current step. Line shifts alone pass when the step-number fallback lands right.
- `tests/test_tools.py`: TOC fields, the `.pkgmeta` ignore list against the shipped files, and the local installer.
- `SOURCES.md`: data sources, prerequisite decisions and known gaps.

## Commands and release

`bash tools/check.sh`, `luacheck RivergladesHorde.lua tests --config .luacheckrc`, `stylua --check --config-path stylua.toml RivergladesHorde.lua tests` (`nix shell nixpkgs#stylua nixpkgs#luajitPackages.luacheck` when they are not installed). Install locally with `python3 tools/install.py <AddOns path>`; a new addon folder or TOC change needs a client restart, Lua changes load with `/reload`. Release steps are in `CI.md`. Do not edit the user's saved variables or change their guide selection.

## Guide conventions

- Put objective instructions on their own `>>` line and leave `.complete <quest>,<n>` bare; text on the `.complete` line replaces RXP's live counter.
- One step per hunting area lists every objective done there as `.complete -<quest>,<n>` (the negative ID skips an objective whose quest is not in the log). A `#completewith` sticky plus a later finish step listed objectives twice, and the inactive copy kept a stale counter.
- A quest that starts from a drop gets a may-drop sticky scoped to the step that kills the droppers (`#completewith next`), then an `.isOnQuest` turn-in.
- Kill and collect steps with enough spawn data use RXP `#loop` outlines: an anchor `.goto 2548,x,y,0` and ring points `.goto 2548,x,y,40,0` (RXP's own convention). How the rings were derived is in SOURCES.md; regenerate them from updated spawn data rather than hand-editing points.
- Coordinates are `.goto 2548,x,y` zone percentages. The pack must stay standalone: no `.cmosroute` or other CMOS Dungeon Guides directives, since that pack's travel helper cannot be loaded twice.
- Do not use `.fp` for Forever's new flight masters. `.fp <name>` resolves the node through RXP's flight database by name, which has no Rog'mar entry, so the step never completes for a character who already knows the path. Use a `.goto` stop at the flight master instead.
- Every turn-in is gated on the same quest being ready (`.isQuestComplete`) or, for deliveries, in the log (`.isOnQuest`).
- Gate each follow-up pickup on the quest that unlocks it. When the unlock order is undocumented, check it in game with the wow-routes status and NPC-offer scripts; without that, offer the pickup once, after its likely unlocks. Early offers with a skip note were not offered in game for Show Them How It's Done or Bristle Hills Bandits and were removed.
- Elite kills and crafting or cooking quests are `#optional`. Keep the Booty Bay and Tanaris continuations out of the route; On the Other Side is only picked up as the hand-off to Feralas. The Krol'dok Stronghold quests are picked up at the end of chapter 4 and run in the optional chapter 5.
- Chapter names are RXP progress keys; keep them stable and bump `#version` when a chapter changes. After a release, keep released steps on their lines (`tests/test_progress.py`): edit in place, turn a removed step into one that always skips, add steps at a chapter's end, or say in the changelog that players click their current step.
- The addon only registers guides through the public `RXPGuides.RegisterGuide`. RXP's import box is not a distribution path: it accepts only strings RestedXP encrypts per Battle.net account for paid guides.
- Local parser tests are not an in-game verification.

## Decision log

- 2026-11-10: Built inside CMOS Dungeon Guides, then split into this pack at the user's request so the zone route sits beside the dungeon guides instead of under them. The user chose a standalone pack over sharing or copying the dungeon pack's travel helper: arrival is a `.zone` step with written road and flight directions plus an arrow to Rog'mar. Quest data sources are in SOURCES.md.
- 2026-11-10: At the user's request, ship as a companion addon folder instead of guide files installed inside RXPGuides, because the guide is handed to friends on Discord: unzip one folder, no Python, nothing in RXP changed, survives RXP updates. The user's own v0.1.0 file-based install was removed from RXPGuides when the addon was installed.
- 2026-11-10: First public release (v0.3.0) at the user's request, through the same GitHub Actions and CurseForge pipeline as the user's other addons, so friends get patches through the CurseForge app. Renamed CMOS Riverglades Horde (Experimental): the user wants the name to say Horde and experimental, and every description to say there is no guarantee and that RestedXP Guides is required. The addon folder stays `CMOS_Riverglades` so earlier manual installs are replaced rather than duplicated.
- 2026-11-10: Renamed CMOS Riverglades Horde (Experimental) to Riverglades Horde (Beta) at the user's request, because the name was too long; "CMOS" meant nothing to people searching. The RXP group changed with it, so existing users pick the guide again once. The addon folder became `RivergladesHorde` too (the user's call; nobody had it from CurseForge yet), so a manual install of an earlier version leaves a `CMOS_Riverglades` folder to delete. The repository name stays. Shipped as v0.3.1 while v0.3.0 was still in review.
- 2026-11-10: Cancelled v0.3.0, the only upload under the old name, at the user's request: its GitHub release and tag were removed. The CurseForge delete call answered success but did not delete the file, and it was approved with the project on 2026-11-11; it has to be deleted in the console's Files list by hand.
- 2026-11-10: Renamed the repository from `CmosRiverglades` to `RivergladesHorde` at the user's request, so nothing public carries the CMOS name. GitHub redirects the old URLs; the CurseForge description links to the new one.
- 2026-11-10: Renamed Riverglades Horde (Beta) to Riverglades Horde, because CurseForge moderation put the project on "changes required": a project name may not contain a release stage. At the user's request the in-game title and the RXP group dropped (Beta) too (users pick the guide again once), and the README, TOC Notes and project summary say it is experimental because Riverglades is new content. The CurseForge slug is `riverglades-horde`.
- 2026-11-10: Merged every sticky and finish pair into one multi-objective step per area after the user saw objectives twice and stale counters in RXP's step list.
- 2026-11-11: v0.3.2 (rename, merged steps, item buttons, in-game unlock checks) and the project were approved by CurseForge moderation; v0.3.3 (Fuzzle's position read in game, the Farholde report reminder scoped to the Farholde step) followed.
