#!/usr/bin/env bash
set -euo pipefail
# Test actual scheduling route sources without pulling unrelated Flutter/Prisma dependencies.
repo_root=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
test_root=$(mktemp -d)
trap 'rm -rf "$test_root"' EXIT
cat > "$test_root/pubspec.yaml" <<EOF
name: scheduling_route_validation
environment:
  sdk: '>=3.11.0 <4.0.0'
dependencies:
  server_core:
    path: '$repo_root/packages/server_core'
  shelf: ^1.4.2
  shelf_router: ^1.1.4
dev_dependencies:
  test: any
EOF
mkdir -p "$test_root/lib" "$test_root/test"
# Exact source copies give the analyzer the isolated package configuration too.
cp "$repo_root/services/scheduling_api/lib/routes.dart" "$test_root/lib/routes.dart"
cp "$repo_root/services/scheduling_api/test/routes_test.dart" "$test_root/test/routes_test.dart"
cd "$test_root"
dart pub get
dart analyze lib/routes.dart test/routes_test.dart
dart test test/routes_test.dart
