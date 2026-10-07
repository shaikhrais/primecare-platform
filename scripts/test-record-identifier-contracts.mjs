import {test} from 'node:test';
import assert from 'node:assert/strict';
import {readFileSync,readdirSync} from 'node:fs';
const cases=JSON.parse(readFileSync('docs/api/identifier-contract-batches-851-900.json')).changes;
const documents=readdirSync('docs/api').filter(p=>p.endsWith('.openapi.json')).map(p=>({name:p,spec:JSON.parse(readFileSync('docs/api/'+p))}));
function fields(schema,name,result=[]) {
 if(!schema||typeof schema!=='object')return result;
 if(schema.properties?.[name])result.push(schema.properties[name]);
 for(const value of Object.values(schema))if(value&&typeof value==='object')fields(value,name,result);
 return result;
}
for(const c of cases)test('batch '+c.batch+' '+c.service+c.path+' '+c.field+' matches runtime record identifier grammar',()=>{
 const root='/v1/'+c.service+c.path;
 let matches=0;const seen=new Set();const aliases=JSON.parse(readFileSync('scripts/governed-read-alias-definitions.json')).filter(a=>a.canonical===root).map(a=>'/v1/premium/'+a.name);
 for(const doc of documents)for(const [route,methods] of Object.entries(doc.spec.paths??{})) {
  if(route!==root&&route!==root+'/{recordId}'&&!(doc.name==='governed-read-aliases.openapi.json'&&aliases.includes(route)))continue;
  const schema=methods.get?.responses?.['200']?.content?.['application/json']?.schema;
  for(const field of fields(schema,c.field)) {
   assert.equal(field.type,'string');
   assert.equal(field.minLength,1,route);
   assert.equal(field.maxLength,200,route);assert.equal(field.pattern,'^[A-Za-z0-9][A-Za-z0-9_-]{0,199}$',route);matches++;seen.add(route);
  }
 }
 assert.ok(matches>0,'Missing exact response schema for '+root);
 assert.ok(seen.has(root)&&seen.has(root+'/{recordId}'),'Missing list/detail contract');
 for(const alias of aliases)assert.ok(seen.has(alias),'Missing compatibility contract '+alias);
});
