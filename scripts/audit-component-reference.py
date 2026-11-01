"""Refresh/check metadata hashes against a user-supplied licensed archive; never copy source code."""
import argparse,hashlib,io,json,zipfile
from pathlib import Path
p=argparse.ArgumentParser(description=__doc__);p.add_argument('archive',type=Path);p.add_argument('--check',action='store_true');args=p.parse_args()
report=Path('docs/appearance/component-catalogue-reference-audit.json');doc=json.loads(report.read_text());records=[]
with zipfile.ZipFile(args.archive) as outer:
 for bundle in ['Fuse-React-v17.0.0-vitejs-demo.zip','Fuse-React-v17.0.0-nextjs-demo.zip']:
  with zipfile.ZipFile(io.BytesIO(outer.read(bundle))) as z:
   for path in z.namelist():
    if '/material-ui-components/' in path and path.endswith(('.tsx','.ts')):
     records.append({'bundle':bundle,'path':path,'sha256':hashlib.sha256(z.read(path)).hexdigest()})
records.sort(key=lambda r:(r['bundle'],r['path']))
def digest(rows):return hashlib.sha256(json.dumps(rows,sort_keys=True,separators=(',',':')).encode()).hexdigest()
root=digest(records)
for family in doc['families']:
 rows=[r for r in records if r['path'].split('/material-ui-components/',1)[1].split('/')[0]==family['family']]
 assert len(rows)==family['physicalExamples']
 assert sorted(set(r['path'].split('/material-ui-components/',1)[1] for r in rows))==family['files']
 if args.check:assert digest(rows)==family['sourceMetadataSha256']
 else:family['sourceMetadataSha256']=digest(rows)
if args.check:assert root==doc['sourceInventorySha256']
else:
 doc['sourceInventorySha256']=root;doc['sourceArchiveSha256']=hashlib.sha256(args.archive.read_bytes()).hexdigest();doc['hashScope']='Sorted bundle/path/content-digest metadata only; classification does not affect source hashes';report.write_text(json.dumps(doc,indent=2)+'\n')
print(json.dumps({'examples':len(records),'families':len(doc['families']),'metadataSha256':root,'sourceCopied':False,'check':args.check}))
