import {test} from 'node:test';
import assert from 'node:assert/strict';
import {readFileSync,readdirSync} from 'node:fs';
const cases=JSON.parse(readFileSync('docs/api/summary-contract-batches-901-950.json')).changes;
const documents=readdirSync('docs/api').filter(p=>p.endsWith('.openapi.json')).map(p=>JSON.parse(readFileSync('docs/api/'+p)));
for(const c of cases)test('batch '+c.batch+' '+c.service+c.path+' matches grouped read count and page bounds',()=>{
 const route='/v1/'+c.service+c.path;let matches=0;
 for(const doc of documents){
  const op=doc.paths?.[route]?.get;if(!op)continue;
  const schema=op.responses['200'].content['application/json'].schema,groups=schema.properties.groups,count=groups.items.properties.count;
  assert.equal(count.type,'integer');assert.equal(count.minimum,1);assert.equal(count.maximum,Number.MAX_SAFE_INTEGER);
  assert.equal(groups.maxItems,100);assert.ok(groups.minItems===undefined||groups.minItems===0);
  assert.equal(schema.properties.pagination.properties.total.minimum,0);matches++;
 }
 assert.ok(matches>0,'Missing summary contract '+route);
});
