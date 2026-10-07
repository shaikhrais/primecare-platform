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
import hashlib
import json
import re
import sqlite3
import sys
from dataclasses import asdict, dataclass
from functools import lru_cache
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
DEFAULT_DB = ROOT / ".agents" / "governance" / "governance.db"
WORKSPACE_RENDERER = 'packages/primecare_ui/lib/src/features/workspace/governed_workspace_screen.dart'
# Bounded reviewed renderer: changed control flow requires another source review.
WORKSPACE_RENDERER_SHA256 = '89b02a3fda665d96419d641f57878ee072587fa7133c5ab8c40b1b47e1a1f4ea'
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

@lru_cache(maxsize=8)
def registry_pages(path: Path, modified_ns: int, size: int) -> list[dict]:
    return json.loads(path.read_text())['screens']


def dynamic_sections(root: Path, screen: sqlite3.Row, names: list[str], source: str) -> list[str]:
    """Registered structural rendering evidence, never business completion.

    This reviewed renderer selects the authorized page by route, iterates its
    registered sections inside the returned ListView, calls _section, and
    returns a visible card containing section name and stable semantics.
    Pinning its full source rejects dead loops or non-rendering modifications.
    """
    if screen['actual_file_path'] != WORKSPACE_RENDERER:
        return []
    if hashlib.sha256(source.encode()).hexdigest() != WORKSPACE_RENDERER_SHA256:
        return []
    path = root / 'cloudflare/workers/src/workspace-registry.json'
    try:
        stat = path.stat()
        pages = registry_pages(path, stat.st_mtime_ns, stat.st_size)
        matches = [p for p in pages if p['code'] == screen['screen_code'] and p['route'] == screen['route_path']]
        if len(matches) != 1:
            return []
        sections = matches[0]['sections']
        if any(not s.get('code') or not s.get('name') or s.get('testId') != 'section-' + s['code'] for s in sections):
            return []
        codes = [s['code'] for s in sections]
        if len(codes) != len(set(codes)):
            return []
        registered = [s['name'] for s in sections]
        return sorted(names) if all(registered.count(name) == 1 for name in names) else []
    except (OSError, ValueError, KeyError, TypeError):
        return []


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
    if not rendered_sections and section_names:
        rendered_sections = dynamic_sections(root, screen, section_names, source)

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
    if write and db_path.resolve() == DEFAULT_DB.resolve():
        raise ValueError("Tracked seed is immutable; use a disposable derived database")
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
    section_snapshot = [tuple(r) for r in conn.execute('SELECT * FROM screen_sections ORDER BY rowid')]
    schema_snapshot = [tuple(r) for r in conn.execute('PRAGMA table_info(screens)')]
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
            # Static structure and source bindings never establish readiness.
            "production_ready": 0,
        }
        if any(key in columns and screen[key] != value for key, value in expected.items()):
            metadata_drift.append(result.screen_code)

    if write:
        try:
            conn.execute("BEGIN IMMEDIATE")
            locked_screens = conn.execute('SELECT * FROM screens WHERE active=1 ORDER BY id').fetchall()
            if [dict(r) for r in locked_screens] != [dict(r) for r in screens] or section_snapshot != [tuple(r) for r in conn.execute('SELECT * FROM screen_sections ORDER BY rowid')] or schema_snapshot != [tuple(r) for r in conn.execute('PRAGMA table_info(screens)')]:
                raise ValueError('Source metadata changed before archive lock; no corrections applied')
            for trigger in conn.execute("SELECT name,sql FROM sqlite_master WHERE type='trigger'"):
                if re.search(r'\b(screens|screen_metadata_reconciliation_archive)\b', trigger['sql'] or '', re.I):
                    raise ValueError('Unreviewed screen/archive trigger: ' + trigger['name'])
            existing_archive = list(conn.execute('PRAGMA table_info(screen_metadata_reconciliation_archive)'))
            expected_archive = [('screen_id','INTEGER',1,1),('original_digest','TEXT',1,2),('original_row_json','TEXT',1,0),('corrected_metadata_json','TEXT',1,0),('evidence_policy','TEXT',1,0),('archived_at','TEXT',1,0)]
            if existing_archive and [(r['name'],r['type'],r['notnull'],r['pk']) for r in existing_archive] != expected_archive:
                raise ValueError('Unreviewed archive schema')
            conn.execute('''CREATE TABLE IF NOT EXISTS screen_metadata_reconciliation_archive (
                screen_id INTEGER NOT NULL, original_digest TEXT NOT NULL,
                original_row_json TEXT NOT NULL, corrected_metadata_json TEXT NOT NULL,
                evidence_policy TEXT NOT NULL, archived_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
                PRIMARY KEY(screen_id, original_digest))''')
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
                    values["production_ready"] = 0
                original = next(s for s in screens if s['id'] == result.screen_id)
                if values and any(original[key] != value for key, value in values.items()):
                    raw = json.dumps(dict(original), sort_keys=True, ensure_ascii=False)
                    original_digest = hashlib.sha256(raw.encode()).hexdigest()
                    corrected = json.dumps(values, sort_keys=True)
                    policy = 'Reviewed source structure only; production readiness remains false'
                    previous = conn.execute('SELECT original_row_json,corrected_metadata_json,evidence_policy FROM screen_metadata_reconciliation_archive WHERE screen_id=? AND original_digest=?',(result.screen_id,original_digest)).fetchone()
                    if previous and tuple(previous) != (raw,corrected,policy):
                        raise ValueError('Archived provenance conflict')
                    conn.execute('''INSERT OR IGNORE INTO screen_metadata_reconciliation_archive
                        (screen_id,original_digest,original_row_json,corrected_metadata_json,evidence_policy)
                        VALUES (?,?,?,?,?)''', (result.screen_id, original_digest, raw,corrected,policy))
                    stored = conn.execute('SELECT original_row_json,corrected_metadata_json,evidence_policy FROM screen_metadata_reconciliation_archive WHERE screen_id=? AND original_digest=?',(result.screen_id,original_digest)).fetchone()
                    if not stored or tuple(stored) != (raw,corrected,policy):
                        raise ValueError('Archive preservation verification failed')
                    assignments = ", ".join(f"{key} = ?" for key in values)
                    conn.execute(
                        f"UPDATE screens SET {assignments} WHERE id = ?",
                        (*values.values(), result.screen_id),
                    )
            conn.commit()
        except BaseException:
            conn.rollback()
            conn.close()
            raise

    issue_counts: dict[str, int] = {}
    for result in results:
        for issue in result.issues:
            key = issue.split(":", 1)[0]
            issue_counts[key] = issue_counts.get(key, 0) + 1
    summary = {
        "active_screens": len(results),
        "files_present": sum("missing_file" not in r.issues for r in results),
        "static_structure_evidenced": sum(not r.issues for r in results),
        "evidence_scope": "static_source_structure_and_registered_bindings; no runtime, accessibility or business completion",
        "production_ready_promotions": 0,
        "average_static_source_score": round(sum(r.score for r in results) / max(len(results), 1), 2),
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
    if args.write and args.db.resolve() == DEFAULT_DB.resolve():
        parser.error('--write requires a disposable derived database; the tracked seed is immutable')
    return reconcile(args.db.resolve(), args.write, args.report)


if __name__ == "__main__":
    sys.exit(main())
