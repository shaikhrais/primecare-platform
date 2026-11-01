"""Inventory licensed chart/dashboard filenames and content digests, without extracting vendor source."""
import hashlib,io,json,sys,zipfile
from pathlib import Path
archive=Path(sys.argv[1]);check='--check' in sys.argv
records=[]
with zipfile.ZipFile(archive) as outer:
 for bundle in sorted(outer.namelist()):
  if not bundle.endswith(('vitejs-demo.zip','nextjs-demo.zip')):continue
  with zipfile.ZipFile(io.BytesIO(outer.read(bundle))) as z:
   for name in sorted(z.namelist()):
    if not name.endswith(('.ts','.tsx')) or not('/dashboards/' in name or 'chart' in name.rsplit('/',1)[-1].lower()):continue
    records.append({'bundle':bundle,'path':name,'sha256':hashlib.sha256(z.read(name)).hexdigest(),'disposition':'business_dashboard_deferred_b16' if '/dashboards/' in name else 'chart_family_reference_only','variantParityClaimed':False})
canonical=json.dumps(records,sort_keys=True,separators=(',',':')).encode();result={'format':1,'scope':'TS/TSX in dashboards directories or chart-named files, both licensed v17 demos','sourceArchiveSha256':hashlib.sha256(archive.read_bytes()).hexdigest(),'sourceInventorySha256':hashlib.sha256(canonical).hexdigest(),'physicalFiles':len(records),'files':records,'vendorSourceCopied':False,'fullVariantParityClaimed':False,'businessDashboardsActivated':False,'originalCatalogue':['line','area','grouped_bar','donut','metric'],'deferred':['project/analytics/finance/crypto business dashboards B16','advanced chart families and every vendor property/animation','real registered widget/workflow/data and dashboard preference bindings']}
p=Path('docs/appearance/dashboard-widgets-reference-audit.json')
if check:
 if json.loads(p.read_text())!=result:raise SystemExit('Reference metadata drift')
else:p.write_text(json.dumps(result,indent=2)+'\n')
print(json.dumps({k:result[k] for k in ['physicalFiles','sourceInventorySha256','vendorSourceCopied','fullVariantParityClaimed']}))
