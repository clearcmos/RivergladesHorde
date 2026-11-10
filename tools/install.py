#!/usr/bin/env python3
"""Copy the addon (the TOC, the files it loads, and the license) into a WoW AddOns directory."""

import argparse
import shutil
from pathlib import Path

PROJECT = Path(__file__).resolve().parents[1]
ADDON = "CMOS_Riverglades"


def addon_files(project: Path = PROJECT) -> list:
    """The TOC, every file it loads, and the license: what the packager ships."""
    toc = (project / f"{ADDON}.toc").read_text()
    loaded = [line.strip() for line in toc.splitlines() if line.strip() and not line.startswith("#")]
    return [f"{ADDON}.toc", *loaded, "LICENSE.md"]


def install(addons: Path, project: Path = PROJECT) -> Path:
    """Replace AddOns/CMOS_Riverglades with this project's copy; RXPGuides must already be there."""
    if not (addons / "RXPGuides" / "RXPGuides.toc").is_file():
        raise ValueError(f"No RXPGuides addon in {addons}")
    files = addon_files(project)
    for name in files:
        if not (project / name).is_file():
            raise FileNotFoundError(project / name)
    destination = addons / ADDON
    if destination.exists():
        shutil.rmtree(destination)
    destination.mkdir()
    for name in files:
        shutil.copy2(project / name, destination / name)
    return destination


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("addons", type=Path, help="The game's Interface/AddOns directory")
    args = parser.parse_args()
    try:
        path = install(args.addons)
    except (OSError, ValueError) as error:
        parser.exit(1, f"Install failed: {error}\n")
    print(f"Installed {path}. A new addon folder needs a client restart; later changes load with /reload.")
