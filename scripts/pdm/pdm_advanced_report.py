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
    package_stats = {} # {package_name: {ext: {count, size, loc, debt, velocity, coupling}}}
    lang_stats = {} # {ext: {count, size, loc, debt, velocity, coupling}}
    debris_count = 0
    total_debt = 0
    
    def get_package_name(path):
        parts = path.split(os.sep)
        if len(parts) > 1 and parts[0] in ['apps', 'packages']:
            return parts[1]
        return "root"
    
    for f, n_path in registry_data:
        mtime = datetime.datetime.fromisoformat(f['mtime'])
        age_days = (now - mtime).days
        loc = f.get('loc', 0)
        debt = f.get('debt', 0)
        velocity = f.get('velocity', 0)
        coupling = f.get('coupling', 0)
        is_debris = f.get('is_debris', False)
        
        if is_debris: debris_count += 1
        total_debt += debt
        
        # Package and Extension attribution
        pkg = get_package_name(f['path'])
        _, ext = os.path.splitext(f['path'])
        ext = ext.lower() or "no-ext"
        
        # Update Package Stats
        if pkg not in package_stats:
            package_stats[pkg] = {}
        if ext not in package_stats[pkg]:
            package_stats[pkg][ext] = {"count": 0, "size": 0, "loc": 0, "debt": 0, "velocity": 0, "coupling": 0}
            
        package_stats[pkg][ext]["count"] += 1
        package_stats[pkg][ext]["size"] += f['size']
        package_stats[pkg][ext]["loc"] += loc
        package_stats[pkg][ext]["debt"] += debt
        package_stats[pkg][ext]["velocity"] += velocity
        package_stats[pkg][ext]["coupling"] += coupling

        # Update Language Stats
        if ext not in lang_stats:
            lang_stats[ext] = {"count": 0, "size": 0, "loc": 0, "debt": 0, "velocity": 0, "coupling": 0}
        lang_stats[ext]["count"] += 1
        lang_stats[ext]["size"] += f['size']
        lang_stats[ext]["loc"] += loc
        lang_stats[ext]["debt"] += debt
        lang_stats[ext]["velocity"] += velocity
        lang_stats[ext]["coupling"] += coupling

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
            "total_debt": total_debt,
            "debris_count": debris_count,
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
        f.write("# 🌌 PrimeCare: Global Platform Pulse (Hyper-Intelligence)\n\n")
        
        f.write("## 🚀 Maximum Vitality Metrics\n")
        f.write(f"- **Codebase Scale**: **{total_loc:,}** LOC across **{len(all_files)}** Files\n")
        f.write(f"- **Technical Debt**: **{total_debt}** Markers (TODO/FIXME/HACK)\n")
        f.write(f"- **Disk Debris**: **{debris_count}** Obsolete Files Flagged\n")
        f.write(f"- **Real-time Velocity**: {sum(f.get('velocity',0) for f in all_files)} Commits in 7 Days\n\n")

        f.write("## 🗺️ Sector Health Map (337 Hardened Intents)\n")
        f.write("A visual 2D grid representation of implemented vs unallocated intents.\n")
        f.write("```\n")
        # Generate a small 10x10 ASCII grid for status
        grid_size = 10
        total_mapped = len(hardened)
        for i in range(grid_size):
            row = ""
            for j in range(grid_size):
                if (i * grid_size + j) < total_mapped: row += "[■]" # Hardened
                else: row += "[ ]" # Empty
            f.write(row + "\n")
        f.write("```\n")
        f.write("> [■] = Hardened/Occupied Sector | [ ] = Unallocated Sector\n\n")

        f.write("## 🔥 Velocity Hotspots (Last 7 Days)\n")
        f.write("| Path | Updates | Size (KB) |\n| :--- | :--- | :--- |\n")
        # Sort files by velocity
        hot_files = sorted(all_files, key=lambda x: x.get('velocity', 0), reverse=True)[:10]
        for h in hot_files:
            if h.get('velocity', 0) > 0:
                f.write(f"| {h['path']} | {h['velocity']} | {h['size']/1024:.1f} |\n")

        f.write("\n## ⛓️ Architectural Coupling (Gravity)\n")
        f.write("| Package | Import Count | Total LOC | Debt Density |\n")
        f.write("| :--- | :--- | :--- | :--- |\n")
        sorted_pkgs = sorted(package_stats.items(), key=lambda x: sum(t['coupling'] for t in x[1].values()), reverse=True)
        for pkg, types in sorted_pkgs:
            p_loc = sum(t['loc'] for t in types.values())
            p_coupling = sum(t['coupling'] for t in types.values())
            p_debt = sum(t['debt'] for t in types.values())
            density = (p_debt / p_loc * 1000) if p_loc > 0 else 0
            f.write(f"| `{pkg}` | {p_coupling} | {p_loc:,} | {density:.1f} per kLOC |\n")

        f.write("\n## 📊 Language Intensity\n")
        f.write("| Ext | LOC | Size (KB) | Avg Velocity |\n")
        f.write("| :--- | :--- | :--- | :--- |\n")
        sorted_langs = sorted(lang_stats.items(), key=lambda x: x[1]['loc'], reverse=True)
        for ext, data in sorted_langs:
            v_avg = data['velocity'] / data['count'] if data['count'] > 0 else 0
            f.write(f"| `{ext}` | {data['loc']:,} | {data['size']/1024:.1f} | {v_avg:.2f} |\n")

    print(f"Global Pulse Generated: {total_debt} debt markers, {debris_count} debris files.")

if __name__ == "__main__":
    generate_advanced_report()
