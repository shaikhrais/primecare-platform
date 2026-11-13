"""Compare App Sandbox startup with/without a second sandbox; no product acceptance."""
import json
import os
import plistlib
import subprocess
import sys
import tempfile
from pathlib import Path


def main():
    if sys.platform != 'darwin':
        raise RuntimeError('This control requires macOS Actions')
    with tempfile.TemporaryDirectory(prefix='primecare-sandbox-control-') as temporary:
        root = Path(temporary)
        app = root / 'StartupControl.app'
        binary = app / 'Contents/MacOS/StartupControl'
        binary.parent.mkdir(parents=True)
        (app / 'Contents/Info.plist').write_bytes(plistlib.dumps({
            'CFBundleIdentifier': 'com.primecare.ci.startupcontrol',
            'CFBundleExecutable': 'StartupControl', 'CFBundlePackageType': 'APPL',
            'CFBundleName': 'StartupControl', 'CFBundleVersion': '1'}))
        source = root / 'control.c'
        source.write_text('#include <stdio.h>\nint main(void){puts("STARTUP_CONTROL_ENTERED_MAIN");return 0;}\n')
        subprocess.run(['xcrun', 'clang', str(source), '-o', str(binary)], check=True)
        entitlements = root / 'control.entitlements'
        entitlements.write_bytes(plistlib.dumps({'com.apple.security.app-sandbox': True}))
        subprocess.run(['codesign', '--force', '--sign', '-', '--entitlements', str(entitlements), str(app)], check=True)
        subprocess.run(['codesign', '--verify', '--deep', '--strict', str(app)], check=True)
        signed = subprocess.run(['codesign', '-d', '--entitlements', ':-', str(app)], check=True, capture_output=True)
        values = plistlib.loads(signed.stdout)
        if values != {'com.apple.security.app-sandbox': True}:
            raise RuntimeError('Unexpected control entitlements')
        home = root / 'home'
        home.mkdir()
        environment = {'HOME': str(home), 'CFFIXED_USER_HOME': str(home),
                       'TMPDIR': str(home), 'PATH': '/usr/bin:/bin:/usr/sbin:/sbin'}
        results = {}
        for mode, command in [
            ('direct', [str(binary)]),
            ('nested', ['/usr/bin/sandbox-exec', '-p', '(version 1) (allow default) (deny network*)', str(binary)])]:
            try:
                child = subprocess.run(command, env=environment, capture_output=True, timeout=15)
                results[mode] = {'returnCode': child.returncode,
                                 'enteredMain': b'STARTUP_CONTROL_ENTERED_MAIN' in child.stdout,
                                 'stderrTail': child.stderr[-2048:].decode('utf-8', errors='replace')}
            except subprocess.TimeoutExpired:
                results[mode] = {'timedOut': True, 'enteredMain': False}
        direct = results['direct'].get('returnCode') == 0 and results['direct']['enteredMain']
        nested = results['nested'].get('returnCode') == 0 and results['nested']['enteredMain']
        report = {'control': 'locally compiled no-network-entitlement App Sandbox fixture',
                  'source': os.environ.get('GITHUB_SHA'), 'results': results,
                  'nestedSandboxFailureReproduced': direct and not nested,
                  'productStartupTested': False, 'featureAcceptance': False}
        Path('macos-sandbox-control.json').write_text(json.dumps(report, indent=2) + '\n')
        print(json.dumps(report))
        if not direct:
            raise RuntimeError('Direct fixture control did not enter main; nested-sandbox inference unavailable')


if __name__ == '__main__':
    main()
