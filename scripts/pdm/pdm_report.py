import json
import os

PROJECT_ROOT = "C:/Users/Admin2/Documents/GitHub/primecare-platform"
SNAPSHOT_PATH = os.path.join(PROJECT_ROOT, "pdm_snapshot.json")

def generate_report():
    if not os.path.exists(SNAPSHOT_PATH):
        print("Error: snapshot not found. Run pdm_engine.py first.")
        return

    with open(SNAPSHOT_PATH, 'r') as f:
        data = json.load(f)

    total = len(data)
    occupied = [r for r in data if r['status'] == 'OCCUPIED']
    empty = [r for r in data if r['status'] == 'EMPTY_BLOCK']
    missing = [r for r in data if r['status'] == 'UNALLOCATED']

    print("\n" + "="*50)
    print(" PRIMECARE VIRTUAL FILE TABLE (VFT) REPORT")
    print("="*50)
    
    print(f"\n[SYSTEM ALLOTMENT]")
    print(f"Total Blocks Allocated: {total}")
    print(f"Used Capacity:          {len(occupied)} blocks ({(len(occupied)/total)*100:.1f}%)")
    print(f"Free Capacity (Empty): {len(empty)} blocks")
    print(f"Bad Blocks (Missing):  {len(missing)} blocks")
    
    print(f"\n[TOPOGRAPHICAL MAP]")
    
    # Simple ASCII bar
    bar_width = 40
    occ_width = int((len(occupied)/total) * bar_width)
    empty_width = int((len(empty)/total) * bar_width)
    miss_width = bar_width - occ_width - empty_width
    
    bar = "[" + "#"*occ_width + "."*empty_width + "!"*miss_width + "]"
    print(bar)
    print("(# = Occupied, . = Empty, ! = Missing)")

    print(f"\n[RECENT ALLOTMENTS (Dashboards)]")
    dashboards = [r for r in data if r['is_dashboard']]
    for d in dashboards[:10]: # Show first 10
        status_char = "[X]" if d['status'] == 'OCCUPIED' else "[ ]"
        print(f"{status_char} {d['enumName']}")
    if len(dashboards) > 10:
        print(f"... and {len(dashboards)-10} more.")

    print("\n" + "="*50)

if __name__ == "__main__":
    generate_report()
