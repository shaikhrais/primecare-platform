import os

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
HTML_PATH = os.path.join(PROJECT_ROOT, "tools", "governance", "reports", "interactive_governance_dashboard.html")

def main():
    print("🚀 Patching Database Download Href in Dashboard UI...")
    
    if not os.path.exists(HTML_PATH):
        print("HTML file does not exist!")
        return

    with open(HTML_PATH, "r", encoding="utf-8") as f:
        content = f.read()

    # Replace /governance.db download href to be ZIP
    old_download_href = 'href="/governance.db" download="governance.db" class="proof-btn"'
    new_download_href = 'href="/governance.db.zip" download="governance.db.zip" class="proof-btn"'
    
    old_btn_text = "📥 Download SQLite DB"
    new_btn_text = "📥 Download SQLite DB (ZIP)"

    if old_download_href in content:
        content = content.replace(old_download_href, new_download_href)
        content = content.replace(old_btn_text, new_btn_text)
        with open(HTML_PATH, "w", encoding="utf-8") as f:
            f.write(content)
        print("  ✓ Successfully updated the SQLite download link to ZIP in HTML.")
    else:
        print("  [WARN] Could not find the uncompressed download button in HTML!")

if __name__ == '__main__':
    main()
