import sqlite3
import os
import re

PROJECT_ROOT = r"c:\Users\Admin2\Documents\GitHub\primecare-platform"
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def normalize_url(url):
    if not url:
        return url
    # Regex to catch any domain with subdomains like https://hash.primecare-xxx.pages.dev
    # and strip the hash subdomain prefix.
    match = re.search(r"https://[a-zA-Z0-9-]+\.(primecare-[a-zA-Z0-9-]+)\.pages\.dev", url)
    if match:
        clean_project = match.group(1)
        # Reconstruct without the subdomain hash prefix, preserving path/query if any
        url_normalized = url.replace(match.group(0), f"https://{clean_project}.pages.dev")
        return url_normalized
    return url

def main():
    if not os.path.exists(DB_PATH):
        print(f"Database not found at {DB_PATH}")
        return

    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    cur = conn.cursor()

    roles = cur.execute("SELECT id, role_code, primary_app_url, auth_redirect_url FROM roles;").fetchall()
    
    print("=== Cleaning SQLite Subdomains ===")
    updated_count = 0
    for r in roles:
        role_id = r["id"]
        role_code = r["role_code"]
        old_url = r["primary_app_url"]
        old_redirect = r["auth_redirect_url"]
        
        new_url = normalize_url(old_url)
        new_redirect = normalize_url(old_redirect)
        
        if old_url != new_url or old_redirect != new_redirect:
            print(f"Role: {role_code}")
            print(f"  URL: {old_url} -> {new_url}")
            print(f"  Redirect: {old_redirect} -> {new_redirect}")
            cur.execute("""
                UPDATE roles
                SET primary_app_url = ?,
                    auth_redirect_url = ?
                WHERE id = ?;
            """, (new_url, new_redirect, role_id))
            updated_count += 1

    conn.commit()
    conn.close()
    print(f"\nCleanup complete! Standardized {updated_count} roles to clean public domains.")

if __name__ == '__main__':
    main()
