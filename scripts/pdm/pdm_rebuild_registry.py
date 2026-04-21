import os
import json
import datetime

PROJECT_ROOT = "C:/Users/Admin2/Documents/GitHub/primecare-platform"
REGISTRY_PATH = os.path.join(PROJECT_ROOT, "pdm_global_registry.json")

def get_loc(path):
    try:
        with open(path, 'r', encoding='utf-8', errors='ignore') as f:
            return len(f.readlines())
    except:
        return 0

def get_debt(path):
    try:
        with open(path, 'r', encoding='utf-8', errors='ignore') as f:
            content = f.read()
            return content.count('TODO') + content.count('FIXME') + content.count('HACK')
    except:
        return 0

def rebuild_registry():
    print(f"Rebuilding PDM Global Registry...")
    registry = []
    
    for root, dirs, files in os.walk(PROJECT_ROOT):
        # Skip noisy dirs
        dirs[:] = [d for d in dirs if not d.startswith('.') and d not in ['node_modules', 'build', '.dart_tool', 'archive']]
        
        for file in files:
            abs_path = os.path.join(root, file)
            rel_path = os.path.relpath(abs_path, PROJECT_ROOT)
            
            stat = os.stat(abs_path)
            mtime = datetime.datetime.fromtimestamp(stat.st_mtime).isoformat()
            
            is_debris = False
            # Debris logic: stale logs or known redundant patterns
            if rel_path.endswith('.log') or rel_path.endswith('.tmp'):
                is_debris = True
            
            registry.append({
                "path": rel_path,
                "mtime": mtime,
                "size": stat.st_size,
                "loc": get_loc(abs_path) if rel_path.endswith('.dart') or rel_path.endswith('.ts') or rel_path.endswith('.py') else 0,
                "velocity": 0, # Requires git history, set to 0 for now
                "debt": get_debt(abs_path),
                "coupling": 0,
                "is_debris": is_debris
            })
            
    with open(REGISTRY_PATH, 'w', encoding='utf-8') as f:
        json.dump(registry, f, indent=2)
    
    print(f"Registry Rebuilt: {len(registry)} files indexed.")

if __name__ == "__main__":
    rebuild_registry()
