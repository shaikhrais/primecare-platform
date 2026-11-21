"""Export a class catalog as complete CSV tables and a readable organization report."""

import argparse
import collections
import csv
import json
from pathlib import Path
from organization import ROLE_LABELS, PRIMARY_TYPES, classify

ATTRIBUTES = {
    "name": "Actual qualified declaration name",
    "kind": "AST kind: class, enum, mixin or interface",
    "primaryType": "Exactly UI, API, Test or Packages; detailed roles remain independent",
    "primaryTypeEvidence": "Reason for primary category; tests override central-library membership",
    "subpackageId": "Class source-directory identity within its library",
    "subpackagePath": "Actual library-relative directory, not a separate published package",
    "libraryId": "Source-manifest library identity, if available",
    "libraryName": "Declared library name or explicitly unmanifested source group",
    "libraryPath": "Library source directory",
    "libraryStatus": "manifest_declared, source_group_only or not_in_package_library",
    "sourceOrigin": "Test, external scope, generated path hint or unmarked source",
    "isGeneratedPathHint": "Path-based hint only; not proof of source generation",
    "architecturalRole": "Screen, section, widget, controller, model, repository, service, etc.; inferred",
    "managerId": "Declared architecture ownership group",
    "parentManagerId": "Parent of the owning manager",
    "appClass": "application, website, shared_package, backend, tooling, external or unknown",
    "isAppClass": "True only for application/website source location; does not prove deployment",
    "appName": "Application/website directory name; null for shared/backend/tooling classes",
    "sourceContainer": "Source package, application, service or tool container",
    "usageScope": "source or test; separate from architectural role",
    "classificationVersion": "Version of the deterministic organization rules",
    "classificationStatus": "Inferred labels require review",
    "classificationEvidence": "Explainable matching name/path/base rule",
    "baseName": "Declared base type, resolution tracked separately",
    "private": "Source declaration visibility",
    "abstract": "Source abstract marker where supplied by the scanner",
    "purpose": "Source-bound proposed purpose, not automatic approval",
    "rationale": "Source-bound proposed reason for this class",
    "sourceDescription": "Existing source documentation",
    "databaseStatus": "Verified presence or unknown",
    "databaseReviewStatus": "Human metadata review state; separate from presence",
    "runtimeReadiness": "not_assessed; source organization never certifies working behavior",
    "path": "Source file path",
    "line": "Source line",
    "id": "Stable source identity within the recorded path/name",
}


def safe(value):
    if value is None:
        return ""
    text = str(value)
    return "'" + text if text.startswith(("=", "+", "-", "@", "\t", "\r")) else text


def write_csv(path, fields, rows):
    with path.open("w", newline="", encoding="utf-8-sig") as handle:
        writer = csv.DictWriter(handle, fieldnames=fields)
        writer.writeheader()
        for row in rows:
            writer.writerow({key: safe(row.get(key)) for key in fields})


def export(value, output):
    output.mkdir(parents=True, exist_ok=True)
    rows = [dict(row, **classify(row)) for row in value["classes"]]
    nodes = value.get("subpackages", [])
    write_csv(
        output / "subpackages.csv",
        [
            "id",
            "libraryId",
            "parentId",
            "name",
            "relativePath",
            "path",
            "depth",
            "directDeclarations",
            "totalDeclarations",
            "packages",
            "test",
        ],
        nodes,
    )
    roles = collections.Counter(row["architecturalRole"] for row in rows)
    libraries = value.get("libraries", [])
    library_rows = []
    for library in libraries:
        members = [row for row in rows if row.get("libraryId") == library["id"]]
        library_rows.append(
            {
                "libraryId": library["id"],
                "parentLibraryId": library.get("parentLibraryId"),
                "name": library["name"],
                "path": library["path"],
                "status": library["status"],
                "manifestCount": len(library["manifests"]),
                "declarations": len(members),
                **{
                    key: sum(row["primaryType"] == key for row in members)
                    for key in PRIMARY_TYPES
                },
            }
        )
    write_csv(
        output / "libraries.csv",
        [
            "libraryId",
            "parentLibraryId",
            "name",
            "path",
            "status",
            "manifestCount",
            "declarations",
            "ui",
            "api",
            "test",
            "packages",
        ],
        library_rows,
    )

    owners = collections.Counter(row["managerId"] for row in rows)
    managers = value["managers"]
    by_id = {m["id"]: m for m in managers}
    manager_rows = []
    for manager in managers:
        descendants = {manager["id"]}
        changed = True
        while changed:
            previous = len(descendants)
            descendants.update(
                m["id"] for m in managers if m["parentId"] in descendants
            )
            changed = previous != len(descendants)
        manager_rows.append(
            {
                "manager": manager["id"],
                "parent": manager["parentId"],
                "directClasses": owners[manager["id"]],
                "includingChildren": sum(owners[key] for key in descendants),
                "purpose": manager["purpose"],
            }
        )
    app_groups = collections.Counter(
        (row["appClass"], row["appName"] or "", row["sourceContainer"]) for row in rows
    )
    write_csv(output / "all-class-attributes.csv", list(ATTRIBUTES), rows)
    write_csv(
        output / "primary-types.csv",
        ["primaryType", "label", "count", "description"],
        [
            {
                "primaryType": key,
                "label": labels[0],
                "count": sum(row["primaryType"] == key for row in rows),
                "description": labels[1],
            }
            for key, labels in PRIMARY_TYPES.items()
        ],
    )
    pairs = collections.Counter(
        (row["primaryType"], row["architecturalRole"]) for row in rows
    )
    write_csv(
        output / "types-and-classifications.csv",
        ["primaryType", "architecturalRole", "count"],
        [
            {"primaryType": key[0], "architecturalRole": key[1], "count": count}
            for key, count in sorted(pairs.items())
        ],
    )

    write_csv(
        output / "managers.csv",
        ["manager", "parent", "directClasses", "includingChildren", "purpose"],
        manager_rows,
    )
    write_csv(
        output / "architectural-roles.csv",
        ["role", "label", "count"],
        [
            {"role": role, "label": label, "count": roles[role]}
            for role, label in ROLE_LABELS.items()
        ],
    )
    write_csv(
        output / "applications.csv",
        ["appClass", "appName", "sourceContainer", "count"],
        [
            dict(
                zip(["appClass", "appName", "sourceContainer", "count"], (*key, count))
            )
            for key, count in sorted(app_groups.items())
        ],
    )
    write_csv(
        output / "roles-by-manager.csv",
        ["role"] + [m["id"] for m in managers],
        [
            {
                "role": role,
                **{
                    m["id"]: sum(
                        row["architecturalRole"] == role and row["managerId"] == m["id"]
                        for row in rows
                    )
                    for m in managers
                },
            }
            for role in ROLE_LABELS
        ],
    )
    lines = [
        "# PrimeCare class organization",
        "",
        "Recorded source: `"
        + value["sourceCommit"]
        + "`. Scan: `"
        + value["scanId"]
        + "`.",
        "",
        f"Total: **{len(rows):,} declarations**. This is the recorded production-source snapshot, not a fresh live DB query.",
        "",
        "Ownership, declaration kind, architecture role and appClass are independent dimensions. Role/appClass labels below are inferred from recorded names, source paths and bases; they require review. Screens are candidates, not verified routes. Database presence is preserved from the original production receipt; organization labels exported from an older snapshot are not proof that the new labels have been persisted.",
        "",
        "## Managers",
        "",
        "| Manager | Parent | Direct declarations | Including children |",
        "|---|---|---:|---:|",
    ]
    lines += [
        f"| {m['manager']} | {m['parent'] or '—'} | {m['directClasses']:,} | {m['includingChildren']:,} |"
        for m in manager_rows
    ]
    lines += [
        "",
        "Direct counts sum to the total. Including-children counts overlap and must not be summed.",
        "",
        "## Architecture roles",
        "",
        "| Category | Declarations |",
        "|---|---:|",
    ]
    lines += [f"| {label} | {roles[role]:,} |" for role, label in ROLE_LABELS.items()]
    lines += ["", "## Declaration kinds", "", "| AST kind | Count |", "|---|---:|"]
    lines += [
        f"| {kind} | {count:,} |"
        for kind, count in sorted(
            collections.Counter(row["kind"] for row in rows).items()
        )
    ]
    lines += [
        "",
        "## Application classification",
        "",
        "| appClass | Count |",
        "|---|---:|",
    ]
    lines += [
        f"| {key} | {count:,} |"
        for key, count in sorted(
            collections.Counter(row["appClass"] for row in rows).items()
        )
    ]
    lines += ["", "## Registry attributes", "", "| Attribute | Meaning |", "|---|---|"]
    lines += [f"| `{key}` | {description} |" for key, description in ATTRIBUTES.items()]
    lines += [
        "",
        "These attributes describe the registry entry. Exhaustive field/method member introspection is not implemented.",
        "",
        "## Research and design",
        "",
        "Flutter architecture separates views, view models, repositories and services. This taxonomy extends those roles with the actual screen sections, widgets, controllers, contracts and tooling found in this repository.",
        "",
        "Backstage separates entity kind, type, ownership and lifecycle. That supports using independent columns and filters instead of treating all UI-owned classes as screens or treating source registration as runtime readiness.",
        "",
        "- https://docs.flutter.dev/app-architecture/guide",
        "- https://backstage.io/docs/features/software-catalog/descriptor-format/",
        "",
        "Recommended review order: unknown roles; ambiguous screen candidates; duplicated sections/components; unresolved bases; missing purpose/rationale. Confirm imports, runtime registration and behavior before merging or moving classes.",
        "",
    ]
    primary_lines = [
        "## Primary types",
        "",
        "| Primary type | Count | What it includes |",
        "|---|---:|---|",
    ]
    primary_lines += [
        f"| {labels[0]} | {sum(row['primaryType'] == key for row in rows):,} | {labels[1]} |"
        for key, labels in PRIMARY_TYPES.items()
    ]
    primary_lines += [
        "",
        "Tests take precedence; all other central/shared library declarations use Packages. Primary-type counts are mutually exclusive. Generated path hints are a separate source-origin dimension; they must not be added to primary-type totals.",
        "",
    ]
    insertion = lines.index("## Managers")
    lines[insertion:insertion] = primary_lines
    (output / "Class-Organization.md").write_text("\n".join(lines))
    summary = {
        "subpackageDirectories": sum(node["depth"] > 0 for node in nodes),
        "manifestLibraries": sum(
            row["status"] == "manifest_declared" for row in libraries
        ),
        "sourceGroupsWithoutManifest": sum(
            row["status"] == "source_group_only" for row in libraries
        ),
        "sourceCommit": value["sourceCommit"],
        "scanId": value["scanId"],
        "classes": len(rows),
        "roles": dict(roles),
        "primaryTypes": dict(collections.Counter(row["primaryType"] for row in rows)),
        "sourceOrigins": dict(collections.Counter(row["sourceOrigin"] for row in rows)),
        "managers": dict(owners),
        "appClasses": dict(collections.Counter(row["appClass"] for row in rows)),
    }
    (output / "summary.json").write_text(json.dumps(summary, indent=2))
    print(json.dumps(summary))


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--catalog", type=Path, required=True)
    parser.add_argument("--output", type=Path, required=True)
    args = parser.parse_args()
    export(json.loads(args.catalog.read_text()), args.output)
