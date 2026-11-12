"""Source inventory only; remaining framework tokens are not claims of broken UI or license removal."""
import hashlib,json,re,subprocess
from pathlib import Path
root=Path(__file__).resolve().parents[1];catalog=json.loads((root/'packages/primecare_ui/assets/original/registry.json').read_text());files=subprocess.check_output(['git','ls-files','*.dart','*.ts','*.tsx'],cwd=root,text=True).splitlines();remaining=[];original=[]
web=[]
for file in files:
 p=root/file
 if not p.exists() or '/test/' in file or '/tests/' in file or file.startswith('scripts/'):continue
 text=p.read_text(errors='replace');tokens=sorted(set(re.findall(r'\b(?:Icons|LucideIcons|CupertinoIcons)\.([A-Za-z0-9_]+)',text)))
 if p.suffix in ['.ts','.tsx']:
  # Lexical evidence only: do not infer dynamic keys, wrapper calls or execution.
  calls=[]
  matches=re.findall(r'''\b(originalAssetElement|primeCareIcon|shellIcon)\s*\(\s*(['"])([a-z][a-z0-9-]{0,63})\2''',text)
  for factory,key in sorted({(factory,key) for factory,quote,key in matches}):
   canonical=key if key in catalog['assets'] else catalog['aliases'].get(key)
   calls.append({'factory':factory,'key':key,'canonical':canonical if canonical in catalog['assets'] else None})
  if calls:web.append({'path':file,'sha256':hashlib.sha256(p.read_bytes()).hexdigest(),'calls':calls})
 if tokens:remaining.append({'path':file,'tokens':tokens,'sha256':hashlib.sha256(p.read_bytes()).hexdigest()})
 keys=sorted(set(re.findall(r"PrimeOriginalAsset\('([a-z0-9-]+)'",text)))
 for expression in re.findall(r"PrimeOriginalAsset\(([^)]*)\)",text):
  keys=sorted(set(keys)|{k for k in re.findall(r"'([a-z0-9-]+)'",expression) if k in catalog['assets'] or k in catalog['aliases']})
 if keys:original.append({'path':file,'keys':keys})
for p in ['packages/flutter_core/lib/navigation/prime_workspace_navigation.dart','packages/flutter_core/lib/data_controls/prime_data_controls.dart']:
 if re.search(r'\bIcons\.',(root/p).read_text()):raise SystemExit('Unmigrated direct glyph in adopted file: '+p)
for row in original:
 if any(k not in catalog['assets'] and k not in catalog['aliases'] for k in row['keys']):raise SystemExit('Missing original key')
chunks=[]
folder=root/'docs/appearance/original-asset-usage';folder.mkdir(parents=True,exist_ok=True)
for start in range(0,len(remaining),200):
 path=folder/('part-%03d.json'%(start//200+1));path.write_text(json.dumps(remaining[start:start+200],separators=(',',':'))+'\n');chunks.append(str(path.relative_to(root)))
result={'format':1,'scope':'tracked runtime Dart/TS/TSX source inventory across apps/packages/websites; test fixtures excluded, framework controls separately classified','originalIcons':sum(v['category']=='icon' for v in catalog['assets'].values()),'otherOriginalAssets':sum(v['category']!='icon' for v in catalog['assets'].values()),'sharedShellKeysMapped':25,'aliases':catalog['aliases'],'adoptedSharedNativeSources':original,'remainingFrameworkFilesIndex':chunks,'remainingFrameworkFileCount':len(remaining),'allAppMigrationClaimed':False,'perAppCopiesAdded':False}
result['sharedWebStaticCallSources']=web
result['webInventoryMethod']='lexical direct named factory calls with literal keys only; not runtime adoption, import binding proof or complete wrapper/dynamic coverage; canonical null means unresolved'
(root/'docs/appearance/original-assets-usage-audit.json').write_text(json.dumps(result,indent=2)+'\n');print(json.dumps({k:result[k] for k in ['originalIcons','otherOriginalAssets','sharedShellKeysMapped','remainingFrameworkFileCount','allAppMigrationClaimed']}))
