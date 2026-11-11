"""Saved guide progress. RXP restores a player's place from a step ID, the line the step starts on among the
chapter's non-empty lines plus a hash of the guide key (group|subgroup|name), and falls back to the step number
when no step starts on that line (RXPGuides GuideLoader.lua and GuideWindow.lua LoadGuide). A patch that moves a
released step to another line, or renames a chapter's key, therefore puts players on the wrong step. Regression:
on 2026-11-10 two steps removed above the player's position moved them past the crocolisk step.

A patch keeps every released step on its line: edit steps in place, turn a removed step into one that always
skips with the same number of lines, and add steps only at the end of a chapter. When a patch has to move
steps, the CHANGELOG's Unreleased section says so with NOTE."""

import re
import subprocess
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
GUIDE = "RivergladesHorde.lua"
NOTE = "click your current step"


def chapters(text):
    """{guide key: [line of each step]}, counting lines the way RXP's loader does."""
    out = {}
    for body in re.split(r"RXPGuides\.RegisterGuide\(\[=\[", text)[1:]:
        meta, starts = {}, []
        for number, line in enumerate(re.findall(r"[^\n\r]+", body.split("]=]", 1)[0]), 1):
            line = line.strip()
            if line.startswith("step"):
                starts.append(number)
            elif not starts and line.startswith("#"):
                tag, _, value = line[1:].partition(" ")
                meta[tag] = value
        out["|".join((meta.get("group"), meta.get("subgroup"), meta.get("name")))] = starts
    return out


def moved_steps(old, new):
    moved = []
    for key, starts in chapters(old).items():
        now = chapters(new).get(key)
        if now is None:
            moved.append(f"{key}: renamed or removed, so its players start the chapter again")
            continue
        for index, line in enumerate(starts):
            if index >= len(now) or now[index] != line:
                moved.append(f"{key}: released step {index + 1} (line {line}) and every later step moved")
                break
    return moved


def released():
    try:
        tag = subprocess.run(["git", "describe", "--tags", "--abbrev=0"], cwd=ROOT, capture_output=True,
                             text=True, check=True).stdout.strip()
        text = subprocess.run(["git", "show", f"{tag}:{GUIDE}"], cwd=ROOT, capture_output=True, text=True,
                              check=True).stdout
    except (OSError, subprocess.CalledProcessError):
        return None, None
    return tag, text


class ProgressTests(unittest.TestCase):
    def test_line_counting_matches_rxp(self):
        text = "RXPGuides.RegisterGuide([=[\n#group G\n#subgroup S\n#name N\n\nstep\n    .goto 1,2,3\n\n   \nstep\n]=])"
        # Blank lines do not count; a whitespace-only line does (RXP matches [^\n\r]+, then trims).
        self.assertEqual(chapters(text), {"G|S|N": [4, 7]})

    def test_moves_are_detected(self):
        old = "RXPGuides.RegisterGuide([=[\n#group G\n#subgroup S\n#name N\nstep\n.a\nstep\n.b\nstep\n.c\n]=])"
        self.assertEqual(moved_steps(old, old.replace("step\n.c", "step\n.c\nstep\n.d")), [])
        self.assertEqual(len(moved_steps(old, old.replace("step\n.a\n", ""))), 1)
        self.assertEqual(len(moved_steps(old, old.replace("#group G", "#group H"))), 1)

    def test_released_steps_keep_their_place_or_the_changelog_says_so(self):
        tag, old = released()
        if old is None:
            self.skipTest("no release tag in this checkout")
        moved = moved_steps(old, (ROOT / GUIDE).read_text())
        if moved:
            changelog = (ROOT / "CHANGELOG.md").read_text()
            unreleased = changelog.split("## Unreleased", 1)[1].split("\n## ", 1)[0] if "## Unreleased" in changelog else ""
            self.assertIn(NOTE, unreleased.lower(),
                          f"Steps moved since {tag}; keep them on their lines or tell players in CHANGELOG.md "
                          f"to {NOTE}:\n" + "\n".join(moved))


if __name__ == "__main__":
    unittest.main()
