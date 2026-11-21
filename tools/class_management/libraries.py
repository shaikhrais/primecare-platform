"""Source-manifest library inventory. A directory without a manifest is not a package claim."""

import hashlib, json
from pathlib import Path, PurePosixPath
import yaml

SKIP = {
    "node_modules",
    "build",
    ".git",
    ".dart_tool",
    "dist",
    ".cache",
    ".venv",
    "venv",
}


def discover_libraries(root):
    records = {}
    package_root = root / "packages"
    if not package_root.exists():
        return []

    def record(directory):
        relative = directory.relative_to(root).as_posix()
        return records.setdefault(
            relative,
            {
                "id": "library:" + hashlib.sha256(relative.encode()).hexdigest(),
                "path": relative,
                "pathPrefix": relative + "/",
                "name": directory.name,
                "names": [],
                "manifests": [],
                "status": "source_group_only",
            },
        )

    for directory in sorted(package_root.iterdir()):
        if (
            directory.is_dir()
            and not directory.is_symlink()
            and directory.name not in SKIP
        ):
            record(directory)
    for pattern in ["pubspec.yaml", "package.json"]:
        for path in sorted(package_root.rglob(pattern)):
            if path.is_symlink() or any(
                part in SKIP for part in path.relative_to(root).parts
            ):
                continue
            text = path.read_text()
            parsed = (
                yaml.safe_load(text) if pattern.endswith("yaml") else json.loads(text)
            )
            if (
                not isinstance(parsed, dict)
                or not isinstance(parsed.get("name"), str)
                or not parsed["name"].strip()
            ):
                raise ValueError(
                    "Library manifest requires a declared name: "
                    + path.relative_to(root).as_posix()
                )
            item = record(path.parent)
            item["names"].append(parsed["name"])
            item["name"] = parsed["name"]
            item["status"] = "manifest_declared"
            item["manifests"].append(
                {
                    "path": path.relative_to(root).as_posix(),
                    "sha256": hashlib.sha256(text.encode()).hexdigest(),
                    "kind": "dart" if pattern.endswith("yaml") else "node",
                    "name": parsed["name"],
                }
            )
    return sorted(records.values(), key=lambda row: row["path"])


def library_binding(row, libraries):
    matches = [item for item in libraries if row["path"].startswith(item["pathPrefix"])]
    item = max(matches, key=lambda entry: len(entry["pathPrefix"])) if matches else None
    return {
        "libraryId": item["id"] if item else None,
        "libraryName": item["name"] if item else None,
        "libraryPath": item["path"] if item else None,
        "libraryStatus": item["status"] if item else "not_in_package_library",
    }
