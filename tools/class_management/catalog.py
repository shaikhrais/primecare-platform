"""Combine actual AST observations with declared code managers and review metadata.

Database presence remains unknown until reconciled with an authenticated DB read.
Name/body/description overlaps are review candidates, never automatic merge orders.
"""

import argparse, ast, collections, hashlib, json, re, subprocess
from pathlib import Path
from organization import classify

ROOT = Path(__file__).resolve().parents[2]
EXCLUDED = {
    "node_modules",
    "build",
    ".dart_tool",
    ".git",
    "dist",
    ".next",
    ".cache",
    "coverage",
    "__pycache__",
    ".venv",
    "venv",
}


def digest(value):
    return hashlib.sha256(value.encode()).hexdigest()


def canonical(value):
    return json.dumps(value, sort_keys=True, separators=(",", ":"), ensure_ascii=False)


def validate_master(config):
    entries = config["managers"]
    managers = {m["id"]: m for m in entries}
    if (
        len(entries) != len(managers)
        or len([m for m in entries if m["parentId"] is None]) != 1
    ):
        raise ValueError("Exactly one master and unique managers required")
    for entry in entries:
        if (
            not re.fullmatch("[a-z][a-z0-9-]{0,63}", entry["id"])
            or not entry["purpose"].strip()
        ):
            raise ValueError("Manager identity/purpose required")
        current = entry
        seen = set()
        while current:
            if current["id"] in seen:
                raise ValueError("Manager cycle")
            seen.add(current["id"])
            parent = current["parentId"]
            if parent is not None and parent not in managers:
                raise ValueError("Unknown parent manager")
            current = managers.get(parent)
    prefixes = set()
    for rule in config["scopes"]:
        if (
            not rule["prefix"]
            or Path(rule["prefix"]).is_absolute()
            or not rule["prefix"].endswith("/")
            or rule["prefix"] in prefixes
            or ".." in Path(rule["prefix"]).parts
            or rule["manager"] not in managers
        ):
            raise ValueError("Ambiguous or invalid scope")
        prefixes.add(rule["prefix"])
    return managers


def owner(config, path):
    matches = [rule for rule in config["scopes"] if path.startswith(rule["prefix"])]
    return max(matches, key=lambda r: len(r["prefix"]))["manager"] if matches else None


def python_inventory(root):
    rows = []
    issues = []
    files = 0
    for base in [
        "apps",
        "packages",
        "services",
        "tools",
        "scripts",
        "cloudflare",
        "websites",
    ]:
        for p in sorted((root / base).rglob("*.py")):
            if any(part in EXCLUDED for part in p.parts):
                continue
            relative = p.relative_to(root).as_posix()
            files += 1
            try:
                source = p.read_text()
                tree = ast.parse(source)
            except (SyntaxError, UnicodeError):
                issues.append({"path": relative, "code": "python_parse_error"})
                continue

            def visit(node, scope=()):
                for child in ast.iter_child_nodes(node):
                    next_scope = scope
                    if isinstance(child, ast.ClassDef):
                        name = ".".join((*scope, child.name))
                        base_name = (
                            ast.unparse(child.bases[0]) if child.bases else "object"
                        )
                        rows.append(
                            {
                                "id": "python:" + digest(relative + "::" + name),
                                "name": name,
                                "language": "python",
                                "path": relative,
                                "line": child.lineno,
                                "kind": "class",
                                "private": child.name.startswith("_"),
                                "abstract": False,
                                "scope": "test"
                                if any(
                                    x in {"test", "tests", "fixtures"} for x in p.parts
                                )
                                or p.name.startswith("test")
                                else "source",
                                "baseName": base_name,
                                "interfaces": [ast.unparse(x) for x in child.bases[1:]],
                                "sourceSha256": digest(source),
                                "bodySha256": digest(
                                    ast.dump(child, include_attributes=False)
                                ),
                                "sourceDescription": ast.get_docstring(child),
                                "descriptionStatus": "needs_review",
                                "databaseStatus": "unknown",
                                "parseValid": True,
                            }
                        )
                        next_scope = (*scope, child.name)
                    elif isinstance(child, (ast.FunctionDef, ast.AsyncFunctionDef)):
                        next_scope = (*scope, child.name)
                    visit(child, next_scope)

            visit(tree)
    return {
        "language": "python",
        "files": files,
        "complete": not issues,
        "classes": rows,
        "diagnostics": issues,
    }


def assemble(config, inventories, commit, dirty):
    managers = validate_master(config)
    rows = []
    diagnostics = []
    ids = set()
    for inventory in inventories:
        diagnostics.extend(inventory["diagnostics"])
        for original in inventory["classes"]:
            row = dict(original)
            if row["id"] in ids:
                raise ValueError("Duplicate class identity")
            ids.add(row["id"])
            row["managerId"] = owner(config, row["path"])
            row["parentManagerId"] = (
                managers[row["managerId"]]["parentId"] if row["managerId"] else None
            )
            override = config.get("descriptions", {}).get(row["id"], {})
            if override and override.get("sourceSha256") != row["sourceSha256"]:
                raise ValueError("Description proposal is stale or lacks source hash")
            row["purpose"] = override.get("purpose")
            row["rationale"] = override.get("rationale")
            row["reviewStatus"] = "needs_review"
            row["descriptionStatus"] = (
                "documented"
                if row["purpose"] or row.get("sourceDescription")
                else "missing"
            )
            row["databaseStatus"] = "unknown"
            row.update(classify(row))
            if row.get("sourceDescription"):
                row["sourceDescription"] = row["sourceDescription"][:4000]
            rows.append(row)
    names = collections.defaultdict(list)
    for row in rows:
        names[(row["language"], row["name"].split(".")[-1])].append(row)
    bases = {}
    for row in rows:
        raw = row.get("baseName")
        if not raw:
            row["baseId"] = None
            continue
        bare = re.split(r"[<\[]", raw)[0].split(".")[-1]
        candidates = names.get((row["language"], bare), [])
        local = [x for x in candidates if x["path"] == row["path"]]
        external = (
            row["language"] == "dart" and bare in config["externalBases"] and not local
        ) or (
            row["language"] == "python"
            and bare in {"object", "Exception", "BaseException", "ABC"}
        )
        declared = config.get("baseBindings", {}).get(row["id"])
        target = (
            next((candidate for candidate in rows if candidate["id"] == declared), None)
            if declared
            else None
        )
        if declared and target is None:
            raise ValueError("Declared source base not found")
        resolution = (
            "source_resolved"
            if target
            else "external_declared"
            if external
            else "needs_resolution"
        )
        base_id = (
            ("class:" + target["id"])
            if target
            else row["language"]
            + ":base:"
            + digest((bare if external else row["path"] + "::" + raw))
        )
        row["baseId"] = base_id
        if base_id not in bases:
            bases[base_id] = {
                "id": base_id,
                "name": raw,
                "managerId": target["managerId"]
                if target
                else "external"
                if external
                else None,
                "sourceClassId": target["id"] if target else None,
                "resolution": resolution,
                "candidateClassIds": [x["id"] for x in candidates],
            }
    findings = []
    for reason, key in [
        ("same_public_name", "name"),
        ("same_syntax", "bodySha256"),
        ("same_description", "sourceDescription"),
    ]:
        groups = collections.defaultdict(list)
        for row in rows:
            value = row.get(key)
            if (
                row.get("private")
                or not value
                or (key == "sourceDescription" and len(value) < 40)
            ):
                continue
            groups[(row["language"], value)].append(row["id"])
        for (language, value), members in groups.items():
            if len(members) > 1:
                findings.append(
                    {
                        "id": digest(reason + "::" + language + "::" + value),
                        "kind": reason,
                        "classIds": sorted(members),
                        "status": "candidate_needs_review",
                        "automaticMerge": False,
                    }
                )
    rows.sort(key=lambda row: row["id"])
    findings.sort(key=lambda row: row["id"])
    result = {
        "format": 1,
        "sourceCommit": commit,
        "workingTreeDirty": dirty,
        "complete": all(i["complete"] for i in inventories),
        "coverage": {
            i["language"]: {
                "files": i["files"],
                "classes": len(i["classes"]),
                "complete": i["complete"],
            }
            for i in inventories
        },
        "managers": config["managers"],
        "classes": rows,
        "baseClasses": sorted(bases.values(), key=lambda x: x["id"]),
        "findings": findings,
        "diagnostics": diagnostics,
        "registrySha256": digest(canonical(config)),
        "limitations": [
            "AST parsing is not type checking or runtime acceptance.",
            "Cross-file base names are candidates until resolved; no guessed ownership is approved.",
            "Dynamic runtime class factories and dependencies outside this repository are not fully inventoried.",
            "Database presence is unknown until production read-back; all review statuses start needs_review.",
        ],
    }
    result["scanId"] = digest(canonical(result))
    return result


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--root", type=Path, default=ROOT)
    parser.add_argument("--dart", type=Path, required=True)
    parser.add_argument("--typescript", type=Path, required=True)
    parser.add_argument("--output", type=Path, required=True)
    args = parser.parse_args()
    config = json.loads(
        (args.root / "tools/class_management/master_registry.json").read_text()
    )
    commit = subprocess.check_output(
        ["git", "rev-parse", "HEAD"], cwd=args.root, text=True
    ).strip()
    dirty = bool(
        subprocess.check_output(
            ["git", "status", "--porcelain"], cwd=args.root, text=True
        ).strip()
    )
    result = assemble(
        config,
        [
            json.loads(args.dart.read_text()),
            json.loads(args.typescript.read_text()),
            python_inventory(args.root),
        ],
        commit,
        dirty,
    )
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(canonical(result))
    print(
        json.dumps(
            {
                "scanId": result["scanId"],
                "coverage": result["coverage"],
                "classes": len(result["classes"]),
                "baseClasses": len(result["baseClasses"]),
                "findings": len(result["findings"]),
                "complete": result["complete"],
            }
        )
    )


if __name__ == "__main__":
    main()
