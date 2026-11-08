#!/usr/bin/env python3
"""Check static route-queue parity. This does not verify screen implementation."""
import json
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
QUEUE = "docs/screen-management/platform-build-queue.json"
MODULE = "packages/primecare_ui/lib/src/screens/module_screen_registrations.dart"
WORKSPACE = "packages/primecare_ui/lib/src/screens/workspace_screen_registrations.dart"
SHARED = "packages/primecare_ui/lib/src/screens/screen_manager_catalog.dart"
GOVERNANCE = "apps/primecare_governance/lib/core/governance/route_registry.dart"
PLATFORM = "packages/primecare_ui/lib/src/features/platform/platform_master_catalog.g.dart"
GENERATED = "packages/primecare_ui/lib/src/features/auth/generated_managed_routes.g.dart"

def set_paths(text, name):
    match = re.search(r"const\s+" + re.escape(name) + r"\s*=\s*<String>\{(.*?)\};", text, re.S)
    if not match:
        raise ValueError(f"Missing explicit set: {name}")
    body = re.sub(r"//[^\n]*", "", match.group(1))
    paths = re.findall(r"'(/[^']*)'", body)
    remainder = re.sub(r"'(/[^']*)'|[\s,]", "", body)
    if remainder:
        raise ValueError(f"Unsupported expression in {name}: manual review required")
    if len(paths) != len(set(paths)):
        raise ValueError(f"Duplicate path in {name}")
    return paths

def collect(read):
    result = {}
    def add(path, source):
        result.setdefault(path, set()).add(source)
    for source, name in ((MODULE, "moduleScreenRegistrations"),
                         (WORKSPACE, "workspaceScreenRegistrations"),
                         (GENERATED, "generatedManagedScreenRoutes"),
                         (GOVERNANCE, "governanceNativeScreenRoutes"),
                         (GOVERNANCE, "governanceRegistryScreenRoutes")):
        for path in set_paths(read(source), name):
            add(path, source)
    shared = read(SHARED)
    registrations = re.findall(r"ManagedScreenRegistration\(id:\s*([^)]*)\)", shared)
    for expression in registrations:
        literal = re.fullmatch(r"'(/[^']*)'", expression.strip())
        if literal:
            add(literal.group(1), SHARED)
        elif expression.strip() == "platformAdministrationRoute":
            value = re.search(r"const platformAdministrationRoute = '(/[^']*)';", read(PLATFORM))
            if not value:
                raise ValueError("Unresolved platform administration route")
            add(value.group(1), SHARED)
        else:
            raise ValueError("Unresolved shared route: manual review required")
    if not registrations:
        raise ValueError("Missing shared registrations")
    return result

def validate(queue, expected):
    entries = queue["entries"]
    numbers = [entry["number"] for entry in entries]
    if numbers != list(range(1, len(entries) + 1)):
        raise ValueError("Queue numbers must be sequential and stable")
    paths = [entry["path"] for entry in entries]
    if len(paths) != len(set(paths)):
        raise ValueError("Duplicate queue path")
    active = {entry["path"]: entry for entry in entries if entry["status"] != "retired"}
    if set(active) != set(expected):
        missing = sorted(set(expected) - set(active))
        stale = sorted(set(active) - set(expected))
        raise ValueError(f"Route inventory changed: missing={missing}, stale={stale}")
    for path, sources in expected.items():
        if set(active[path]["sources"]) != sources:
            raise ValueError(f"Source mapping changed for {path}")
    if queue.get("count_unit") != "unique_registered_route_paths_not_verified_screens":
        raise ValueError("The queue must not claim verified screen counts")
    return len(active)

def main():
    read = lambda path: (ROOT / path).read_text(encoding="utf-8")
    count = validate(json.loads(read(QUEUE)), collect(read))
    print(f"{count} registered route paths match the queue; screen behavior is not verified.")

if __name__ == "__main__":
    main()
