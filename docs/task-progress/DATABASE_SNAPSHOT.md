# Saved governance database checkpoint

The complete governance database, including six engineering tracking records and the current recovery snapshot, is preserved in `.agents/governance/governance-recovery-snapshot.db.gz`. Hashes and byte counts are in `database-snapshot.json`. The ordinary tracked database on the remotely published checkpoint remains the earlier baseline; the compressed file preserves the updated database exactly.

To extract a separate review copy, run:

```sh
gzip -dc .agents/governance/governance-recovery-snapshot.db.gz > /tmp/primecare-governance-recovered.db
```

The normal progress script can reproduce tracking tables from the committed seed and evidence. Existing database records should be reconciled rather than overwritten blindly. The remote checkpoint is published through the connected GitHub app because direct Git push credentials are unavailable. Full workflow verification and required reviews remain pending.
