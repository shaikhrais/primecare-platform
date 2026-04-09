import os

base = r'C:\Users\Admin2\Documents\GitHub\primecare-platform\packages\primecare_ui\lib'
src = os.path.join(base, 'src')

components = []
forms = []
layouts = []
screens = []
theme = []

for root, _, files in os.walk(src):
    for f in files:
        if not f.endswith('.dart'): continue
        
        path = os.path.join(root, f)
        rel_path = os.path.relpath(path, base).replace(os.sep, '/').replace('\\', '/')
        
        if 'components/layouts' in rel_path:
            layouts.append(rel_path)
        elif 'components' in rel_path:
            if 'form' in f:
                forms.append(rel_path)
            else:
                components.append(rel_path)
        elif 'screens' in rel_path:
            screens.append(rel_path)
        elif 'theme' in rel_path:
            theme.append(rel_path)

with open(os.path.join(base, 'components.dart'), 'w', encoding='utf-8') as f:
    f.write('// Auto-generated module: components\n\n')
    for p in components: f.write(f"export '{p}';\n")

with open(os.path.join(base, 'layouts.dart'), 'w', encoding='utf-8') as f:
    f.write('// Auto-generated module: layouts\n\n')
    for p in layouts: f.write(f"export '{p}';\n")

with open(os.path.join(base, 'forms.dart'), 'w', encoding='utf-8') as f:
    f.write('// Auto-generated module: forms\n\n')
    for p in forms: f.write(f"export '{p}';\n")

with open(os.path.join(base, 'theme.dart'), 'w', encoding='utf-8') as f:
    f.write('// Auto-generated module: theme\n\n')
    for p in theme: f.write(f"export '{p}';\n")

screen_offices = {}
for s in screens:
    parts = s.split('/')
    if 'offices' in parts:
        idx = parts.index('offices')
        if len(parts) > idx + 1:
            office = parts[idx + 1]
            if office not in screen_offices: screen_offices[office] = []
            screen_offices[office].append(s)
    elif 'auth' in parts:
        if 'auth' not in screen_offices: screen_offices['auth'] = []
        screen_offices['auth'].append(s)
    elif 'common' in parts:
        if 'common' not in screen_offices: screen_offices['common'] = []
        screen_offices['common'].append(s)
    elif 'stitch_generated' in parts:
        if 'stitch_generated' not in screen_offices: screen_offices['stitch_generated'] = []
        screen_offices['stitch_generated'].append(s)
    else:
        if 'misc' not in screen_offices: screen_offices['misc'] = []
        screen_offices['misc'].append(s)

os.makedirs(os.path.join(base, 'screens'), exist_ok=True)
for office, files in screen_offices.items():
    with open(os.path.join(base, 'screens', f"{office}.dart"), 'w', encoding='utf-8') as f:
        f.write(f'// Auto-generated screens for office: {office}\n\n')
        for p in files:
            p_rel = '../' + p
            f.write(f"export '{p_rel}';\n")

with open(os.path.join(base, 'screens.dart'), 'w', encoding='utf-8') as f:
    f.write('// Auto-generated module: screens\n\n')
    for office in screen_offices.keys():
        f.write(f"export 'screens/{office}.dart';\n")

print('Regenerated barrel files.')
