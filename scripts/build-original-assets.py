"""Original geometry and strict build-time SVG compiler; no vendor paths or runtime SVG parser."""
import hashlib,json,math,re,sys,xml.etree.ElementTree as ET
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1];BASE=ROOT/'packages/primecare_ui/assets/original';CHECK='--check' in sys.argv
# Task-authored basic geometry for actual B04–B11 shell/component semantics.
NEW={
'arrow-left':'M21 12H3m7-7-7 7 7 7','arrow-up':'M12 21V3m-7 7 7-7 7 7','arrow-down':'M12 3v18m-7-7 7 7 7-7','chevron-left':'m15 5-7 7 7 7','chevron-right':'m9 5 7 7-7 7','chevron-up':'m5 15 7-7 7 7',
'copy':'M8 8h13v13H8Z M3 16V3h13','code':'m8 5-6 7 6 7m8-14 6 7-6 7m-3-16-2 18','bold':'M6 3h7a4.5 4.5 0 0 1 0 9H6Zm0 9h8a4.5 4.5 0 0 1 0 9H6Z','italic':'M10 3h9M5 21h9M15 3 9 21','list':'M3 5h1m4 0h13M3 12h1m4 0h13M3 19h1m4 0h13',
'columns':'M3 3h18v18H3Zm6 0v18m6-18v18','table':'M3 3h18v18H3Zm0 6h18M3 15h18M9 3v18','sort-ascending':'M7 21V3m-4 4 4-4 4 4m3 1h7m-7 5h5m-5 5h3','sort-descending':'M7 3v18m-4-4 4 4 4-4m3-9h3m-3 5h5m-5 5h7','resize':'M3 9V3h6m6 0h6v6m0 6v6h-6M9 21H3v-6m0-12 6 6m12 12-6-6','attachment':'m8 14 7-7a3 3 0 0 1 4 4L9 21a5 5 0 0 1-7-7L13 3a4 4 0 0 1 6 6L9 19',
'chart-line':'M3 3v18h18M5 16l5-7 4 4 7-9','chart-area':'M3 3v18h18M5 19v-4l5-8 5 6 6-8v14Z','chart-bar':'M3 21h18M5 17V9h3v8Zm6 0V3h3v14Zm6 0v-5h3v5Z','chart-donut':'M12 3a9 9 0 1 0 9 9h-5a4 4 0 1 1-4-4Zm3 0v6h6a9 9 0 0 0-6-6Z','metric':'M3 4h18v16H3ZM7 10l2-2v8m4-8h4l-4 8h4',
'fullscreen':'M3 9V3h6m6 0h6v6m0 6v6h-6M9 21H3v-6','fullscreen-exit':'M9 3v6H3m12-6v6h6m0 6h-6v6m-6 0v-6H3','bookmark':'M6 3h12v19l-6-5-6 5Z','notes':'M4 3h16v14l-5 4H4Zm4 5h8m-8 4h6m1 9v-5h5','desktop':'M3 3h18v13H3Zm9 13v5m-5 0h10','mobile':'M7 2h10v20H7Zm3 3h4m-3 14h2','tablet':'M4 2h16v20H4Zm7 17h2','dots-vertical':'M12 4h.01M12 12h.01M12 20h.01',
'database':'M3 6c0-5 18-5 18 0s-18 5-18 0Zm0 0v12c0 5 18 5 18 0V6M3 12c0 5 18 5 18 0','launch':'M7 14C9 6 15 2 21 3c1 6-3 12-11 14Zm0 0-4-1 5-5m2 9 1 4 5-5M5 17l-2 4 4-2m8-11h.01','training':'m2 9 10-6 10 6-10 6Zm4 3v6l6 3 6-3v-6m4-3v10','robot':'M5 6h14v12H5Zm7-4v4m-4 5h1m6 0h1m-8 4h8M2 9v6m20-6v6M8 18v4m8-4v4','tenant-add':'M3 21V3h13v10M7 7h2m2 0h2m-6 4h2m-2 4h2m6 2h7m-3.5-3.5v7','document':'M5 2h9l5 5v15H5Zm9 0v6h5M8 12h8m-8 4h8m-8 3h5','user-circle':'M12 2a10 10 0 1 0 0 20 10 10 0 0 0 0-20Zm0 4a3 3 0 1 0 0 6 3 3 0 0 0 0-6ZM5 19c1-7 13-7 14 0',
'pin-panel':'M8 2h8l-1 7 4 4v2H5v-2l4-4Zm4 13v7','expand':'M3 8V3h5m8 0h5v5m0 8v5h-5M8 21H3v-5m5-8 8 8m-8 0 8-8','collapse':'M3 9h6V3m6 0v6h6M3 15h6v6m6 0v-6h6','eye':'M2 12c5-12 15-12 20 0-5 12-15 12-20 0Zm10-4a4 4 0 1 0 0 8 4 4 0 0 0 0-8Z','eye-off':'M3 3l18 18M4 8l-2 4c4 8 10 10 17 4M8 5c5-2 10 0 14 7l-2 3','offline':'M2 7c6-5 14-5 20 0M5 11c4-3 10-3 14 0m-6 5-1 2m-9-15 18 18','error':'M12 2a10 10 0 1 0 0 20 10 10 0 0 0 0-20ZM8 8l8 8m-8 0 8-8','external-link':'M14 3h7v7m0-7-11 11M10 4H3v17h17v-7','checkbox':'M3 3h18v18H3Zm4 9 4 4 7-8','radio':'M12 2a10 10 0 1 0 0 20 10 10 0 0 0 0-20Zm0 6a4 4 0 1 0 0 8 4 4 0 0 0 0-8Z','toggle':'M7 5h10a7 7 0 0 1 0 14H7A7 7 0 0 1 7 5Zm0 3a4 4 0 1 0 0 8 4 4 0 0 0 0-8Z','placeholder-circle':'M12 3a9 9 0 1 0 0 18 9 9 0 0 0 0-18Z'}
ALIASES={'building':'tenant','building-plus':'tenant-add','layout-dashboard':'dashboard','users':'team','clipboard-check':'care-plan','shield-check':'shield','map-2':'territory','rocket':'launch','school':'training','menu-2':'menu','x':'close','file-text':'document','adjustments-horizontal':'settings','palette':'theme','success':'check','push-pin':'pin-panel','expand-more':'chevron-down','expand-less':'chevron-up','calendar-today':'calendar','access-time':'clock'}
DIRECTIONAL={'arrow-right','arrow-left','chevron-left','chevron-right','logout','external-link'}
def emit(path,text):
 path=ROOT/path
 if CHECK:
  if not path.exists() or path.read_text()!=text:raise ValueError('Generated asset drift: '+str(path.relative_to(ROOT)))
 else:path.parent.mkdir(parents=True,exist_ok=True);path.write_text(text)

# Original semantic scenes, built from simple shapes. No people/photos/third-party artwork.
SCENES={
'onboarding-welcome':'<rect x="28" y="20" width="184" height="120" rx="18"/><path d="M52 52h52m-52 20h76m-76 20h40m46 0 16 16 32-40"/>',
'onboarding-layout':'<rect x="24" y="18" width="192" height="124" rx="12"/><path d="M24 46h192M72 46v96"/><rect x="88" y="62" width="48" height="30" rx="4"/><rect x="148" y="62" width="48" height="60" rx="4"/><path d="M88 110h48"/>',
'onboarding-theme':'<rect x="28" y="20" width="184" height="120" rx="18"/><circle cx="78" cy="64" r="18"/><circle cx="120" cy="92" r="18"/><circle cx="162" cy="64" r="18"/><path d="M60 118h36m48 0h36"/>',
'placeholder-avatar':'<circle cx="120" cy="80" r="62"/><circle cx="120" cy="58" r="22"/><path d="M72 126c2-50 94-50 96 0"/>',
'placeholder-image':'<rect x="24" y="20" width="192" height="120" rx="16"/><circle cx="72" cy="58" r="14"/><path d="m26 122 58-46 36 36 32-24 62 40"/>',
'empty-dashboard':'<rect x="28" y="20" width="184" height="120" rx="16"/><path d="M28 48h184M74 48v92"/><rect x="92" y="66" width="40" height="28" rx="5"/><rect x="148" y="66" width="44" height="52" rx="5"/><path d="M92 116h40"/>',
'empty-upload':'<path d="M44 104v32h152v-32M120 112V28m-30 30 30-30 30 30"/><path d="M66 104H44m152 0h-22"/>',
'empty-error':'<circle cx="120" cy="80" r="56"/><path d="m96 56 48 48m-48 0 48-48"/>',
'empty-offline':'<path d="M42 54c40-36 116-36 156 0M64 80c28-24 84-24 112 0M92 106c16-12 40-12 56 0M120 128h.01M44 20l152 120"/>'}
def seed_missing_originals():
 # One-time scaffolding only. Existing canonical SVG edits always win.
 for key,path in NEW.items():
  p=Path('packages/primecare_ui/assets/original/icons')/(key+'.svg')
  if not (ROOT/p).exists():emit(p,f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.7" stroke-linecap="round" stroke-linejoin="round"><path d="{path}"/></svg>\n')
 for key,body in SCENES.items():
  p=Path('packages/primecare_ui/assets/original/assets')/(key+'.svg')
  if not (ROOT/p).exists():emit(p,f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 240 160" fill="none" stroke="currentColor" stroke-width="4" stroke-linecap="round" stroke-linejoin="round">{body}</svg>\n')

NUM=r'[-+]?(?:\d*\.\d+|\d+\.?\d*)(?:[eE][-+]?\d+)?';TOK=re.compile('[A-Za-z]|'+NUM)
def nums(s):
 rest=re.sub(NUM,'',s)
 if re.sub(r'[\s,]','',rest):raise ValueError('Invalid numeric list')
 return [float(x) for x in re.findall(NUM,s)]
def path_commands(d):
 if len(d)>20000 or re.sub(r'[\s,]','',TOK.sub('',d)):raise ValueError('Invalid path syntax')
 tokens=TOK.findall(d);out=[];i=0;cmd=None;x=y=sx=sy=0.;prev='';c2=None;q=None
 sizes={'M':2,'L':2,'H':1,'V':1,'C':6,'S':4,'Q':4,'T':2,'A':7}
 while i<len(tokens):
  if tokens[i].isalpha():cmd=tokens[i];i+=1
  if cmd is None:raise ValueError('Missing path command')
  c=cmd.upper();relative=cmd.islower()
  if c=='Z':out.append(['Z']);x,y=sx,sy;prev='Z';c2=q=None;cmd=None;continue
  if c not in sizes:raise ValueError('Unsupported path command')
  n=sizes[c]
  if i+n>len(tokens) or any(t.isalpha() for t in tokens[i:i+n]):raise ValueError('Short path command')
  a=[float(t) for t in tokens[i:i+n]];i+=n
  def point(px,py):return [px+x if relative else px,py+y if relative else py]
  if c in ['M','L','T']:
   p=point(*a)
   if c=='T':control=[2*x-q[0],2*y-q[1]] if prev in ['Q','T'] and q else [x,y];out.append(['Q',*control,*p]);q=control
   else:out.append([c,*p]);q=None
   x,y=p
   if c=='M':sx,sy=x,y;cmd='l' if relative else 'L'
   c2=None
  elif c=='H':x=a[0]+x if relative else a[0];out.append(['L',x,y]);c2=q=None
  elif c=='V':y=a[0]+y if relative else a[0];out.append(['L',x,y]);c2=q=None
  elif c in ['C','S']:
   if c=='C':p1,p2,p=point(*a[:2]),point(*a[2:4]),point(*a[4:])
   else:p1=[2*x-c2[0],2*y-c2[1]] if prev in ['C','S'] and c2 else [x,y];p2,p=point(*a[:2]),point(*a[2:])
   out.append(['C',*p1,*p2,*p]);x,y=p;c2=p2;q=None
  elif c=='Q':control,p=point(*a[:2]),point(*a[2:]);out.append(['Q',*control,*p]);x,y=p;q=control;c2=None
  else:
   if a[0]<0 or a[1]<0 or a[3] not in [0,1] or a[4] not in [0,1]:raise ValueError('Invalid arc')
   p=point(*a[5:]);out.append(['A',*a[:5],*p]);x,y=p;c2=q=None
  prev=c
 if len(out)>2000 or any(not math.isfinite(v) or abs(v)>1e6 for row in out for v in row[1:]):raise ValueError('Unbounded path')
 return out
COLOURS={'none':'none','currentColor':'foreground','#087F8C':'primary','#E9F4F5':'surface','#F4AE53':'accent','#DCE6EF':'border','#F5F8FB':'background','white':'onPrimary'}
def number(v,default=0):
 n=float(default if v is None else v)
 if not math.isfinite(n) or abs(n)>1e6:raise ValueError('Unbounded geometry')
 return n
def compile_svg(text):
 if len(text)>100000 or '<!' in text or '<?' in text:raise ValueError('Unsafe SVG header')
 root=ET.fromstring(text);box=nums(root.attrib.get('viewBox',''))
 if len(box)!=4 or any(not math.isfinite(x) or abs(x)>1e6 for x in box) or min(box[2:])<=0 or box[:2]!=[0,0]:raise ValueError('Invalid viewbox')
 nodes=[]
 def visit(e,style,transforms,opacity):
  tag=e.tag.split('}')[-1];a=e.attrib
  allowed={'svg':{'viewBox','width','height'},'g':set(),'path':{'d'},'rect':{'x','y','width','height','rx','ry'},'circle':{'cx','cy','r'},'ellipse':{'cx','cy','rx','ry'},'line':{'x1','y1','x2','y2'},'polyline':{'points'},'polygon':{'points'}}
  paint={'fill','stroke','stroke-width','stroke-linecap','stroke-linejoin','opacity','transform'}
  if tag not in allowed or set(a)-allowed[tag]-paint or e.text and e.text.strip() or e.tail and e.tail.strip() or e.tag.startswith('{') and not e.tag.startswith('{http://www.w3.org/2000/svg}') or tag=='svg' and e is not root:raise ValueError('Unsafe SVG node/attribute')
  st=dict(style)
  for key in ['fill','stroke','stroke-width','stroke-linecap','stroke-linejoin']:
   if key in a:st[key]=a[key]
  for key in ['fill','stroke']:
   if st[key] not in COLOURS:raise ValueError('Unmapped SVG colour: '+st[key])
  if st['stroke-linecap'] not in ['round','butt','square'] or st['stroke-linejoin'] not in ['round','miter','bevel']:raise ValueError('Unsupported stroke')
  op=opacity*number(a.get('opacity'),1)
  if not 0<=op<=1:raise ValueError('Invalid opacity')
  tr=list(transforms);t=a.get('transform','')
  for match in re.finditer(r'(translate|scale|rotate)\(([^)]*)\)',t):
   args=nums(match[2]);kind=match[1]
   if any(not math.isfinite(v) or abs(v)>1e6 for v in args):raise ValueError('Unbounded transform')
   if len(args) not in ({'translate':[1,2],'scale':[1,2],'rotate':[1,3]}[kind]):raise ValueError('Invalid transform')
   tr.append([kind,*args])
  if re.sub(r'\s','',re.sub(r'(translate|scale|rotate)\([^)]*\)','',t)):raise ValueError('Unsupported transform')
  if tag not in ['svg','g']:
   node={'type':tag,'fill':COLOURS[st['fill']],'stroke':COLOURS[st['stroke']],'strokeWidth':number(st['stroke-width']),'cap':st['stroke-linecap'],'join':st['stroke-linejoin'],'opacity':op,'transforms':tr}
   if tag=='path':node['commands']=path_commands(a['d'])
   elif tag in ['polyline','polygon']:
    pts=nums(a['points'])
    if len(pts)<4 or len(pts)%2:raise ValueError('Invalid polygon')
    node['type']='path';node['commands']=[['M' if i==0 else 'L',*pts[i:i+2]] for i in range(0,len(pts),2)]+([['Z']] if tag=='polygon' else [])
   else:node['geometry']={k:number(a.get(k)) for k in sorted(allowed[tag])};node['geometry']['rx']=number(a.get('rx'));node['geometry']['ry']=number(a.get('ry'),a.get('rx',0))
   if node['strokeWidth']<0 or any(v<0 for k,v in node.get('geometry',{}).items() if k in ['r','rx','ry','width','height']):raise ValueError('Negative shape dimension')
   nodes.append(node)
  for child in e:visit(child,st,tr,op)
 visit(root,{'fill':'currentColor','stroke':'none','stroke-width':'1','stroke-linecap':'butt','stroke-linejoin':'miter'},[],1)
 if not nodes or len(nodes)>200:raise ValueError('Invalid node count')
 return box,nodes

def build():
 assets={};paths={};sprite=[]
 for folder in ['icons','assets']:
  for p in sorted((BASE/folder).glob('*.svg')):
   text=p.read_text();box,nodes=compile_svg(text);key=p.stem
   if key in assets:raise ValueError('Duplicate asset key')
   category='icon' if folder=='icons' else 'brand' if key=='brand-mark-concept' else 'placeholder' if key.startswith('placeholder-') else 'illustration'
   assets[key]={'key':key,'category':category,'path':str(p.relative_to(ROOT)),'bundleKey':'packages/primecare_ui/assets/original/'+folder+'/'+p.name,'viewBox':box,'rtlMirror':key in DIRECTIONAL,'sha256':hashlib.sha256(p.read_bytes()).hexdigest(),'nodes':nodes}
   if folder=='icons':
    body=text[text.index('>')+1:text.rindex('</svg>')];paths[key]=body;sprite.append(f'<symbol id="pc-{key}" viewBox="0 0 24 24">{body}</symbol>')
 if any(v not in assets for v in ALIASES.values()):raise ValueError('Broken alias')
 metadata=json.loads((ROOT/'packages/primecare_ui/catalogs/original-assets.registration.json').read_text())
 if metadata['kind']!='verified_metadata_export' or any(not isinstance(c['controlId'],int) or c['controlId']<=0 for c in metadata['controls']):raise ValueError('Verified asset registration required')
 bindings={c['key']:{'testId':c['testId'],'controlId':c['controlId']} for c in metadata['controls'] if c['componentCode']=='prime_asset'}
 if set(bindings)!={'icon','illustration','brand','placeholder'}:raise ValueError('Missing asset bindings')
 data={'version':2,'bindings':bindings,'provenance':'original-task-authored-geometry','aliases':ALIASES,'assets':assets}
 encoded=json.dumps(data,separators=(',',':'),ensure_ascii=False)

 preview='<!doctype html><html lang="en"><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1"><title>PrimeCare original vectors v2</title><style>body{font:16px system-ui;background:Canvas;color:CanvasText;margin:24px}section{display:grid;grid-template-columns:repeat(auto-fill,minmax(160px,1fr));gap:16px}figure{margin:0;border:1px solid;padding:16px;overflow:hidden}svg{width:100%;height:90px;color:LinkText}figcaption{font-size:13px;overflow-wrap:anywhere}</style><h1>PrimeCare original vectors</h1><p>Documentation preview: '+str(len(paths))+' icons and '+str(len(assets)-len(paths))+' scenes. Meaningful production labels come from each host’s registered resources.</p><section>'
 for key,a in assets.items():preview+='<figure>'+Path(ROOT/a['path']).read_text()+'<figcaption>'+key+'</figcaption></figure>'
 preview+='</section><p>Original basic geometry; brand mark is a concept. See docs/appearance/original-assets-provenance.json for retained dependency notices and limits.</p></html>\n'
 emit(Path('packages/primecare_ui/assets/original/preview.html'),preview)
 emit(Path('packages/primecare_ui/assets/original/registry.json'),encoded+'\n')
 emit(Path('packages/primecare_ui/assets/original/icons.json'),json.dumps(paths,indent=2)+'\n')
 emit(Path('packages/primecare_ui/assets/original/primecare-sprite.svg'),'<svg xmlns="http://www.w3.org/2000/svg" style="display:none">'+''.join(sprite)+'</svg>\n')
 emit(Path('packages/flutter_core/lib/original_assets/asset_data.dart'),"// GENERATED by scripts/build-original-assets.py; canonical SVGs are the authoring source.\nconst originalAssetDataJson = r'''"+encoded+"''';\n")
 ts='/** GENERATED from canonical SVGs by scripts/build-original-assets.py. */\nexport const primeCareIconPaths = '+json.dumps(paths,indent=2)+' as const;\nexport type PrimeCareIconName = keyof typeof primeCareIconPaths;\nexport const primeCareAssetAliases = '+json.dumps(ALIASES)+' as const;\n/** Decorative compatibility renderer. Name the enclosing control. */\nexport function primeCareIcon(name:PrimeCareIconName):string {if(!Object.hasOwn(primeCareIconPaths,name))throw Error("Unknown PrimeCare icon");return `<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.7" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true" focusable="false">${primeCareIconPaths[name]}</svg>`;}\n'
 emit(Path('packages/primecare_ui/web/original-assets.ts'),ts)
 dart="/// GENERATED canonical package keys; native vector rendering is in flutter_core/original_assets.dart.\nabstract final class PrimeCareAssets {\n static const packageName='primecare_ui';\n static const root='packages/primecare_ui/assets/original';\n static const iconNames=<String>"+json.dumps(list(paths))+";\n static String icon(String name){if(!iconNames.contains(name))throw ArgumentError('Unknown PrimeCare icon');return '$root/icons/$name.svg';}\n"
 for name,key in [('brandMark','brand-mark-concept'),('backgroundGrid','background-grid'),('backgroundOrbit','background-orbit'),('emptyAppointments','empty-appointments'),('emptyMessages','empty-messages'),('emptySearch','empty-search'),('emptyRecords','empty-records')]:dart+=f" static const {name}='$root/assets/{key}.svg';\n"
 dart+=" static const themeTokens='$root/theme-tokens.json';\n}\n";emit(Path('packages/primecare_ui/lib/src/theme/primecare_assets.dart'),dart)
 print(json.dumps({'icons':len(paths),'illustrationsAndAssets':len(assets)-len(paths),'aliases':len(ALIASES),'check':CHECK}))
 return data
if __name__=='__main__':
 if '--seed-missing' in sys.argv:
  if CHECK:raise SystemExit('Seed and check cannot be combined')
  seed_missing_originals()
 build()
