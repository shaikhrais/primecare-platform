import sqlite3
import os
import sys
import subprocess

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")
DATABASE_NAME = "primecare-governance-db"

def run_command(cmd):
    result = subprocess.run(cmd, capture_output=True, text=True, encoding="utf-8", errors="ignore", shell=True)
    return result

def main():
    if len(sys.argv) < 3:
        print("Usage: python tools/governance/feedback.py <screen_code> \"<your feedback>\" [status]")
        print("Example: python tools/governance/feedback.py psw_workflow \"Layout needs visual alignment\" review_required")
        sys.exit(1)

    screen_code = sys.argv[1].strip()
    remark = sys.argv[2].strip()
    status = sys.argv[3].strip() if len(sys.argv) > 3 else "review_required"

    if not os.path.exists(DB_PATH):
        print(f"[ERROR] Database not found locally: {DB_PATH}")
        sys.exit(1)

    # 1. Update Local SQLite database
    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()
    
    # Search check
    cursor.execute("SELECT screen_name FROM screens WHERE LOWER(REPLACE(screen_code, '_', '')) = LOWER(REPLACE(?, '_', ''))", (screen_code,))
    row = cursor.fetchone()
    if not row:
        print(f"[ERROR] Screen '{screen_code}' not found.")
        conn.close()
        sys.exit(1)
        
    screen_name = row[0]
    
    cursor.execute("""
        UPDATE screens 
        SET user_remarks = ?, user_remark_status = ? 
        WHERE LOWER(REPLACE(screen_code, '_', '')) = LOWER(REPLACE(?, '_', ''))
    """, (remark, status, screen_code))
    conn.commit()
    conn.close()
    
    print(f"✨ Local update successful for '{screen_name}' ({screen_code})!")

    # 2. Push immediately to Cloudflare D1 with a single command
    escaped_remark = remark.replace("'", "''")
    escaped_status = status.replace("'", "''")
    
    print("⚡ Syncing feedback to Cloudflare D1 edge database...")
    cmd = f'npx wrangler d1 execute {DATABASE_NAME} --command="UPDATE screens SET user_remarks = \'{escaped_remark}\', user_remark_status = \'{escaped_status}\' WHERE LOWER(REPLACE(screen_code, \'_\', \'\')) = LOWER(REPLACE(\'{screen_code}\', \'_\', \'\'))" --remote'
    
    res = run_command(cmd)
    if res.returncode == 0:
        print("🚀 Successfully synced feedback to Cloudflare D1!")
    else:
        print("[WARN] Cloudflare D1 sync failed. It will sync on next batch run.")
        print(res.stderr)

if __name__ == "__main__":
    main()
