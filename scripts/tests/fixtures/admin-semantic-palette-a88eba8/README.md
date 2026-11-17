These are exact post-migration historic source fixtures copied from PrimeCare commit
a88eba8104c262824239169fa2a7cc8502a2404b. The three native screens were replaced
by API-backed inventory in c858e811. The Python semantic migration tests still
assert their original edit offsets, reconstruction hashes, rejection of source
drift, and idempotence. Test fixtures are Dart-shaped text only, not product code.
The unchanged screen health panel, current native compile tests, and the live
UI, styling, and API boundary checks continue to use the product tree.
