"""Compile every migrated public provider/class under one Flutter test harness."""
import json
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
records=json.loads((ROOT/'docs/architecture/controller-migration.json').read_text())['migrated']
lines=["import 'package:flutter_test/flutter_test.dart';",
       "import 'package:flutter_riverpod/flutter_riverpod.dart';"]
for i,r in enumerate(records):lines.append("import '../../../"+r['path']+"' as feature"+str(i)+";")
lines += ['', 'void main() {', "  test('every migrated provider retains its public identity', () {", '    final providers = <Object>[']
for i,r in enumerate(records):lines.append('      feature'+str(i)+'.'+r['provider']+',')
lines += ['    ];',f'    expect(providers.length, {len(records)});','  });']
lines += ["  test('feature state factories retain concrete types and clear errors', () {"]
for i,r in enumerate(records):
 if r['kind']=='dashboard':
  cls='feature'+str(i)+'.'+r['state']
  lines += [f"    final state{i} = {cls}(isLoading: false, error: 'failed', data: {{}});",
    f'    expect(state{i}.copyWith(error: null), isA<{cls}>());',
    f'    expect(state{i}.copyWith(error: null).error, isNull);']
lines += ['  });',"  test('every scaffold rejects unsupported completion', () async {",'    final container = ProviderContainer();', '    addTearDown(container.dispose);']
for i,r in enumerate(records):
 if r['kind']=='scaffold':
  provider='feature'+str(i)+'.'+r['provider']
  lines += [f"    expect(container.read({provider}).requireValue['status'], 'not_implemented');",
    f'    await container.read({provider}.notifier).performAction();',
    f'    expect(container.read({provider}).error, isA<UnsupportedError>());']
lines += ['  });','}']
p=ROOT/'packages/flutter_core/test/controller_migration_compile_test.dart'
if p.exists() and "every migrated provider retains its public identity" not in p.read_text():raise ValueError('Refusing to replace unrelated test')
p.write_text('\n'.join(lines)+'\n')
print('Generated controller compile harness:',len(records))
