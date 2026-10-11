# Legacy file retirement — 11 October 2026

The pre-skeleton screen backup was removed from the current checkout: **17,291 files, 25,457,517 bytes**. Its tree identity is identical in the local snapshot and published recovery commit. No active app, package, Worker or GitHub workflow references the directory. Auth/Admin runtime, inherited classes, translations, schemas, migrations and deployment files are retained.

| Removed purpose | Files |
|---|---:|
| Screen sections | 9,100 |
| State/providers | 2,011 |
| Service/API adapters | 2,011 |
| Screens | 1,126 |
| Data models | 1,127 |
| Test scenarios | 1,901 |
| Routing/navigation | 12 |
| Supporting artifacts | 3 |

These archived implementations are not current skeleton dependencies. Full source remains in Git. This reduces checkout files, not repository history size.

## Per-file information and importance

`file-inventory.csv.gz` records all **34,693 tracked paths at the pre-deletion snapshot**: disposition, purpose, topic, Git blob identity, bytes, extracted declarations, endpoint references, importance and recovery commit for deleted files. `summary.json` records totals and the SHA-256 of the decompressed inventory. The snapshot excludes this newly created report/tooling. The existing governance database is not modified.

Purpose/topic are source-path classifications. Declarations/endpoints are extracted evidence, not a complete business specification. Old screens may contain useful requirements or customized behavior despite being disconnected. Future rewrites must inspect full historical source, current domain/contracts/database definitions and behavior tests before defining rules.

```python
import csv, gzip
with gzip.open('docs/refactoring/legacy-retirement-20261011/file-inventory.csv.gz', 'rt', newline='') as file:
    for record in csv.DictReader(file):
        if record['decision'] == 'delete_archived_backup':
            print(record['path'], record['purpose'], record['declarations'])
```

## Exact recovery

Published recovery commit: `9c1940505df948975775071db8a903e11e7859bb`, on `deploy/email-inbox-20261010` in `shaikhrais/primecare-platform`. Backup tree: `303d846c72c79359d715c64fbe8f99067d41e003`. Fetch branch history if the commit is unavailable locally.

Inspect an old file without restoring the whole tree:

```bash
git show 9c1940505df948975775071db8a903e11e7859bb:generated_screen_backup_before_template_reset/screens/clinical/cns_dashboard/cns_dashboard_screen.dart
```

Local pre-deletion commit `b18249e5e1e6aaca5fa693c1e2bf117209fc326a` contains the same backup tree. Do not reconnect all former screens to implement one role.

## Retained files

**17,402 pre-existing tracked files remain**: 2,680 under runtime, contract, build or tooling roots; 14,722 needing further dependency/behavior review. These counts are not a remaining implementation backlog. Live APIs, business services and database definitions may still be important; replacement coverage is not established. Other previews, reports, tools and historical tests remain for review rather than removal merely because they are untouched.

The command entry point of `tools/governance/recreate_clean_templates.py` is disabled to prevent recreating retired screens. Its implementation remains readable as historical tooling. Previous backup/deletion reports remain historical records; resolve their archived paths through the recovery commit.

## Verification

The retirement command verifies every deleted file against its Git blob identity and refuses local/staged changes or mismatched recovery trees before deleting. Only tracked files are removed; untracked content is preserved. Four tests cover dry-run records, preservation of untracked/live files, dirty-file refusal and recovery-tree refusal. Auth/Admin regression results will be recorded after CI completes.
