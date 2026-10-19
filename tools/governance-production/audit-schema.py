"""Inspect source DDL only, in an empty in-memory schema. No historical data file."""
import json,sqlite3,sys

def schema_plan(manifest):
 db=sqlite3.connect(':memory:');db.row_factory=sqlite3.Row
 for kind in ('table','index','view','trigger'):
  for typ,name,table,ddl in manifest.get('sqlite_objects',[]):
   if typ==kind and ddl and not name.startswith('sqlite_'):db.execute(ddl)
 quote=lambda s:'"'+s.replace('"','""')+'"'
 result={}
 for table in manifest['tables']:
  name=table['name'];cols=[dict(r) for r in db.execute('PRAGMA table_info('+quote(name)+')')]
  primary=[c['name'] for c in sorted(cols,key=lambda c:c['pk']) if c['pk']]
  indexes=[]
  for r in db.execute('PRAGMA index_list('+quote(name)+')'):
   if not r['unique']:continue
   parts=[dict(x) for x in db.execute('PRAGMA index_xinfo('+quote(r['name'])+')') if x['key']]
   indexes.append({'name':r['name'],'columns':[p['name'] for p in parts],'collations':[p['coll'] for p in parts],'partial':bool(r['partial']),'expression':any(p['cid']<0 for p in parts)})
  if primary and not any(i['columns']==primary for i in indexes):indexes.append({'name':'source_primary_key','columns':primary,'collations':['BINARY']*len(primary),'partial':False,'expression':False})
  fks={}
  for r in db.execute('PRAGMA foreign_key_list('+quote(name)+')'):
   fks.setdefault(r['id'],{'id':r['id'],'target':r['table'],'parts':[]})['parts'].append({'seq':r['seq'],'from':r['from'],'to':r['to']})
  result[name]={'columns':cols,'primaryKey':primary,'uniqueKeys':indexes,'foreignKeys':list(fks.values())}
 db.close();return result
if __name__=='__main__':print(json.dumps(schema_plan(json.load(sys.stdin))))
