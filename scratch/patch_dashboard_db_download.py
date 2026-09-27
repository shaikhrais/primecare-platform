import os
import shutil

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
HTML_PATH = os.path.join(PROJECT_ROOT, "tools", "governance", "reports", "interactive_governance_dashboard.html")
DB_SOURCE = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")
DB_DEST = os.path.join(PROJECT_ROOT, "apps", "primecare_governance", "web", "governance.db")

def main():
    print("🚀 Patching Database Download Button onto Dashboard UI...")
    
    if not os.path.exists(HTML_PATH):
        print("HTML file does not exist!")
        return

    with open(HTML_PATH, "r", encoding="utf-8") as f:
        content = f.read()

    # 1. Patch header to add 'Download SQLite DB' button
    old_button_placement = """            <button class="proof-btn" style="border-color: var(--neon-amber); color: var(--neon-amber); font-weight: 700; font-size:12px; padding: 8px 16px;" onclick="exportReviewPatch()">📥 Export Review Patch</button>"""
    
    new_button_placement = """            <a href="/governance.db" download="governance.db" class="proof-btn" style="border-color: var(--neon-green); color: var(--neon-green); font-weight: 700; font-size:12px; padding: 8px 16px; text-decoration: none; display: inline-flex; align-items: center; gap: 6px;">📥 Download SQLite DB</a>
            <button class="proof-btn" style="border-color: var(--neon-amber); color: var(--neon-amber); font-weight: 700; font-size:12px; padding: 8px 16px;" onclick="exportReviewPatch()">📥 Export Review Patch</button>"""

    if old_button_placement in content:
        content = content.replace(old_button_placement, new_button_placement)
        with open(HTML_PATH, "w", encoding="utf-8") as f:
            f.write(content)
        print("  ✓ Successfully added the 'Download SQLite DB' link to HTML.")
    else:
        print("  [WARN] Could not find the button placement target in HTML!")

    # 2. Copy the actual governance.db SQLite file to the web directory
    print(f"📋 Copying SQLite database to web folder...")
    print(f"  Source: {DB_SOURCE}")
    print(f"  Destination: {DB_DEST}")
    
    try:
        shutil.copy2(DB_SOURCE, DB_DEST)
        print("  ✓ Database successfully copied to the Governance Web App directory!")
    except Exception as e:
        print(f"  [ERROR] Failed to copy database file: {e}")

if __name__ == '__main__':
    main()
