"""The TOC must load on Forever behind RXP, the package must hold only the addon, and installs must not touch RXP."""

import importlib.util
import re
import tempfile
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
SPEC = importlib.util.spec_from_file_location("installer", ROOT / "tools/install.py")
installer = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(installer)


class TocTests(unittest.TestCase):
    def test_toc_targets_forever_requires_rxp_and_says_horde_and_experimental(self):
        toc = (ROOT / "RivergladesHorde.toc").read_text()
        self.assertIn("## Interface: 16001\n", toc)
        self.assertIn("## AllowLoadGameType: camelot\n", toc)
        self.assertIn("## Dependencies: RXPGuides\n", toc)
        title = re.search(r"^## Title: (.+)$", toc, re.M).group(1)
        self.assertIn("Horde", title)
        # CurseForge moderation rejects a release stage in a project name, so it goes in the Notes.
        self.assertNotIn("Beta", title)
        self.assertIn("Experimental", re.search(r"^## Notes: (.+)$", toc, re.M).group(1))
        self.assertEqual(installer.addon_files(), ["RivergladesHorde.toc", "RivergladesHorde.lua", "LICENSE.md"])

    def test_pkgmeta_ships_only_addon_files(self):
        pkgmeta = (ROOT / ".pkgmeta").read_text()
        self.assertIn("package-as: RivergladesHorde\n", pkgmeta)
        self.assertIn("required-dependencies:\n  - restedxp-guide\n", pkgmeta)
        ignored = set(re.findall(r"^  - (\S+)$", pkgmeta.split("ignore:", 1)[1], re.M))
        shipped = {path.name for path in ROOT.iterdir() if path.name not in ignored and path.name not in {".git", ".release"}}
        self.assertEqual(shipped, set(installer.addon_files()))


class InstallTests(unittest.TestCase):
    def test_install_replaces_only_our_folder(self):
        with tempfile.TemporaryDirectory() as directory:
            addons = Path(directory)
            (addons / "RXPGuides").mkdir()
            (addons / "RXPGuides" / "RXPGuides.toc").write_text("rxp\n")
            stale = addons / "RivergladesHorde" / "old.lua"
            stale.parent.mkdir()
            stale.write_text("stale\n")
            path = installer.install(addons)
            self.assertFalse(stale.exists())
            self.assertEqual(sorted(p.name for p in path.iterdir()), sorted(installer.addon_files()))
            self.assertEqual((path / "RivergladesHorde.lua").read_bytes(), (ROOT / "RivergladesHorde.lua").read_bytes())
            self.assertEqual((addons / "RXPGuides" / "RXPGuides.toc").read_text(), "rxp\n")

    def test_install_requires_rxp(self):
        with tempfile.TemporaryDirectory() as directory:
            with self.assertRaises(ValueError):
                installer.install(Path(directory))


if __name__ == "__main__":
    unittest.main()
