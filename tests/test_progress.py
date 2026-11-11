"""Saved guide progress. RXP restores a player's place from a step ID, the line the step starts on among the
chapter's non-empty lines plus a hash of the guide key (group|subgroup|name), and falls back to the step number
when no step starts on that line (RXPGuides GuideLoader.lua and GuideWindow.lua LoadGuide). A patch that moves a
released step to another line, or renames a chapter's key, therefore puts players on the wrong step. Regression:
on 2026-11-10 two steps removed above the player's position moved them past the crocolisk step.

A patch keeps every released step on its line: edit steps in place, turn a removed step into one that always
skips with the same number of lines, and add steps only at the end of a chapter. When a patch has to move
steps, a CHANGELOG entry newer than the last release says so with NOTE."""

import re
import subprocess
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
GUIDE = "RivergladesHorde.lua"
NOTE = "click your current step"


def fingerprint(lines):
    """What a step does, ignoring coordinates, loops, gates and wording: its quest, item, zone and NPC actions."""
    out = []
    for line in lines:
        m = re.match(r"\.(accept|turnin|complete|collect|use|zone|target|mob|unitscan|fp)\s+-?([^>]*)", line)
        if m:
            out.append((m.group(1), m.group(2).strip()))
    return tuple(out)


def chapters(text):
    """{guide key: [(line, fingerprint) per step]}, counting lines the way RXP's loader does."""
    out = {}
    for body in re.split(r"RXPGuides\.RegisterGuide\(\[=\[", text)[1:]:
        meta, steps = {}, []
        for number, line in enumerate(re.findall(r"[^\n\r]+", body.split("]=]", 1)[0]), 1):
            line = line.strip()
            if line.startswith("step"):
                steps.append([number, []])
            elif steps:
                steps[-1][1].append(line)
            elif line.startswith("#"):
                tag, _, value = line[1:].partition(" ")
                meta[tag] = value
        key = "|".join((meta.get("group"), meta.get("subgroup"), meta.get("name")))
        out[key] = [(number, fingerprint(lines)) for number, lines in steps]
    return out


def moved_steps(old, new):
    """Released steps whose players would land on a different step: RXP looks for a step starting on the saved
    line, and when none does, it uses the saved step number."""
    moved, now_all = [], chapters(new)
    for key, steps in chapters(old).items():
        now = now_all.get(key)
        if now is None:
            moved.append(f"{key}: renamed or removed, so its players start the chapter again")
            continue
        by_line = {line: index for index, (line, _) in enumerate(now)}
        for index, (line, print_) in enumerate(steps):
            landing = min(by_line.get(line, index), len(now) - 1)
            if now[landing][1] != print_:
                moved.append(f"{key}: a player on released step {index + 1} would land on step {landing + 1}, a different step")
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
        self.assertEqual([line for line, _ in chapters(text)["G|S|N"]], [4, 7])

    def test_moves_are_detected(self):
        old = "RXPGuides.RegisterGuide([=[\n#group G\n#subgroup S\n#name N\nstep\n.accept 1\nstep\n.accept 2\nstep\n.accept 3\n]=])"
        self.assertEqual(moved_steps(old, old.replace("step\n.accept 3", "step\n.accept 3\nstep\n.accept 4")), [])
        self.assertEqual(len(moved_steps(old, old.replace("step\n.accept 1\n", ""))), 1)
        self.assertEqual(len(moved_steps(old, old.replace("#group G", "#group H"))), 1)
        # Dropping loop points from a step shifts later lines; RXP then falls back to the step number, which is right.
        looped = old.replace("step\n.accept 1\n", "step\n.goto 1,2,3,0\n.goto 1,2,4,40,0\n.goto 1,3,4,40,0\n.accept 1\n")
        self.assertEqual(moved_steps(looped, old), [])

    def test_released_steps_keep_their_place_or_the_changelog_says_so(self):
        tag, old = released()
        if old is None:
            self.skipTest("no release tag in this checkout")
        moved = moved_steps(old, (ROOT / GUIDE).read_text())
        if moved:
            # Everything above the release's own heading: Unreleased, or the version about to be tagged.
            changelog = (ROOT / "CHANGELOG.md").read_text()
            since = changelog.split(f"\n## {tag}\n", 1)[0]
            self.assertIn(NOTE, since.lower(),
                          f"Steps moved since {tag}; keep them on their lines or tell players in CHANGELOG.md "
                          f"to {NOTE}:\n" + "\n".join(moved))


if __name__ == "__main__":
    unittest.main()
