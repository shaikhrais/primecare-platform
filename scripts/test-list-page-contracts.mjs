import {test} from 'node:test';
import assert from 'node:assert/strict';
import {readFileSync,readdirSync} from 'node:fs';
const cases=JSON.parse(readFileSync('docs/api/list-page-contract-batches-951-1000.json')).changes;
const documents=readdirSync('docs/api').filter(p=>p.endsWith('.openapi.json')).map(p=>({name:p,spec:JSON.parse(readFileSync('docs/api/'+p))}));
const definitions=JSON.parse(readFileSync('scripts/governed-read-alias-definitions.json'));
for(const c of cases)test('batch '+c.batch+' '+c.service+c.path+' matches bounded record list pagination',()=>{
 const root='/v1/'+c.service+c.path,aliases=definitions.filter(a=>a.canonical===root).map(a=>'/v1/premium/'+a.name),seen=new Set();
 for(const doc of documents)for(const [route,methods] of Object.entries(doc.spec.paths??{})){
  if(route!==root&&!(doc.name==='governed-read-aliases.openapi.json'&&aliases.includes(route)))continue;
  const schema=methods.get.responses['200'].content['application/json'].schema,props=schema.properties;
  const arrays=Object.entries(props).filter(([k,v])=>k!=='pagination'&&v.type==='array');assert.equal(arrays.length,1);
  assert.equal(arrays[0][1].maxItems,100);assert.ok(arrays[0][1].minItems===undefined||arrays[0][1].minItems===0);
  const paging=props.pagination.properties;
  for(const [key,min,max] of [['limit',1,100],['offset',0,100000],['total',0,Number.MAX_SAFE_INTEGER]]){
   assert.equal(paging[key].type,'integer');assert.equal(paging[key].minimum,min);assert.equal(paging[key].maximum,max);
  }
  assert.equal(paging.hasMore.type,'boolean');seen.add(route);
 }
 assert.ok(seen.has(root),'Missing canonical list');for(const alias of aliases)assert.ok(seen.has(alias),'Missing authoritative compatibility list');
});
