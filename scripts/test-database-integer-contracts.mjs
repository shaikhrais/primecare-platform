import {test} from 'node:test';
import assert from 'node:assert/strict';
import {readFileSync,readdirSync} from 'node:fs';
const cases=JSON.parse(readFileSync('docs/api/integer-contract-batches-839-850.json')).changes;
const documents=readdirSync('docs/api').filter(p=>p.endsWith('.openapi.json')).map(p=>JSON.parse(readFileSync('docs/api/'+p)));
function fields(schema,name,result=[]) {
 if(!schema||typeof schema!=='object')return result;
 if(schema.properties?.[name])result.push(schema.properties[name]);
 for(const value of Object.values(schema))if(value&&typeof value==='object')fields(value,name,result);
 return result;
}
for(const c of cases)test('batch '+c.batch+' '+c.service+c.path+' '+c.field+' matches signed int4 runtime bounds',()=>{
 const root='/v1/'+c.service+c.path;
 let matches=0;
 for(const doc of documents)for(const [route,methods] of Object.entries(doc.paths??{})) {
  if(route!==root&&route!==root+'/{recordId}')continue;
  const schema=methods.get?.responses?.['200']?.content?.['application/json']?.schema;
  for(const field of fields(schema,c.field)) {
   assert.ok((Array.isArray(field.type)?field.type:[field.type]).includes('integer'));
   assert.equal(field.minimum,-2147483648,route);
   assert.equal(field.maximum,2147483647,route);matches++;
  }
 }
 assert.ok(matches>0,'Missing exact response schema for '+root);
});
