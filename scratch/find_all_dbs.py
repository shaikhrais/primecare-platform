import os

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

def main():
    print(f"Scanning for database files in {PROJECT_ROOT}...")
    for root, dirs, files in os.walk(PROJECT_ROOT):
        # Skip node_modules, .git, build, and similar folders to speed up
        skip_dirs = ['.git', 'node_modules', 'build', '.dart_tool', 'ios', 'android']
        dirs[:] = [d for d in dirs if d not in skip_dirs]
        
        for file in files:
            if file.endswith('.db') or file.endswith('.sqlite') or file.endswith('.sqlite3'):
                full_path = os.path.join(root, file)
                rel_path = os.path.relpath(full_path, PROJECT_ROOT)
                size_bytes = os.path.getsize(full_path)
                print(f"  Found: {rel_path} ({size_bytes} bytes)")

if __name__ == '__main__':
    main()
