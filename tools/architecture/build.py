#!/usr/bin/env python3
"""Build diagrams with pinned Archify; fail when any validation gate fails."""
import concurrent.futures, json, os, subprocess, sys
from pathlib import Path
ROOT = Path(__file__).resolve().parents[2]
OUT = ROOT / 'docs/architecture/generated'
TOOL = json.loads((ROOT/'tools/architecture/tooling.json').read_text())
CACHE = ROOT / '.architecture-tools/archify'
cli = Path(os.environ.get('ARCHIFY_CLI', CACHE / TOOL['cli'])).resolve()
if not cli.exists():
    CACHE.parent.mkdir(exist_ok=True)
    subprocess.run(['git','clone','--no-checkout','--filter=blob:none',TOOL['repository'],str(CACHE)],check=True)
    subprocess.run(['git','-C',str(CACHE),'checkout',TOOL['revision']],check=True)
upstream = cli.parent.parent.parent
actual = subprocess.check_output(['git','-C',str(upstream),'rev-parse','HEAD'],text=True).strip()
if actual != TOOL['revision']: raise SystemExit('Archify revision differs from tooling.json; use the pinned checkout.')
subprocess.run([sys.executable,str(ROOT/'tools/architecture/generate.py')],cwd=ROOT,check=True)

def render(candidate):
    output = candidate.parent/'map.html'
    command = ['node',str(cli),'finalize','architecture',str(candidate.relative_to(ROOT)),
               str(output.relative_to(ROOT)),'--repo-root',str(ROOT),'--quality','showcase','--json']
    run = subprocess.run(command,cwd=ROOT,capture_output=True,text=True)
    try: receipt = json.loads(run.stdout)
    except json.JSONDecodeError: receipt = {'ok':False,'diagnostics':[{'message':run.stderr[-1200:]}]}
    (candidate.parent/'build-receipt.json').write_text(json.dumps(receipt,indent=2)+'\n')
    return {'diagram':candidate.parent.name,'passed':run.returncode==0 and receipt.get('ok') is True,
            'gates':receipt.get('gates',{}),'diagnostics':receipt.get('diagnostics',[])}

candidates = sorted(OUT.glob('*/candidate.json'))
with concurrent.futures.ThreadPoolExecutor(max_workers=4) as pool:
    results = list(pool.map(render,candidates))
summary = {'archify_revision':actual,'passed':sum(r['passed'] for r in results),'total':len(results),'diagrams':results}
(OUT/'validation.json').write_text(json.dumps(summary,indent=2)+'\n')
print(json.dumps(summary,indent=2))
if summary['passed'] != summary['total']: raise SystemExit(1)
