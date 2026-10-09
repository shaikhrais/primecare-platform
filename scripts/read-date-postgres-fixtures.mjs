import assert from 'node:assert/strict';
/** Disposable-fixture rows only. Each rejected read must leave the intentionally
 * corrupt row unchanged; every injected value is restored before returning.
 */
export async function assertReadDateRejections(db,call,{table,field,id}) {
 assert.match(table,/^[A-Za-z][A-Za-z0-9_]*$/);assert.match(field,/^[A-Za-z][A-Za-z0-9_]*$/);
 const select=`SELECT * FROM "${table}" WHERE id::text=$1`;
 const saved=(await db.query(select,[String(id)])).rows;
 assert.equal(saved.length,1);let checks=0;
 try {
  for(const value of ['infinity','10000-01-01 00:00:00']) {
   await db.query(`UPDATE "${table}" SET "${field}"=$2 WHERE id::text=$1`,[String(id),value]);
   const before=(await db.query(select,[String(id)])).rows;
   const response=await call();assert.equal(response.status,503,table+'.'+field);
   assert.equal(response.headers.get('cache-control'),'no-store');assert.equal(response.headers.get('set-cookie'),null);
   assert.deepEqual((await db.query(select,[String(id)])).rows,before);checks++;
   await db.query(`UPDATE "${table}" SET "${field}"=$2 WHERE id::text=$1`,[String(id),saved[0][field]]);
  }
 }finally {await db.query(`UPDATE "${table}" SET "${field}"=$2 WHERE id::text=$1`,[String(id),saved[0][field]]);}
 return checks;
}
