# Native task adapter map type repair

Batch summary: specify the existing dynamic map type arguments at all 16 analyzer-reported list casts in the native tenant task adapter and its existing tests. No policy, transport, payload, projection or assertion changes.

Exact 2f1631b9 shared-work-modules CI failed on Linux, Windows and macOS. Linux job 130843326704 reported 16 strict_raw_type warnings and exited 1 before native tests. Seven sites are in the adapter and nine in its tests. Each `.cast<Map>()` becomes `.cast<Map<dynamic,dynamic>>()`, making the previous implicit type explicit. The analyzer remains fatal for warnings. No suppressions or workflow changes are added.

The source edit is reversible byte-for-byte. Original/updated SHA256 receipts:

| File | Calls | Original SHA256 | Updated SHA256 |
| --- | ---: | --- | --- |
| packages/flutter_core/lib/work_modules/tenant_task_module_port.dart | 7 | bb8e63fbbea446e7f464384d94279112ef4e08ead215d7b5165a1743a2220700 | 9c4226485c685e10c5fccdbebf587dffdca06a76b8ac7d44a700851efec1d876 |
| packages/flutter_core/test/work_modules/tenant_task_module_port_test.dart | 9 | c92f6daf20ffe23bf3ba73e2894989694741662e96eefd149ba4931e1fff2fb6 | 666831a3027b8d9b42e55499ae2b0779c3387abef7b6eb17d141210d6c49c458 |

Existing native tests retain 60 projection and 52 mutation oracle cases, independent readback, lost acknowledgements, disposal and scope/permission failures. GitHub Actions must execute the analyzer and those tests on the new head before native acceptance is claimed. No capability or production-readiness credit is created. Strict source findings remain 0; feature acceptance remains 0/72 complete and 72 pending.
