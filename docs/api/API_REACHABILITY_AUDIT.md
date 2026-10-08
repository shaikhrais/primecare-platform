# Remaining API route triage

**1049/1049 unique pending declarations probed locally.**

These probes use the declared method without credentials. They classify routing behavior, not business completion. Database connections are stopped before SQL, no email is sent, and production is not contacted. A 404 is specific to this probe; a 401/403 requires authenticated verification. A 405 identifies a method mismatch, not a completed write. Dynamic ID handlers can capture workflow-like names: a protected or method-rejected response does not prove that the advertised workflow exists. Do not switch callers to GET blindly. Service status is not an auth workflow.

| Probe classification | Operations |
| --- | ---: |
| credential_or_authority_required | 1 |
| gateway_route_not_found | 1013 |
| worker_route_not_found | 35 |

The JSON contains every exact method/path, HTTP status, allowed method, forwarding destination and source hashes. Retire or replace stale declarations only after checking callers and intended workflows. Register business authority and contracts before implementing missing actions. Existing unit-evidence operations are excluded. The four specifically reviewed method/workflow blockers are probed in a separate reviewedBlockedOperations array and never enter the pending denominator.

Separately reviewed blockers: 4/4. These remain blocked and do not add pending operations or implemented API credit.
