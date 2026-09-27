f = open('packages/flutter_core/lib/registry/platform_screen_registry.dart', encoding='utf-8').read()
lines = f.split('\n')
start = -1
for i, line in enumerate(lines):
    if 'SCREEN_CLINICAL_DIRECTOR_DASHBOARD' in line:
        start = i
        break
if start != -1:
    print('\n'.join(lines[start:start+15]))
