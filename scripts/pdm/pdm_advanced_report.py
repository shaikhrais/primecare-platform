import json
import os
import datetime

PROJECT_ROOT = "C:/Users/Admin2/Documents/GitHub/primecare-platform"
GLOBAL_REGISTRY = os.path.join(PROJECT_ROOT, "pdm_global_registry.json")
INTENT_SNAPSHOT = os.path.join(PROJECT_ROOT, "pdm_snapshot.json")

def generate_advanced_report():
    if not os.path.exists(GLOBAL_REGISTRY) or not os.path.exists(INTENT_SNAPSHOT):
        print("Required snapshots missing.")
        return

    with open(GLOBAL_REGISTRY, "r") as f:
        all_files = json.load(f)
    with open(INTENT_SNAPSHOT, "r") as f:
        intents = json.load(f)

    # Normalize paths for matching
    def norm(p):
        return p.replace('/', '\\').lower().lstrip('\\')

    # List of (norm_rel_path, intentId)
    intent_paths = [(norm(item['rel_path']), item['intentId']) for item in intents if item['rel_path'] != 'N/A']
    
    orphans = []
    hardened = []
    infrastructure = []
    legacy = []
    
    now = datetime.datetime.now()
    
    # Pre-calculate normalized registry paths
    registry_data = []
    for f in all_files:
        n_path = norm(f['path'])
        registry_data.append((f, n_path))
    
    # Grouping data
    package_stats = {} # {package_name: {ext: {count, size}}}
    
    def get_package_name(path):
        parts = path.split(os.sep)
        if len(parts) > 1 and parts[0] in ['apps', 'packages']:
            return parts[1]
        return "root"
    
    for f, n_path in registry_data:
        mtime = datetime.datetime.fromisoformat(f['mtime'])
        age_days = (now - mtime).days
        
        # Package and Extension attribution
        pkg = get_package_name(f['path'])
        _, ext = os.path.splitext(f['path'])
        ext = ext.lower() or "no-ext"
        
        if pkg not in package_stats:
            package_stats[pkg] = {}
        if ext not in package_stats[pkg]:
            package_stats[pkg][ext] = {"count": 0, "size": 0}
            
        package_stats[pkg][ext]["count"] += 1
        package_stats[pkg][ext]["size"] += f['size']

        # Check if any intent path matches this file (as a suffix)
        matched_intent = next((intent_id for i_path, intent_id in intent_paths if n_path.endswith(i_path)), None)
        
        file_info = {
            "path": f['path'],
            "age_days": age_days,
            "size": f['size'],
            "intent_id": matched_intent
        }
        
        if matched_intent:
            hardened.append(file_info)
        elif any(x in n_path for x in ['01_i_', '05_u_', 'registry', 'manifest']):
            infrastructure.append(file_info)
        elif n_path.endswith('.dart') and 'lib' in n_path:
            # It's a code file in lib but NOT mapped to an intent or infra
            if age_days > 90:
                legacy.append(file_info)
            else:
                orphans.append(file_info)
                
    # Sort orphans by size (largest first)
    orphans.sort(key=lambda x: x['size'], reverse=True)
    legacy.sort(key=lambda x: x['age_days'], reverse=True)

    report = {
        "summary": {
            "total_files": len(all_files),
            "hardened_count": len(hardened),
            "infrastructure_count": len(infrastructure),
            "orphan_count": len(orphans),
            "legacy_cold_count": len(legacy),
        },
        "package_allotment": package_stats,
        "top_orphans": orphans[:20],
        "top_legacy_cold": legacy[:20]
    }
    
    with open("pdm_advanced_report.json", "w", encoding='utf-8') as f:
        json.dump(report, f, indent=2)
        
    # Generate Markdown Insights
    with open("pdm_insights.md", "w", encoding='utf-8') as f:
        f.write("# Advanced PDM Insights\n\n")
        f.write(f"- **Total Files Scanned**: {len(all_files)}\n\n")
        f.write("### 🏗️ Architectural Distribution\n")
        f.write(f"- **Hardened Sectors (Intent-Mapped)**: {len(hardened)}\n")
        f.write(f"- **Infrastructure Sectors (Core/Registry)**: {len(infrastructure)}\n")
        f.write(f"- **Orphans (New, Unmapped)**: {len(orphans)}\n")
        f.write(f"- **Legacy 'Cold' Sectors (>90 days old)**: {len(legacy)}\n\n")

        f.write("## 📦 Package & App Allotment Registry\n")
        f.write("| Package/App | File Type | Count | Total Size (KB) |\n")
        f.write("| :--- | :--- | :--- | :--- |\n")
        
        # Sort packages by total count
        sorted_pkgs = sorted(package_stats.items(), key=lambda x: sum(t['count'] for t in x[1].values()), reverse=True)
        
        for pkg, types in sorted_pkgs:
            # Sort types by count
            sorted_types = sorted(types.items(), key=lambda x: x[1]['count'], reverse=True)
            for ext, data in sorted_types:
                f.write(f"| `{pkg}` | `{ext}` | {data['count']} | {data['size']/1024:.1f} |\n")
        
        f.write("\n## 🚩 Top Orphan Candidates (Priority Mapping/Deletion)\n")
        f.write("| Path | Size (KB) | Age (Days) |\n| :--- | :--- | :--- |\n")
        for o in report['top_orphans']:
            f.write(f"| {o['path']} | {o['size']/1024:.1f} | {o['age_days']} |\n")
            
        f.write("\n## 🧊 Cold Sector Technical Debt (Modernization Targets)\n")
        f.write("| Path | Size (KB) | Last Touched (Days) |\n| :--- | :--- | :--- |\n")
        for l in report['top_legacy_cold']:
            f.write(f"| {l['path']} | {l['size']/1024:.1f} | {l['age_days']} |\n")

    print(f"Advanced Report Generated: {len(hardened)} hardened, {len(package_stats)} packages analyzed.")

if __name__ == "__main__":
    generate_advanced_report()
