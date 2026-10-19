# Saved governance database checkpoint

The complete governance database, including six engineering tracking records and the current recovery snapshot, is preserved in `.agents/governance/governance-recovery-snapshot.db.gz`. Hashes and byte counts are in `database-snapshot.json`. The ordinary tracked database on the remotely published checkpoint remains the earlier baseline; the compressed file preserves the updated database exactly.

To extract a separate review copy, run:

```sh
gzip -dc .agents/governance/governance-recovery-snapshot.db.gz > /tmp/primecare-governance-recovered.db
```

The normal progress script can reproduce tracking tables from the committed seed and evidence. Existing database records should be reconciled rather than overwritten blindly. The remote checkpoint is published through the connected GitHub app because direct Git push credentials are unavailable. Full workflow verification and required reviews remain pending.


For a fresh checkout use `python3 tools/workflow-verification/restore_checkpoint.py` before reading the current inventory. It verifies both archive and expanded database hashes and integrity. Only an exact manifest-allowlisted baseline may be replaced, after a byte-exact backup; an unknown modified database is preserved and a separate verified copy is written for reconciliation.
