# API catalog identity guard

`python scripts/check-api-catalog-identity.py` checks permission-key operation identities, permission foreign keys and registry-to-endpoint mappings without mutating governance.db. Canonical endpoint permission keys and legacy registry-derived keys are checked by identity, never by coincident numeric registry IDs.

The checked-in quarantine records the exact pre-existing invalid groups. CI rejects new groups and changes to still-invalid groups, including different role membership, enabled access, target endpoint or key origin. Removing or fully repairing a violation is allowed. Partial changes to an invalid group require explicit review of the quarantine fingerprint; updating the baseline is not a permission repair.

Identity agreement is necessary but does not prove business authority, least privilege, tenant scope or runtime enforcement. Existing quarantined grants remain untrusted. The guard never enables, repairs or reassigns grants and does not award API completion credit.

Baseline recording uses `python scripts/check-api-catalog-identity.py --record-quarantine` only for reviewed legacy evidence. CI invokes the read-only check and isolated regression tests. It never refreshes the quarantine automatically.

Before declaring an unreferenced operation obsolete, inspect composed API variables, screen links, buttons, forms, archived callers and the canonical ownership/request/response contract. A literal-search miss or a routing 404 is insufficient retirement evidence. Outside the separately reviewed client read package, the audited provider dashboard, user preferences and billing summary declarations do not establish safe retirement: active composed callers or undefined business contracts remain.
