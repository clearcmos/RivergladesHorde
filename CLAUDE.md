# Riverglades Horde

Companion addon for RXPGuides on WoW Forever: a Horde questing route through the Riverglades zone, released on CurseForge and GitHub. Split from the CMOS Dungeon Guides pack on 2026-11-10 because it is a zone route, not a dungeon. Every public description says it is a beta with no guarantee, Horde only, and requires RestedXP Guide. The repository (`clearcmos/RivergladesHorde`, local `~/git/RivergladesHorde`) and the addon folder are both `RivergladesHorde`. Original guide content; no RXP source, paid guide exports or account state belong here.

## Structure

The repository root is the addon folder; `.pkgmeta` packages it as `RivergladesHorde` and ignores everything else.

- `RivergladesHorde.toc`: Interface 16001, `AllowLoadGameType: camelot`, `Dependencies: RXPGuides`, Version. The title says Horde; the Notes say experimental.
- `RivergladesHorde.lua`: five `RXPGuides.RegisterGuide` chapters, group `Riverglades Horde`, subgroup `Riverglades 36-46`, names `RG - 01` to `RG - 05` (chapter 5 is the optional Krol'dok Stronghold dungeon run).
- `.github/workflows/release.yml`, `.pkgmeta`, `CI.md`: tag-driven packaging and CurseForge upload.
- `assets/logo.png`: the CurseForge project logo (not packaged).
- `tools/install.py`: replaces `AddOns/RivergladesHorde` locally with the files the packager ships; refuses an AddOns folder without RXPGuides.
- `tests/rxp_harness.lua`: loads the installed RXP `functions.lua`, `GuideLoader.lua` and flight database with WoW API stand-ins (`RXP_GUIDES_DIR` overrides the default path).
- `tests/riverglades.lua`: chapter links and group, readiness-gated turn-ins, prerequisite links, level gates, breadcrumb turn-ins, in-zone waypoints, bare `.complete` lines, arrival order, and no CMOS Dungeon Guides directives.
- `tests/test_route.py`: route audit. Fails when a quest already in the log, or free to take from a giver the route has already passed, has its objective area worked on an earlier, separate visit (the Gaseous Gold vents regression). Reviewed exceptions go in `REVIEWED` with the reason.
- `tests/test_tools.py`: TOC fields, the `.pkgmeta` ignore list against the shipped files, and the local installer.
- `SOURCES.md`: data sources, prerequisite decisions and known gaps.

## Commands and release

`bash tools/check.sh`, `luacheck RivergladesHorde.lua tests --config .luacheckrc`, `stylua --check --config-path stylua.toml RivergladesHorde.lua tests` (`nix shell nixpkgs#stylua nixpkgs#luajitPackages.luacheck` when they are not installed). Install locally with `python3 tools/install.py <AddOns path>`; a new addon folder or TOC change needs a client restart, Lua changes load with `/reload`. Release steps are in `CI.md`. Do not edit the user's saved variables or change their guide selection.

## Guide conventions

- Put objective instructions on their own `>>` line and leave `.complete <quest>,<n>` bare; text on the `.complete` line replaces RXP's live counter.
- Kill and collect steps with enough spawn data use RXP `#loop` outlines: an anchor `.goto 2548,x,y,0` and ring points `.goto 2548,x,y,40,0` (RXP's own convention). How the rings were derived is in SOURCES.md; regenerate them from updated spawn data rather than hand-editing points.
- Coordinates are `.goto 2548,x,y` zone percentages. The pack must stay standalone: no `.cmosroute` or other CMOS Dungeon Guides directives, since that pack's travel helper cannot be loaded twice.
- Do not use `.fp` for Forever's new flight masters. `.fp <name>` resolves the node through RXP's flight database by name, which has no Rog'mar entry, so the step never completes for a character who already knows the path. Use a `.goto` stop at the flight master instead.
- Every turn-in is gated on the same quest being ready (`.isQuestComplete`) or, for deliveries, in the log (`.isOnQuest`).
- Gate each follow-up pickup on the quest that unlocks it. When the unlock order is undocumented, offer the pickup at the earliest likely point with a skip note and again after the likely prerequisite.
- Elite kills and crafting or cooking quests are `#optional`. Keep the Booty Bay and Tanaris continuations out of the route; On the Other Side is only picked up as the hand-off to Feralas. The Krol'dok Stronghold quests are picked up at the end of chapter 4 and run in the optional chapter 5.
- Chapter names are RXP progress keys; keep them stable and bump `#version` when a chapter changes.
- The addon only registers guides through the public `RXPGuides.RegisterGuide`. RXP's import box is not a distribution path: it accepts only strings RestedXP encrypts per Battle.net account for paid guides.
- Local parser tests are not an in-game verification.

## Decision log

- 2026-11-10: Built inside CMOS Dungeon Guides, then split into this pack at the user's request so the zone route sits beside the dungeon guides instead of under them. The user chose a standalone pack over sharing or copying the dungeon pack's travel helper: arrival is a `.zone` step with written road and flight directions plus an arrow to Rog'mar. Quest data sources are in SOURCES.md.
- 2026-11-10: At the user's request, ship as a companion addon folder instead of guide files installed inside RXPGuides, because the guide is handed to friends on Discord: unzip one folder, no Python, nothing in RXP changed, survives RXP updates. The user's own v0.1.0 file-based install was removed from RXPGuides when the addon was installed.
- 2026-11-10: First public release (v0.3.0) at the user's request, through the same GitHub Actions and CurseForge pipeline as the user's other addons, so friends get patches through the CurseForge app. Renamed CMOS Riverglades Horde (Experimental): the user wants the name to say Horde and experimental, and every description to say there is no guarantee and that RestedXP Guides is required. The addon folder stays `CMOS_Riverglades` so earlier manual installs are replaced rather than duplicated.
- 2026-11-10: Renamed CMOS Riverglades Horde (Experimental) to Riverglades Horde (Beta) at the user's request, because the name was too long; "CMOS" meant nothing to people searching. The RXP group changed with it, so existing users pick the guide again once. The addon folder became `RivergladesHorde` too (the user's call; nobody had it from CurseForge yet), so a manual install of an earlier version leaves a `CMOS_Riverglades` folder to delete. The repository name stays. Shipped as v0.3.1 while v0.3.0 was still in review.
- 2026-11-10: Cancelled v0.3.0, the only upload under the old name, at the user's request: its CurseForge file was deleted while still in review, and its GitHub release and tag were removed. v0.3.1 is the first public release.
- 2026-11-10: Renamed the repository from `CmosRiverglades` to `RivergladesHorde` at the user's request, so nothing public carries the CMOS name. GitHub redirects the old URLs; the CurseForge description links to the new one.
- 2026-11-10: Renamed Riverglades Horde (Beta) to Riverglades Horde, because CurseForge moderation put the project on "changes required": a project name may not contain a release stage. At the user's request the in-game title and the RXP group dropped (Beta) too (users pick the guide again once), and the README, TOC Notes and project summary say it is experimental because Riverglades is new content. The CurseForge slug became `riverglades-horde` if CurseForge took the change.
