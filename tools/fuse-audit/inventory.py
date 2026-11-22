"""Compare a separately supplied Fuse archive with tracked PrimeCare bytes.
Vendor bytes stay in a private output bundle, never in the source repository.
"""
import argparse, collections, hashlib, io, json, pathlib, zipfile
p=argparse.ArgumentParser();p.add_argument('archive',type=pathlib.Path);p.add_argument('--output',required=True,type=pathlib.Path);a=p.parse_args()
root=pathlib.Path(__file__).resolve().parents[2];a.output.mkdir(parents=True,exist_ok=True)
sha=lambda b:hashlib.sha256(b).hexdigest()
local=collections.defaultdict(list)
for parent in ['packages','apps','websites']:
 for f in (root/parent).rglob('*'):
  if f.is_file() and f.suffix.lower() in {'.svg','.png','.jpg','.jpeg','.gif','.woff','.woff2','.ttf','.ico'} and not any(x in f.parts for x in ['node_modules','build','.dart_tool','dist']):local[sha(f.read_bytes())].append(str(f.relative_to(root)))
with zipfile.ZipFile(a.archive) as z:
 names=[n for n in z.namelist() if not n.endswith('/')];prefix=names[0].split('/')[0]+'/' if all('/' in n and n.split('/')[0]==names[0].split('/')[0] for n in names) else ''
 assets=[];views=[]
 with zipfile.ZipFile(a.output/'PrimeCare_Fuse_Private_Assets.zip','w',zipfile.ZIP_DEFLATED) as bundle:
  for n in sorted(names):
   rel=n.removeprefix(prefix);path=pathlib.PurePosixPath(rel)
   if path.is_absolute() or '..' in path.parts:raise ValueError('Unsafe archive entry')
   if rel.startswith('public/'):
    b=z.read(n);digest=sha(b);matches=local.get(digest,[])
    assets.append(dict(source=rel,size=len(b),sha256=digest,exactMatches=matches,verdict='exact-byte-match' if matches else 'no-exact-byte-match'))
    bundle.writestr(rel,b)
   if rel.startswith('src/') and path.suffix in {'.tsx','.jsx'} and any(t in rel.lower() for t in ['/pages/','dashboard','example','theme-layout']):views.append(rel)
  bundle.writestr('README.txt','Private reference assets extracted unchanged from the supplied licensed skeleton. Keep separate from public application code. Byte matching does not establish visual or functional parity.\n')
 report=dict(schemaVersion=1,referenceArchive=a.archive.name,referenceSha256=sha(a.archive.read_bytes()),assetCount=len(assets),assetBytes=sum(x['size'] for x in assets),exactByteMatches=sum(bool(x['exactMatches']) for x in assets),extensions=dict(collections.Counter(pathlib.Path(x['source']).suffix for x in assets)),assets=assets,referenceViewSourceCandidates=views,limitations=['No exact match does not establish absence of an original equivalent.','Source candidates are not a verified route list.','The supplied skeleton contains no dashboard application source; a dashboard template image is not a working dashboard.','No full-view visual parity or signed-in business acceptance is established by this inventory.'])
 (a.output/'Fuse_Asset_Readiness.json').write_text(json.dumps(report,indent=2)+'\n')
 print(json.dumps({k:v for k,v in report.items() if k not in ['assets','referenceViewSourceCandidates']}))

# Source presence and recorded acceptance are intentionally separate.
catalog=json.loads((root/'packages/primecare_ui/catalogs/developer-catalogue.json').read_text())
checks=[]
for feature in catalog['features']:
 sources=[]
 for entry in feature.get('sources',[]):
  path=root/entry['path'];present=path.is_file()
  sources.append(dict(path=entry['path'],presentNow=present,sameAsCatalogueHash=present and sha(path.read_bytes())==entry.get('sha256')))
 checks.append(dict(id=feature['id'],recordedDisposition=feature.get('disposition'),sources=sources,remaining=feature.get('remaining',[]),freshVisualAcceptance=False))
(a.output/'All_72_Component_Source_Checks.json').write_text(json.dumps(checks,indent=2)+'\n')
