"""Install exact delivered APK without test/update bypass flags; zero calls/login."""
import hashlib
import json
import subprocess
import time
from pathlib import Path

root = Path('apk-install-evidence')
root.mkdir(exist_ok=True)
apk = Path('apk/PrimeCare-Calls-native-test.apk')
receipt = {
    'apkSource': 'c25f9f428646b86f5247b84d885870b177c7ad3d',
    'apkSha256': hashlib.sha256(apk.read_bytes()).hexdigest(),
    'emulator': True, 'callsPlaced': 0, 'loginAttempted': False,
    'package': 'ca.primecare.calls.test', 'installed': False, 'launched': False,
    'nativeLoginVisible': False, 'physicalHandsetVerified': False,
}

def adb(*args, check=True):
    result = subprocess.run(['adb', *args], text=True, capture_output=True, timeout=90)
    output = result.stdout + result.stderr
    if check and result.returncode != 0:
        raise RuntimeError(output)
    return output

try:
    receipt['androidRelease'] = adb('shell', 'getprop', 'ro.build.version.release').strip()
    receipt['sdk'] = adb('shell', 'getprop', 'ro.build.version.sdk').strip()
    receipt['abi'] = adb('shell', 'getprop', 'ro.product.cpu.abi').strip()
    assert receipt['sdk'] == '33'
    # Fresh package; do not hide test-only, downgrade or signing errors with flags.
    assert 'package:' not in adb('shell', 'pm', 'list', 'packages', 'ca.primecare.calls.test')
    output = adb('install', '--no-streaming', str(apk), check=False)
    (root / 'install.txt').write_text(output)
    receipt['installed'] = 'Success' in output
    if not receipt['installed']:
        raise RuntimeError(output)
    output = adb('shell', 'am', 'start', '-W', '-n', 'ca.primecare.calls.test/ca.primecare.calls.MainActivity')
    (root / 'launch.txt').write_text(output)
    receipt['launched'] = 'Status: ok' in output
    assert receipt['launched']
    for _ in range(12):
        adb('shell', 'uiautomator', 'dump', '/data/local/tmp/calling-login.xml', check=False)
        ui = adb('shell', 'cat', '/data/local/tmp/calling-login.xml', check=False)
        if 'Sign in' in ui and 'Email' in ui and 'Password' in ui:
            receipt['nativeLoginVisible'] = True
            break
        time.sleep(1)
    assert receipt['nativeLoginVisible']
    assert adb('shell', 'pidof', 'ca.primecare.calls.test').strip()
    (root / 'package.txt').write_text(adb('shell', 'dumpsys', 'package', 'ca.primecare.calls.test'))
    receipt['passed'] = True
except Exception as error:
    receipt['passed'] = False
    receipt['error'] = str(error)[:2000]
    raise
finally:
    (root / 'receipt.json').write_text(json.dumps(receipt, indent=2) + '\n')
    print('CALLING_APK_INSTALL ' + json.dumps(receipt))
