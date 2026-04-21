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
    package_stats = {} # {package_name: {ext: {count, size, loc}}}
    lang_stats = {} # {ext: {count, size, loc}}
    
    def get_package_name(path):
        parts = path.split(os.sep)
        if len(parts) > 1 and parts[0] in ['apps', 'packages']:
            return parts[1]
        return "root"
    
    for f, n_path in registry_data:
        mtime = datetime.datetime.fromisoformat(f['mtime'])
        age_days = (now - mtime).days
        loc = f.get('loc', 0)
        
        # Package and Extension attribution
        pkg = get_package_name(f['path'])
        _, ext = os.path.splitext(f['path'])
        ext = ext.lower() or "no-ext"
        
        # Update Package Stats
        if pkg not in package_stats:
            package_stats[pkg] = {}
        if ext not in package_stats[pkg]:
            package_stats[pkg][ext] = {"count": 0, "size": 0, "loc": 0}
            
        package_stats[pkg][ext]["count"] += 1
        package_stats[pkg][ext]["size"] += f['size']
        package_stats[pkg][ext]["loc"] += loc

        # Update Language Stats
        if ext not in lang_stats:
            lang_stats[ext] = {"count": 0, "size": 0, "loc": 0}
        lang_stats[ext]["count"] += 1
        lang_stats[ext]["size"] += f['size']
        lang_stats[ext]["loc"] += loc

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

    total_loc = sum(s['loc'] for pkg in package_stats.values() for s in pkg.values())
    total_size_mb = sum(s['size'] for pkg in package_stats.values() for s in pkg.values()) / (1024 * 1024)

    report = {
        "summary": {
            "total_files": len(all_files),
            "total_loc": total_loc,
            "total_size_mb": total_size_mb,
            "hardened_count": len(hardened),
            "infrastructure_count": len(infrastructure),
            "orphan_count": len(orphans),
            "legacy_cold_count": len(legacy),
        },
        "language_distribution": lang_stats,
        "package_allotment": package_stats,
        "top_orphans": orphans[:20],
        "top_legacy_cold": legacy[:20]
    }
    
    with open("pdm_advanced_report.json", "w", encoding='utf-8') as f:
        json.dump(report, f, indent=2)
        
    # Generate Markdown Insights
    with open("pdm_insights.md", "w", encoding='utf-8') as f:
        f.write("# 🌐 PrimeCare: Full Codebase Picture\n\n")
        
        f.write("## 🚀 Platform Vitality Overview\n")
        f.write(f"- **Total Scale**: {len(all_files)} Files | **{total_loc:,}** Lines of Code\n")
        f.write(f"- **Total Volume**: **{total_size_mb:.2f} MB** on Disk\n")
        f.write(f"- **Mapping Maturity**: {len(hardened)} Hardened Sectors | {len(infrastructure)} Infrastructure Units\n\n")

        f.write("## 🗺️ Architectural Landscape\n")
        f.write("```mermaid\ngraph TD\n")
        f.write("    Root[PrimeCare Repo] --> Apps[Apps Layer]\n")
        f.write("    Root --> Pkgs[Packages Layer]\n")
        f.write("    Root --> Infra[Infrastructure]\n\n")
        f.write("    subgraph Apps\n")
        for pkg, stats in package_stats.items():
            if any(x in pkg for x in ['client', 'clinic', 'corporate', 'marketing', 'support', 'business']):
                f.write(f"        {pkg}[{pkg.replace('_', ' ').title()}]\n")
        f.write("    end\n\n")
        f.write("    subgraph Packages\n")
        for pkg, stats in package_stats.items():
            if any(x in pkg for x in ['core', 'adapters', 'factory', 'database', 'messaging', 'security']):
                f.write(f"        {pkg}[{pkg.replace('_', ' ').title()}]\n")
        f.write("    end\n```\n\n")

        f.write("## 📊 Language Volume Distribution\n")
        f.write("| Language | File Count | Total LOC | Total Size (KB) |\n")
        f.write("| :--- | :--- | :--- | :--- |\n")
        sorted_langs = sorted(lang_stats.items(), key=lambda x: x[1]['loc'], reverse=True)
        for ext, data in sorted_langs:
            f.write(f"| `{ext}` | {data['count']} | {data['loc']:,} | {data['size']/1024:.1f} |\n")

        f.write("\n## 📦 Package Density & Capacity\n")
        f.write("| Package/App | Total LOC | Total Size (MB) | Density (LOC/File) |\n")
        f.write("| :--- | :--- | :--- | :--- |\n")
        
        # Sort packages by total LOC
        sorted_pkgs = sorted(package_stats.items(), key=lambda x: sum(t['loc'] for t in x[1].values()), reverse=True)
        
        for pkg, types in sorted_pkgs:
            p_loc = sum(t['loc'] for t in types.values())
            p_size = sum(t['size'] for t in types.values()) / (1024 * 1024)
            p_count = sum(t['count'] for t in types.values())
            density = p_loc / p_count if p_count > 0 else 0
            f.write(f"| `{pkg}` | {p_loc:,} | {p_size:.2f} | {density:.1f} |\n")
        
        f.write("\n## 🚩 Orphan Risk Assessment\n")
        f.write("| Path | LOC | Size (KB) | Age (Days) |\n| :--- | :--- | :--- | :--- |\n")
        for o in report['top_orphans']:
            loc = o.get('loc', 0)
            f.write(f"| {o['path']} | {loc} | {o['size']/1024:.1f} | {o['age_days']} |\n")

    print(f"Full Picture Generated: {total_loc:,} LOC across {len(package_stats)} packages.")

if __name__ == "__main__":
    generate_advanced_report()
