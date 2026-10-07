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
 if(collection!=='groups') {
  const response=await call(path,'?limit=100');assert.equal(response.status,200,path);const all=await response.json();const seen=new Set();
  for(const row of all[collection]){assert.equal(typeof row.id,'string',path);assert.match(row.id,/^[A-Za-z0-9][A-Za-z0-9_-]{0,199}$/);assert.ok(!seen.has(row.id),path);seen.add(row.id);}
  return 3;
 }
 if(collection==='groups') {
  const response=await call(path,'?limit=100');assert.equal(response.status,200,path);const all=await response.json();
  assert.equal(all.pagination.total,page.pagination.total);const seen=new Set();
  for(const group of all.groups) {
   const count=group.invoiceCount??group.count;assert.ok(Number.isSafeInteger(count)&&count>0,path);
   const fields=Object.keys(group).filter(f=>!['count','invoiceCount','durationMinutes','totalMinutes','subtotal','tax','total'].includes(f)).sort();
   assert.ok(fields.length>0,path);const key=JSON.stringify(fields.map(f=>[f,group[f]]));assert.ok(!seen.has(key),path);seen.add(key);
  }
  return 3;
 }
 return 2;
}
