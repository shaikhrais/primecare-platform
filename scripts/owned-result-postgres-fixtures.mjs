import assert from 'node:assert/strict';
/** Use only a disposable suite's existing synthetic owned rows. */
export async function assertOwnedPageBoundaries(call,path,collection) {
 const first=await call(path,'?limit=1');assert.equal(first.status,200,path);
 assert.equal(first.headers.get('cache-control'),'no-store');
 const page=await first.json();assert.ok(Array.isArray(page[collection]));assert.ok(page[collection].length<=1);
 assert.equal(page.pagination.limit,1);assert.equal(page.pagination.offset,0);assert.ok(Number.isSafeInteger(page.pagination.total));
 const beyond=await call(path,'?limit=1&offset=100000');assert.equal(beyond.status,200,path);
 assert.equal(beyond.headers.get('cache-control'),'no-store');
 const empty=await beyond.json();assert.deepEqual(empty[collection],[]);assert.equal(empty.pagination.total,page.pagination.total);
 assert.equal(empty.pagination.limit,1);assert.equal(empty.pagination.offset,100000);assert.equal(empty.pagination.hasMore,false);
 return 2;
}
