import os,sys,subprocess,json,shutil
from pathlib import Path
platform=sys.argv[1];root=Path(os.environ['RUNNER_TEMP'])/'primecare-native'/platform
artifacts=root/'artifacts';artifacts.mkdir(exist_ok=True);results=[]
for app in json.loads((root/'apps.json').read_text()):
 host=root/'apps'/app
 command=[shutil.which('flutter') or 'flutter','build',{'android':'apk','ios':'ios'}.get(platform,platform),'--release','--dart-define=AUTH_API_URL=https://primecare-api-gateway.itpro-mohammed.workers.dev/v1/auth']
 if platform=='ios':command+=['--no-codesign']
 code=subprocess.run(command,cwd=host).returncode
 results.append({'app':app,'platform':platform,'build':'passed' if code==0 else 'failed'})
 print(('PASS' if code==0 else 'FAIL')+' native build: '+app+' '+platform,flush=True)
 if code==0:
  if platform=='android':shutil.copyfile(host/'build/app/outputs/flutter-apk/app-release.apk',artifacts/(app+'.apk'))
  else:
   paths={'windows':'build/windows/x64/runner/Release','linux':'build/linux/x64/release/bundle','macos':'build/macos/Build/Products/Release','ios':'build/ios/iphoneos'}
   shutil.make_archive(str(artifacts/app),'zip',host/paths[platform])
(artifacts/'build-results.json').write_text(json.dumps(results,indent=2))
with open(os.environ['GITHUB_STEP_SUMMARY'],'a') as f:
 for r in results:f.write(f"{r['app']} / {platform}: {r['build']}\n\n")
if any(r['build']=='failed' for r in results):raise SystemExit(1)
