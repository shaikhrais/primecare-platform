import json
import os

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
REPORT_PATH = os.path.join(PROJECT_ROOT, "tools", "governance", "reports", "screen_kpi_report.json")

def main():
    print("==============================================================")
    print("📊 PLATFORM-WIDE STATIC QUALITY METRICS SUMMARY")
    print("==============================================================")

    if not os.path.exists(REPORT_PATH):
        print(f"[ERROR] KPI report not found at '{REPORT_PATH}'")
        return

    with open(REPORT_PATH, "r", encoding="utf-8") as f:
        data = json.load(f)

    total_screens = len(data)
    total_loc = sum(x["loc"] for x in data)
    avg_complexity = sum(x["complexity"] for x in data) / total_screens
    avg_maintainability = sum(x["maintainability"] for x in data) / total_screens
    
    # Sort screens by complexity
    sorted_by_complexity = sorted(data, key=lambda x: x["complexity"], reverse=True)

    print(f"📈 Total Screens Analyzed : {total_screens}")
    print(f"💻 Total Lines of Code (LOC) : {total_loc:,} lines")
    print(f"🌀 Average Complexity Score : {avg_complexity:.2f} (lower is better)")
    print(f"🛡️  Average Maintainability  : {avg_maintainability:.2f}% (higher is better)")
    print("-" * 62)
    print("🏆 TOP 5 HIGH-COMPLEXITY SCREENS IN THE PLATFORM:")
    print("-" * 62)
    
    for i, s in enumerate(sorted_by_complexity[:5], 1):
        print(f"  {i}. {s['screen_name']} (ID: {s['screen_id']})")
        print(f"     Complexity: {s['complexity']} | LOC: {s['loc']} | Maintainability: {s['maintainability']}%")
        print("-" * 62)

if __name__ == '__main__':
    main()
