"""Prove the pinned old client's false success, then restore the repaired client."""
import hashlib
import pathlib
import re
import shutil
import subprocess

ROOT = pathlib.Path(__file__).resolve().parents[4]
BASE = 'e9120a7cad841a3cc7794dcab1d4a319f3422f5b'
PATH = 'packages/flutter_core/lib/src/network/api_client.dart'
OLD_BLOB = 'e6e6f3afc8cf2c1f349e809e6df092ad754eadc3'
TARGET = 'failed help request never invents a reachable support service'

probe = subprocess.run(['git', 'show', BASE + ':' + PATH], cwd=ROOT,
                       stdout=subprocess.PIPE, stderr=subprocess.PIPE, timeout=30)
if probe.returncode:
    subprocess.run(['git', 'fetch', '--no-tags', '--filter=blob:none', '--depth=1',
                    'origin', BASE], cwd=ROOT, check=True, timeout=90)
    legacy = subprocess.check_output(['git', 'show', BASE + ':' + PATH], cwd=ROOT,
                                     timeout=30)
else:
    legacy = probe.stdout
digest = hashlib.sha1(b'blob ' + str(len(legacy)).encode() + b'\0' + legacy).hexdigest()
if digest != OLD_BLOB:
    raise RuntimeError('Historical ApiClient identity differs; do not refresh the pin blindly')
source = ROOT / PATH
repaired = source.read_bytes()
if b'isApplicationWorkflowPath(path)' not in repaired:
    raise RuntimeError('Repaired failure boundary is absent')
flutter = shutil.which('flutter')
if flutter is None:
    raise RuntimeError('Flutter is required; no authored test is counted as execution')
try:
    source.write_bytes(legacy)
    result = subprocess.run([flutter, 'test',
                             'test/application_modules/application_workflow_failure_test.dart',
                             '--plain-name', TARGET, '--reporter', 'expanded'],
                            cwd=ROOT / 'packages/flutter_core', stdout=subprocess.PIPE,
                            stderr=subprocess.STDOUT, text=True, encoding='utf-8', errors='replace', timeout=180)
    output = re.sub(r'\x1b\[[0-9;]*m', '', result.stdout)
    print(output[-6000:].encode('ascii', 'backslashreplace').decode('ascii'))
    if (result.returncode == 0 or TARGET not in output or
            re.search(r'Expected:\s*false', output) is None or
            re.search(r'Actual:\s*true', output) is None):
        raise RuntimeError('Expected old-source false-success regression was not reproduced')
    print('PC10_SECTION2_OLD_SOURCE_CONTROL ' + BASE + ' ' + OLD_BLOB +
          ' reproduced_false_success=true')
finally:
    source.write_bytes(repaired)
if source.read_bytes() != repaired:
    raise RuntimeError('Repaired ApiClient was not restored')
