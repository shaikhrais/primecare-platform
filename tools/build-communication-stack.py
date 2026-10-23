"""Build a throwaway host around existing Flutter widgets, never a new portal."""
import os,subprocess,json
from pathlib import Path
root=Path(__file__).resolve().parents[1]
target=Path(os.environ['RUNNER_TEMP'])/'communication-stack-host'
target.mkdir(parents=True,exist_ok=True)
subprocess.run(['flutter','create','--platforms=web','--project-name=communication_stack_acceptance',str(target)],check=True)
(target/'pubspec.yaml').write_text('name: communication_stack_acceptance\npublish_to: none\nenvironment:\n  sdk: ^3.11.3\ndependencies:\n  flutter:\n    sdk: flutter\n  flutter_riverpod: ^3.3.1\n  flutter_core:\n    path: '+str(root/'packages/flutter_core')+'\n  primecare_ui:\n    path: '+str(root/'packages/primecare_ui')+'\n')
(target/'lib/main.dart').write_text((root/'packages/primecare_ui/test/communication_stack_harness.dart').read_text())
subprocess.run(['flutter','pub','get'],cwd=target,check=True)
subprocess.run(['flutter','build','web','--release','--no-web-resources-cdn'],cwd=target,check=True)
with open(os.environ['GITHUB_ENV'],'a') as output:output.write('COMMUNICATION_STACK_WEB='+str(target/'build/web')+'\n')
