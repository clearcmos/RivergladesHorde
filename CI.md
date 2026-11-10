# Releases

Releases are built and uploaded by GitHub Actions with [BigWigsMods/packager](https://github.com/BigWigsMods/packager) (`.github/workflows/release.yml`). Pushing a tag that starts with `v` packages the addon, uploads it to CurseForge and attaches the zip to a GitHub release.

## Secrets

The repository needs two Actions secrets:

- `CF_API_KEY`: a CurseForge API token (CurseForge author account, API tokens).
- `CURSEFORGE_PROJECT_ID`: the numeric project ID from the project's About section.

## What ships

`.pkgmeta` packages the repository as the `CMOS_Riverglades` folder and ignores everything that is not the addon: docs, tests, tools and config. The zip holds `CMOS_Riverglades.toc`, `CMOS-Riverglades.lua` and `LICENSE.md`. `CHANGELOG.md` becomes the release notes but is not in the zip.

`required-dependencies` lists RestedXP Guide (`restedxp-guide`, CurseForge project 486246), so each upload declares it and the CurseForge app installs it alongside.

The packager reads `## Interface: 16001` from the TOC and uploads the file for WoW Forever (game version 1.60.1).

## Release steps

1. Run `bash tools/check.sh`, luacheck and stylua (README, Development).
2. Bump `## Version` in `CMOS_Riverglades.toc`, bump `#version` on each changed chapter in `CMOS-Riverglades.lua`, and add a `CHANGELOG.md` entry.
3. Commit and push, then tag and push the tag: `git tag vX.Y.Z && git push origin main --tags`.
4. Watch the run with `gh run watch`, then check the upload on CurseForge. A new file goes through review before it can be downloaded.

To check a package without uploading, fetch the packager's `release.sh` and run `bash release.sh -d -z -t <repo> -r <outdir>` from outside the repository (`-d` skips the upload, `-z` the zip); `<outdir>/CMOS_Riverglades/` should hold only the three addon files.
