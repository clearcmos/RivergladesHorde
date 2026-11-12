"""Route audit: a quest that is already in the log, or free to take from a giver the route has already
passed, must not have its objectives left for a later visit to an area the route has already worked. Regression: Gaseous Gold's gas vents sit at the Glade Viper ponds, but the
quest was routed two chapters later, so a player hunting vipers walked past the vents."""

import math
import re
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
YARDS_X, YARDS_Y = 4575.0, 2958.3  # Riverglades map size, from the client map rectangle
NEAR = 250  # objective areas this close count as the same place
AWAY = 600  # a step this far from the earlier area means the player has left it
GIVER = 200  # a giver this close to a step the route already took counts as passed

# Reviewed exceptions: (quest, earlier quest) -> why the objective cannot be done on the earlier visit.
REVIEWED = {
    ("95261", "95118"): "Beast Entrails drop from every beast, and the murloc step tells players to loot the crawlers "
                        "for them; listing the 15 entrails there would hold that step open, so the later loop only "
                        "finishes the count.",
    ("95261", "95254"): "Trapclaw drops Beast Entrails and the It Takes Guts pickup says so; the later loop only "
                        "finishes the count.",
}


def yards(a, b):
    return math.hypot((a[0] - b[0]) / 100 * YARDS_X, (a[1] - b[1]) / 100 * YARDS_Y)


def steps():
    text = (ROOT / "RivergladesHorde.lua").read_text()
    out = []
    for chapter in re.split(r"(?=RXPGuides\.RegisterGuide\(\[=\[)", text)[1:]:
        for body in re.split(r"(?m)^(?=step)", chapter)[1:]:
            out.append({
                "points": [(float(x), float(y)) for x, y in re.findall(r"\.goto 2548,([\d.]+),([\d.]+)", body)],
                "complete": sorted(set(re.findall(r"\.complete -?(\d+),", body))),
                "accept": re.findall(r"\.accept (\d+)", body),
                "gated": ".isQuestTurnedIn" in body,
                "sticky": "#completewith" in body,
            })
    return out


def distance(a, b):
    return min(yards(p, q) for p in a["points"] for q in b["points"])


def late_objectives():
    route = steps()
    first_accept = {}
    for index, step in enumerate(route):
        for quest in step["accept"]:
            first_accept.setdefault(quest, index)
    objective = [(i, s) for i, s in enumerate(route) if s["complete"] and s["points"] and not s["sticky"]]
    found = set()
    for a_index, a in objective:
        for b_index, b in objective:
            if b_index <= a_index or set(a["complete"]) & set(b["complete"]) or distance(a, b) > NEAR:
                continue
            quest = b["complete"][0]
            accept_index = first_accept.get(quest)
            if accept_index is None:
                continue
            giver = route[accept_index]
            in_log = accept_index < a_index
            # The giver offers it with no prerequisite and the route has already been beside the giver.
            passed = (not giver["gated"] and giver["points"]
                      and any(s["points"] and distance(s, giver) <= GIVER for s in route[: a_index + 1]))
            if not (in_log or passed):
                continue
            left = any(distance(s, a) > AWAY for i, s in objective if a_index < i < b_index)
            # A later step for the same quest is only a fallback when the earlier visit already offered it.
            offered = any(quest in s["complete"] and distance(s, a) <= NEAR for i, s in objective if i < b_index)
            if left and not offered and (quest, a["complete"][0]) not in REVIEWED:
                found.add((quest, a["complete"][0]))
    return sorted(found)


class RouteTests(unittest.TestCase):
    def test_no_objective_left_for_a_later_visit_to_the_same_area(self):
        self.assertEqual(late_objectives(), [], "quest in the log whose area the route already worked earlier")


if __name__ == "__main__":
    print(late_objectives())
