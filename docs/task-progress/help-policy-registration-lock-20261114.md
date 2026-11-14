# Help policy registration lock repair

Initial sourcee03e2de5d2330cda5da55a92ef4e8c4ea82c73ee; run43652626389: isolated proof132624223384SUCCESS,17/17onPGlite andPostgreSQL16. Production132624474902 failed safely with55P03lock_timeout after read-only plan returnedapplied:false; its transaction rolled back. No registration success or changed production grants/operational rows is claimed.

The writer unnecessarily requested SHARE on the entire API endpoint table, blocking unrelated definition writers. It now takes FOR SHARE only on accepted API794 after checking its exact route/service/key, while policy ID allocation remains under its original metadata-table locks. Operational tables use ACCESS SHARE to protect relation existence without blocking counters/audits. The5s lock timeout, serializable transaction, schema/authority/hash/source guards and independent readback remain unchanged.

Added actual PostgreSQL two-connection regression: hold an unrelated API795 writer transaction while Help registration succeeds and independently verifies. Local17/17policy casesPASS; this native-only case isSKIPPED locally and requires CI. Production registration remains pending until fresh native proof+apply succeeds. No blind rerun, timeout increase or guard bypass.
