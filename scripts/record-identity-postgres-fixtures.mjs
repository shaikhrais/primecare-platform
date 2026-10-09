import assert from 'node:assert/strict';
/** Only disposable synthetic text-ID tables supplied by the invoking suite. */
export async function assertReadIdentityRejections(db,call,{table,id,duplicate=true}) {
 assert.match(table,/^[A-Za-z][A-Za-z0-9_]*$/);const name='"'+table+'"';
 const select='SELECT * FROM '+name+' WHERE id::text=$1';
 const saved=(await db.query(select,[id])).rows;assert.equal(saved.length,1);let checks=0;
 for(const bad of ['', ' bad']) {
  await db.query('UPDATE '+name+' SET id=$2 WHERE id::text=$1',[id,bad]);
  try{const before=(await db.query(select,[bad])).rows;const r=await call();assert.equal(r.status,503,table);assert.equal(r.headers.get('cache-control'),'no-store');assert.deepEqual((await db.query(select,[bad])).rows,before);checks++;}
  finally{await db.query('UPDATE '+name+' SET id=$2 WHERE id::text=$1',[bad,id]);}
 }
 if(duplicate) {
  const inserted=(await db.query('INSERT INTO '+name+' SELECT * FROM '+name+' WHERE id::text=$1 RETURNING ctid::text AS tid',[id])).rows;
  assert.equal(inserted.length,1);
  try{const before=(await db.query(select,[id])).rows;assert.equal(before.length,2);const r=await call();assert.equal(r.status,503,table);assert.equal(r.headers.get('cache-control'),'no-store');assert.deepEqual((await db.query(select,[id])).rows,before);checks++;}
  finally{await db.query('DELETE FROM '+name+' WHERE ctid=$1::tid',[inserted[0].tid]);}
 }
 assert.deepEqual((await db.query(select,[id])).rows,saved);return checks;
}
