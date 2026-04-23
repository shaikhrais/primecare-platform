import os

apps_dir = 'apps'
apps = [
    'primecare_business_development',
    'primecare_client',
    'primecare_clinic',
    'primecare_corporate',
    'primecare_franchise',
    'primecare_marketing',
    'primecare_support'
]

for app in apps:
    pubspec_path = os.path.join(apps_dir, app, 'pubspec.yaml')
    if os.path.exists(pubspec_path):
        with open(pubspec_path, 'r') as f:
            lines = f.readlines()
        
        has_assets = False
        has_data = False
        flutter_line_idx = -1
        
        for i, line in enumerate(lines):
            if line.strip() == 'flutter:':
                flutter_line_idx = i
            if 'assets:' in line:
                has_assets = True
            if '- assets/data/' in line:
                has_data = True
        
        if not has_data:
            if has_assets:
                # Find the assets: line and add - assets/data/ below it
                for i, line in enumerate(lines):
                    if 'assets:' in line:
                        lines.insert(i + 1, '    - assets/data/\n')
                        break
            else:
                # Find flutter: line and add assets: block
                if flutter_line_idx != -1:
                    # Check if uses-material-design is there
                    inserted = False
                    for j in range(flutter_line_idx + 1, len(lines)):
                        if 'uses-material-design:' in lines[j]:
                            lines.insert(j + 1, '  assets:\n    - assets/data/\n')
                            inserted = True
                            break
                    if not inserted:
                        lines.insert(flutter_line_idx + 1, '  assets:\n    - assets/data/\n')
                else:
                    lines.append('flutter:\n  assets:\n    - assets/data/\n')
            
            with open(pubspec_path, 'w', encoding='utf-8') as f:
                f.writelines(lines)
            print(f'Updated {pubspec_path}')
        else:
            print(f'Skipped {pubspec_path} (already has assets/data/)')
