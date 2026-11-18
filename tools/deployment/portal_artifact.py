"""Verify the exact built bundle, including files outside the live asset stamp."""
import argparse
import json
from pathlib import Path

from .typescript_release import STAMP, digest, make_stamp, validate
from .http_client import read_public_asset


def receipt(root, project, commit):
    root = Path(root)
    if root.is_symlink() or not root.is_dir():
        raise ValueError("Release output must be a real directory")
    files = {}
    for path in sorted(root.rglob("*")):
        if path.is_symlink() or not (path.is_dir() or path.is_file()):
            raise ValueError("Release contains a link or non-file entry")
        if path.is_file():
            files[path.relative_to(root).as_posix()] = digest(path.read_bytes())
    if not {"_headers", "_redirects", STAMP} <= files.keys():
        raise ValueError("Release is missing Pages routing or its identity")
    stamp = json.loads((root / STAMP).read_text())
    if stamp != make_stamp(root, project, commit):
        raise ValueError("Release files differ from the source stamp")
    manifest = json.loads((root / "portal.json").read_text())
    if manifest.get("project") != project:
        raise ValueError("Portal manifest project differs from release target")
    return {"commit": commit, "project": project, "files": files}


def same_portal_contract(root, prior_stamp, reader=read_public_asset):
    project, commit = prior_stamp.get("project"), prior_stamp.get("commit")
    if project != "primecare-governance":
        raise ValueError("No fast path for this project")
    prior = validate(prior_stamp, project, commit)
    url = f"https://{project}.pages.dev/portal.json?primecare-release={commit}"
    content = reader(url)
    if digest(content) != prior["files"]["portal.json"]:
        raise ValueError("Live manifest differs from the previous release")
    live = json.loads(content)
    candidate = json.loads((Path(root) / "portal.json").read_text())
    for obj in (live, candidate):
        if obj.get("project") != project:
            raise ValueError("Invalid manifest project")
        obj.pop("generatedAt", None)
    if live != candidate:
        raise ValueError("Governance metadata changed; use the full release path")


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument("mode", choices=("seal", "check", "check-contract"))
    p.add_argument("bundle", type=Path)
    p.add_argument("project")
    p.add_argument("commit")
    p.add_argument("receipt", type=Path)
    args = p.parse_args()
    if args.receipt.resolve().is_relative_to(args.bundle.resolve()):
        p.error("Receipt must be outside the bundle")
    if args.mode == "check-contract":
        same_portal_contract(args.bundle, json.loads(args.receipt.read_text()))
        return
    result = receipt(args.bundle, args.project, args.commit)
    if args.mode == "seal":
        args.receipt.write_text(json.dumps(result, sort_keys=True) + "\n")
    elif json.loads(args.receipt.read_text()) != result:
        raise ValueError("Artifact does not match the tested build")


if __name__ == "__main__":
    main()
