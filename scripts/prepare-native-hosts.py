"""Reproducible native hosts for the inherited shells; no generated caches enter source control."""
import os, sys, shutil, subprocess, json
from pathlib import Path
platform=sys.argv[1]
if platform not in ['windows','android','ios','macos','linux']: raise SystemExit('Unknown platform')
repo=Path.cwd(); root=Path(os.environ['RUNNER_TEMP'])/'primecare-native'/platform
root.mkdir(parents=True,exist_ok=True)
for package in ['primecare_models','primecare_core','primecare_ui']:
 shutil.copytree(repo/'packages'/package,root/'packages'/package,dirs_exist_ok=True,ignore=shutil.ignore_patterns('.dart_tool','build','.git'))
apps=sorted(p.parent.name for p in (repo/'apps').glob('*/pubspec.yaml'))
for app in apps:
 host=root/'apps'/app
 subprocess.run([shutil.which('flutter') or 'flutter','create','--no-pub','--platforms='+platform,'--org=com.primecare','--project-name='+app,str(host)],check=True)
 shutil.rmtree(host/'lib');shutil.copytree(repo/'apps'/app/'lib',host/'lib')
 spec=(repo/'apps'/app/'pubspec.yaml').read_text().replace('dev_dependencies:\n','dev_dependencies:\n  integration_test:\n    sdk: flutter\n  primecare_core:\n    path: ../../packages/primecare_core\n')
 (host/'pubspec.yaml').write_text(spec)
 shutil.rmtree(host/'test',ignore_errors=True)
 (host/'integration_test').mkdir(exist_ok=True)
 shutil.copyfile(repo/'native/auth_integration_test.dart',host/'integration_test/auth_test.dart')
 if platform=='android':
  manifest=host/'android/app/src/main/AndroidManifest.xml';s=manifest.read_text();s=s.replace('    <application','    <uses-permission android:name="android.permission.INTERNET"/>\n    <application',1);manifest.write_text(s)
 if platform=='macos':
  for p in (host/'macos/Runner').glob('*.entitlements'):
   s=p.read_text()
   if 'com.apple.security.network.client' not in s:s=s.replace('</dict>','<key>com.apple.security.network.client</key><true/>\n</dict>')
   p.write_text(s)
 (host/'test').mkdir(exist_ok=True)
 subprocess.run([shutil.which('flutter') or 'flutter','pub','get'],cwd=host,check=True)
(root/'apps.json').write_text(json.dumps(apps))
print('Prepared '+str(len(apps))+' inherited '+platform+' hosts')
