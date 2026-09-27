import os

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
SCREENS_DIR = os.path.join(PROJECT_ROOT, "packages", "primecare_ui", "lib", "src", "screens")

def main():
    print(f"Scanning for stubbed/empty screens in {SCREENS_DIR}...")
    empty_files = []
    
    for root, dirs, files in os.walk(SCREENS_DIR):
        for file in files:
            if file.endswith('.dart'):
                full_path = os.path.join(root, file)
                size = os.path.getsize(full_path)
                if size < 100:
                    rel_path = os.path.relpath(full_path, PROJECT_ROOT)
                    empty_files.append((rel_path, size, full_path))
                    
    print(f"\nFound {len(empty_files)} empty/stubbed screen files:")
    for rel_path, size, _ in empty_files:
        print(f"  - {rel_path} ({size} bytes)")

if __name__ == '__main__':
    main()
