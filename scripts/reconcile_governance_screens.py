#!/usr/bin/env python3
"""Reconcile governed screen metadata with evidence in the repository.

The historical generators populated component_summary and section_summary from
templates.  That made the database look complete even when those symbols did
not occur in the implementation.  This command computes both summaries from
the Dart source and checks the minimum evidence required for a governed screen.

Use --check in CI (read-only) and --write to update the SQLite database.
"""

from __future__ import annotations

import argparse
import json
import re
import sqlite3
import sys
from dataclasses import asdict, dataclass
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
DEFAULT_DB = ROOT / ".agents" / "governance" / "governance.db"
CLASS_RE = re.compile(r"\bclass\s+([A-Za-z_]\w*)\b")
CONSTRUCTOR_RE = re.compile(r"(?<![.\w])([A-Z][A-Za-z0-9_]*)\s*\(")
SCREEN_CLASS_RE = re.compile(
    r"\bclass\s+([A-Za-z_]\w*Screen)\s+extends\s+([A-Za-z_]\w*)"
)
ROUTE_RE = re.compile(r"(?<![\w-])(/[A-Za-z0-9_:/.-]+)")

# Constructors that are syntax/value objects rather than rendered components.
NON_COMPONENTS = {
    "Border", "BorderRadius", "BoxConstraints", "BoxDecoration", "Color",
    "DateTime", "Duration", "EdgeInsets", "LinearGradient", "Map", "Offset",
    "Radius", "RoundedRectangleBorder", "TextStyle", "Uri",
}


@dataclass
class ScreenResult:
    screen_id: int
    screen_code: str
    file: str
    classes: list[str]
    components: list[str]
    sections: list[str]
    score: int
    issues: list[str]


def normalize(value: str) -> str:
    return re.sub(r"[^a-z0-9]+", "", value.lower())


def table_columns(conn: sqlite3.Connection, table: str) -> set[str]:
    return {row[1] for row in conn.execute(f"PRAGMA table_info({table})")}


def pom_routes(root: Path) -> set[str]:
    routes: set[str] = set()
    pom_root = root / "testingFramework1.0" / "src" / "test" / "java" / "PageObjects" / "primecare" / "ui"
    if not pom_root.exists():
        return routes
    for path in pom_root.glob("*.java"):
        try:
            routes.update(ROUTE_RE.findall(path.read_text(encoding="utf-8", errors="ignore")))
        except OSError:
            continue
    return routes


def inspect_screen(
    root: Path,
    screen: sqlite3.Row,
    section_names: list[str],
    known_routes: set[str],
) -> ScreenResult:
    rel_path = (screen["actual_file_path"] or "").replace("\\", "/")
    path = root / rel_path
    issues: list[str] = []
    if not rel_path or not path.is_file():
        return ScreenResult(screen["id"], screen["screen_code"], rel_path, [], [], [], 0, ["missing_file"])

    source = path.read_text(encoding="utf-8", errors="ignore")
    classes = sorted(set(CLASS_RE.findall(source)))
    screen_classes = SCREEN_CLASS_RE.findall(source)
    components = sorted(
        token for token in set(CONSTRUCTOR_RE.findall(source))
        if token not in NON_COMPONENTS and not token.startswith("_")
    )
    rendered_sections = sorted(
        name for name in section_names
        if normalize(name) in normalize(source)
    )

    score = 25  # physical Dart implementation exists
    if screen_classes:
        score += 15
    else:
        issues.append("missing_screen_class")
    if "Widget build" in source or "Widget buildScreen" in source:
        score += 15
    else:
        issues.append("missing_build_method")
    if components:
        score += 10
    else:
        issues.append("no_rendered_components")
    if not section_names or len(rendered_sections) == len(section_names):
        score += 10
    else:
        issues.append(f"sections_not_rendered:{len(section_names) - len(rendered_sections)}")
    if re.search(r"\b(apiClientProvider|\.get\(|\.post\(|\.put\(|\.patch\(|\.delete\()", source):
        score += 10
    else:
        issues.append("no_api_evidence")
    if re.search(r"\b(AsyncValue|CircularProgressIndicator|loading|error)\b", source, re.I):
        score += 5
    else:
        issues.append("no_state_evidence")
    if re.search(r"\b(Semantics|Key\s*\(|testId|test_id)\b", source):
        score += 5
    else:
        issues.append("no_accessibility_or_test_marker")
    route = screen["route_path"] or ""
    if route in known_routes:
        score += 5
    else:
        issues.append("missing_pom_route")

    return ScreenResult(
        screen["id"], screen["screen_code"], rel_path, classes,
        components, rendered_sections, score, issues,
    )


def reconcile(db_path: Path, write: bool, report_path: Path | None) -> int:
    conn = sqlite3.connect(db_path)
    conn.row_factory = sqlite3.Row
    columns = table_columns(conn, "screens")
    required = {"id", "screen_code", "route_path", "actual_file_path", "active"}
    if not required <= columns:
        raise RuntimeError(f"screens table is missing: {sorted(required - columns)}")

    routes = pom_routes(ROOT)
    screens = conn.execute(
        "SELECT * FROM screens WHERE active = 1 ORDER BY id"
    ).fetchall()
    results: list[ScreenResult] = []
    metadata_drift: list[str] = []
    for screen in screens:
        section_names = [
            row[0] for row in conn.execute(
                "SELECT section_name FROM screen_sections WHERE screen_id = ? AND required = 1 ORDER BY section_order",
                (screen["id"],),
            )
        ]
        result = inspect_screen(ROOT, screen, section_names, routes)
        results.append(result)
        expected = {
            "component_summary": ", ".join(result.components),
            "section_summary": ", ".join(result.sections),
            "completeness_score": result.score,
            "production_ready": int(result.score == 100 and not result.issues),
        }
        if any(key in columns and screen[key] != value for key, value in expected.items()):
            metadata_drift.append(result.screen_code)

    if write:
        conn.execute("BEGIN")
        for result in results:
            values: dict[str, object] = {}
            if "component_summary" in columns:
                values["component_summary"] = ", ".join(result.components)
            if "section_summary" in columns:
                values["section_summary"] = ", ".join(result.sections)
            if "completeness_score" in columns:
                values["completeness_score"] = result.score
            # Production readiness must be supported by every evidence category.
            if "production_ready" in columns:
                values["production_ready"] = int(result.score == 100 and not result.issues)
            if values:
                assignments = ", ".join(f"{key} = ?" for key in values)
                conn.execute(
                    f"UPDATE screens SET {assignments} WHERE id = ?",
                    (*values.values(), result.screen_id),
                )
        conn.commit()

    issue_counts: dict[str, int] = {}
    for result in results:
        for issue in result.issues:
            key = issue.split(":", 1)[0]
            issue_counts[key] = issue_counts.get(key, 0) + 1
    summary = {
        "active_screens": len(results),
        "files_present": sum("missing_file" not in r.issues for r in results),
        "fully_evidenced": sum(not r.issues for r in results),
        "average_score": round(sum(r.score for r in results) / max(len(results), 1), 2),
        "metadata_drift": 0 if write else len(metadata_drift),
        "issue_counts": dict(sorted(issue_counts.items())),
        "screens": [asdict(r) for r in results if r.issues],
    }
    output = json.dumps(summary, indent=2)
    if report_path:
        report_path.parent.mkdir(parents=True, exist_ok=True)
        report_path.write_text(output + "\n", encoding="utf-8")
    print(json.dumps({key: value for key, value in summary.items() if key != "screens"}, indent=2))
    conn.close()
    structural_issues = {
        "missing_file", "missing_screen_class", "missing_build_method",
        "no_rendered_components", "sections_not_rendered", "missing_pom_route",
    }
    has_structural_issue = any(name in structural_issues for name in issue_counts)
    return 1 if (not write and (metadata_drift or has_structural_issue)) else 0


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--db", type=Path, default=DEFAULT_DB)
    mode = parser.add_mutually_exclusive_group()
    mode.add_argument("--check", action="store_true", help="audit without changing the database")
    mode.add_argument("--write", action="store_true", help="reconcile summaries and readiness")
    parser.add_argument("--report", type=Path, help="optional JSON detail report")
    args = parser.parse_args()
    if not args.db.is_file():
        parser.error(f"database not found: {args.db}")
    return reconcile(args.db.resolve(), args.write, args.report)


if __name__ == "__main__":
    sys.exit(main())
