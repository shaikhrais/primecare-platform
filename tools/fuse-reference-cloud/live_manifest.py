"""Read public portal release stamps and verify their current static assets.
No deployment, authentication attempt or business API is invoked.
"""
import concurrent.futures
import datetime
import json
from pathlib import Path
import sys
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT))
from tools.deployment.typescript_release import verify_live, validate
from tools.deployment.http_client import read_public_asset
BASELINE='12ec8b021b249d5eea50fc8e81f2ef095612c4a3'

def check(project):
    result=dict(project=project,assetIntegrityVerified=False,businessBehaviorVerified=False)
    try:
        stamp=json.loads(read_public_asset('https://'+project+'.pages.dev/primecare-build.json'))
        validate(stamp,project,stamp.get('commit',''))
        verified=verify_live(project,stamp['commit'],stamp)
        result.update(sourceCommit=verified['commit'],assetIntegrityVerified=True,filesVerified=len(verified['files']),matchesLastAcceptedSource=verified['commit']==BASELINE)
    except Exception as error:
        result['errorType']=type(error).__name__
    return result

if __name__=='__main__':
    projects=json.loads((ROOT/'websites/typescript/projects.json').read_text())
    with concurrent.futures.ThreadPoolExecutor(max_workers=3) as pool:
        results=list(pool.map(check,projects))
    output=Path(sys.argv[1]);output.parent.mkdir(parents=True,exist_ok=True)
    report=dict(observedAtUtc=datetime.datetime.now(datetime.timezone.utc).isoformat(),lastAcceptedSource=BASELINE,portals=results,limitations=['Static release identity/integrity only; signed-in business and visual parity are not established.'])
    output.write_text(json.dumps(report,indent=2)+'\n')
    print(json.dumps(dict(portals=len(results),assetIntegrityPassed=sum(r['assetIntegrityVerified'] for r in results))))
    raise SystemExit(0 if all(r['assetIntegrityVerified'] for r in results) else 1)
