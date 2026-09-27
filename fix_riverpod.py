import os
import glob

files = glob.glob('**/pubspec.yaml', recursive=True)
for f in files:
    with open(f, 'r') as file:
        content = file.read()
    if 'flutter_riverpod: ^3.3.1' in content:
        content = content.replace('flutter_riverpod: ^3.3.1', 'flutter_riverpod: ^2.6.1')
        with open(f, 'w') as file:
            file.write(content)
        print(f'Updated {f}')
