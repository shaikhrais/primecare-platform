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
    for item in records.values():
        parents = [
            candidate
            for candidate in records.values()
            if candidate["id"] != item["id"]
            and item["path"].startswith(candidate["pathPrefix"])
        ]
        item["parentLibraryId"] = (
            max(parents, key=lambda entry: len(entry["pathPrefix"]))["id"]
            if parents
            else None
        )
    return sorted(records.values(), key=lambda row: row["path"])


def library_binding(row, libraries):
    matches = [item for item in libraries if row["path"].startswith(item["pathPrefix"])]
    item = max(matches, key=lambda entry: len(entry["pathPrefix"])) if matches else None
    relative = (
        PurePosixPath(row["path"]).relative_to(item["path"]).parent if item else None
    )
    parts = relative.parts if relative is not None else ()
    ancestors = (
        [
            module_id(
                item["id"], PurePosixPath(*parts[:level]).as_posix() if level else "."
            )
            for level in range(len(parts) + 1)
        ]
        if item
        else []
    )
    return {
        "subpackageId": ancestors[-1] if ancestors else None,
        "subpackagePath": relative.as_posix() if relative is not None else None,
        "subpackageAncestors": ancestors,
        "libraryId": item["id"] if item else None,
        "libraryName": item["name"] if item else None,
        "libraryPath": item["path"] if item else None,
        "libraryStatus": item["status"] if item else "not_in_package_library",
    }


def module_id(library_id, relative_path):
    return (
        "subpackage:"
        + hashlib.sha256((library_id + "::" + relative_path).encode()).hexdigest()
    )


def build_subpackages(rows, libraries):
    """Actual class-containing source directories; counts include descendants once."""
    nodes = {}
    by_id = {item["id"]: item for item in libraries}

    def ensure(library, relative):
        parts = () if relative == "." else PurePosixPath(relative).parts
        key = module_id(library["id"], relative)
        if key not in nodes:
            parent = (
                module_id(
                    library["id"],
                    PurePosixPath(*parts[:-1]).as_posix() if len(parts) > 1 else ".",
                )
                if parts
                else None
            )
            nodes[key] = {
                "id": key,
                "libraryId": library["id"],
                "parentId": parent,
                "name": parts[-1] if parts else "Library root",
                "relativePath": relative,
                "path": library["path"] + ("/" + relative if parts else ""),
                "depth": len(parts),
                "directDeclarations": 0,
                "totalDeclarations": 0,
                "packages": 0,
                "test": 0,
            }
        return nodes[key]

    for library in libraries:
        ensure(library, ".")
    for row in rows:
        library = by_id.get(row.get("libraryId"))
        if not library:
            continue
        relative = PurePosixPath(row["path"]).relative_to(library["path"]).parent
        parts = relative.parts
        for level in range(len(parts) + 1):
            rel = PurePosixPath(*parts[:level]).as_posix() if level else "."
            node = ensure(library, rel)
            node["totalDeclarations"] += 1
            if level == len(parts):
                node["directDeclarations"] += 1
            if row["primaryType"] in {"packages", "test"}:
                node[row["primaryType"]] += 1
    return sorted(
        nodes.values(), key=lambda node: (node["libraryId"], node["relativePath"])
    )
