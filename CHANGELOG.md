# Changelog

## v0.3.0

- First public release, named CMOS Riverglades Horde (Experimental). Experimental: no guarantee that every step, location or quest order is right. Requires RestedXP Guides. Horde only.
- Objective steps show RXP's live progress counters (for example 3/6).
- The guide's RXP group is now "CMOS Riverglades Horde (Experimental)"; select it again in RXP's guide picker after updating.
- Loads only on WoW Forever (`AllowLoadGameType: camelot`).

## v0.2.1

- The Rog'mar flight path step finishes when you reach Grakna. As an `.fp` step it never finished for characters who already had the flight path, because RXP's flight database has no Rog'mar entry. Chapter 1 is now version 2.

## v0.2.0

- Ship as a companion addon folder, `CMOS_Riverglades`, with its own TOC that requires RXPGuides. Installing is unzipping one folder into AddOns; nothing inside RXPGuides is changed.
- Replace the RXP-manifest installer with `tools/install.py` (copies the folder into AddOns) and `tools/package.py` (builds the shareable zip).
- If you installed v0.1.0, remove `Guides/GuideList-CMOS-Riverglades.xml`, `Guides/forever/CMOS-Riverglades.lua`, `Guides/CMOS-Riverglades-LICENSE.md` and the matching Include line in `Guides/GuideList-forever.xml` from RXPGuides, or the chapters register twice.

## v0.1.0

- Split the Riverglades route out of CMOS Dungeon Guides into its own pack and RXP group, CMOS Riverglades (Horde).
- Four linked Horde chapters for levels 36 to 46: Rog'mar and the River, Sunnyglade and Bolder'ok, Powderfuse Port and the Coast, and Twilight's Shroud.
- Arrival uses a zone step with written directions instead of the dungeon pack's travel helper, so the pack has no dependency beyond RXPGuides.
- Readiness-gated turn-ins, prerequisite-gated follow-ups and optional elite and crafting quests, with parser, gate and installer tests.
