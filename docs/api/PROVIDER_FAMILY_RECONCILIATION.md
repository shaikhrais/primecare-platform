# Provider family reconciliation

The read-only audit in `scripts/audit-provider-family.py` classifies 84 pending unique method/path operations: PSW 42, RN 22, staff 15, provider 3 and caregiver 2. It does not change delivery stages or claim new completed APIs.

## Why generic aliases are unsafe

25 declarations use POST while the historical generated OpenAPI type describes GET. These historical declarations are evidence of a catalog conflict, not proof of an approved runtime implementation. All 84 lack an endpoint-specific permission in `api_endpoints`; a presentation role does not grant access to patient records or authority to mutate records.

Existing provider GET handlers enforce authenticated account ownership through `provider_profiles.user_id` and tenant predicates. Those guards cannot authorize staff-wide or clinical access by implication. Existing canonical endpoints already have delivery evidence and cannot be counted again.

The Flutter offline fixtures also demonstrate contract mismatches:

| Legacy path | Existing evidence | Why an alias is insufficient |
|---|---|---|
| `/v1/psw/profile` | Offline fixture has firstName, lastName, email, phone, region and avatarUrl | `/v1/provider/profile` returns professional profile fields; it does not provide this contract |
| `/v1/psw/documents` | Offline fixture lists care policies and training material | `/v1/provider/documents` lists provider credentials; these are different resources |
| `/v1/psw/training/assigned` | Historical GET contract joins moduleTitle and moduleCategory | Canonical training assignment records expose stored assignment metadata; joined module disclosure requires a contract |
| `/v1/psw/schedule/visits` | Historical GET contract returns an array | Canonical provider visits returns `{visits,pagination}`; callers require a reviewed migration |
| `/v1/provider/metrics` | Offline fixture includes complianceRate and activeHours | Neither a metric definition nor a computation contract is established by the route name |

## Next coherent package

Review the 25 historical GET conflicts together. Resolve method and response expectations against actual callers, then migrate those callers to approved canonical reads where semantics match. Keep the other 59 declarations pending until endpoint authority, schemas and business behavior are defined. Do not turn legacy writes into reads automatically, and do not infer staff or RN access from provider ownership.

The JSON artifact contains every exact method/path, declaration IDs, governance metadata, historical method evidence and reachability probe. Regenerate it from the current checklist, audit, governance database and generated domain types:

```sh
python scripts/audit-provider-family.py --output docs/api/provider-family-reconciliation.json
```

Local verification: regeneration is deterministic and leaves governance.db unchanged. No runtime, PostgreSQL or production delivery credit is recorded by this audit.
