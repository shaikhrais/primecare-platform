"""Export a consistent, typed, lossless SQLite snapshot; never mutate the source."""
import argparse, hashlib, json, pathlib, sqlite3, struct

def quoted(name): return '"'+name.replace('"','""')+'"'
def cell(value):
    if value is None: return {'t':'null','v':None}
    if isinstance(value,bytes): return {'t':'blob','v':value.hex()}
    if isinstance(value,int): return {'t':'integer','v':str(value)}
    if isinstance(value,float): return {'t':'real','v':struct.pack('!d',value).hex()}
    return {'t':'text','v':value}
def export(source,target):
    target=pathlib.Path(target);target.mkdir(parents=True,exist_ok=False)
    db=sqlite3.connect(pathlib.Path(source).resolve().as_uri()+'?mode=ro',uri=True)
    try:
        db.execute('BEGIN')
        if db.execute('PRAGMA integrity_check').fetchone()!=('ok',): raise ValueError('Source integrity check failed')
        manifest={'format':'primecare-governance-snapshot-v1','tables':[], 'sqlite_objects':db.execute('SELECT type,name,tbl_name,sql FROM sqlite_master ORDER BY type,name').fetchall()}
        for index,(name,) in enumerate(db.execute("SELECT name FROM sqlite_master WHERE type='table' ORDER BY name").fetchall()):
            columns=[dict(zip(('cid','name','declared_type','notnull','default','pk'),r)) for r in db.execute('PRAGMA table_info('+quoted(name)+')')]
            if any(c['name']=='_primecare_import_row' for c in columns):raise ValueError('Reserved import column collision')
            kinds=[set() for c in columns];digest=hashlib.sha256();count=0;filename=f'{index:04d}.ndjson'
            with (target/filename).open('wb') as output:
                for row in db.execute('SELECT '+','.join(quoted(c['name']) for c in columns)+' FROM '+quoted(name)):
                    cells=[cell(v) for v in row]
                    for types,item in zip(kinds,cells):
                        if item['t']!='null':types.add(item['t'])
                    line=(json.dumps(cells,ensure_ascii=False,separators=(',',':'))+'\n').encode();output.write(line);digest.update(line);count+=1
            for column,types in zip(columns,kinds):column['storage_types']=sorted(types)
            manifest['tables'].append({'name':name,'columns':columns,'file':filename,'rows':count,'sha256':digest.hexdigest()})
        payload=json.dumps(manifest,ensure_ascii=False,sort_keys=True,indent=2)+'\n'
        (target/'manifest.json').write_text(payload)
        return {'tables':len(manifest['tables']),'rows':sum(t['rows'] for t in manifest['tables']),'manifest_sha256':hashlib.sha256(payload.encode()).hexdigest()}
    finally: db.close()
if __name__=='__main__':
    p=argparse.ArgumentParser();p.add_argument('source');p.add_argument('target');a=p.parse_args();print(json.dumps(export(a.source,a.target)))
