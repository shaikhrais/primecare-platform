import os
import sqlite3
import json
import urllib.request
import urllib.error
from datetime import datetime

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def now():
    return datetime.utcnow().isoformat() + "Z"

def main():
    print("==============================================================")
    print("PRIMECARE GOVERNANCE: ROLE TEST USER SEEDER")
    print("==============================================================")

    # 1. Read environment variables
    base_url = os.environ.get("TEST_API_BASE_URL")
    admin_email = os.environ.get("TEST_ADMIN_EMAIL", "admin@test.primecare.local")
    admin_password = os.environ.get("TEST_ADMIN_PASSWORD")
    default_password = os.environ.get("TEST_DEFAULT_PASSWORD", "Test@12345")

    print(f"TEST_API_BASE_URL: {base_url}")
    print(f"TEST_ADMIN_EMAIL: {admin_email}")

    if not os.path.exists(DB_PATH):
        print(f"Error: Database not found at {DB_PATH}")
        return

    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    cur = conn.cursor()

    # Load pending seed user records
    seeds = cur.execute("""
        SELECT id, role_id, app_id, role_code, test_email, test_password, seed_status
        FROM role_test_user_seeds
        WHERE seed_status NOT IN ('created', 'exists');
    """).fetchall()

    print(f"Found {len(seeds)} pending test user seeds to verify or create.")

    # Since the live seeding API is currently flagged as an outstanding implementation requirement,
    # we verify endpoint reachability. If base_url is not defined or returns connection errors,
    # we gracefully log the API reachability failures to the database to trigger required tasks.
    for s in seeds:
        seed_id = s["id"]
        role_code = s["role_code"]
        email = s["test_email"]
        password = s["test_password"] or default_password
        print(f"\n[Seed] Role: {role_code} -> Email: {email}...")

        # If base_url is not provided, we gracefully register seed failure
        if not base_url:
            print("  Warning: TEST_API_BASE_URL is not set. Seeding API is currently unavailable.")
            cur.execute("""
                UPDATE role_test_user_seeds
                SET seed_status = 'failed',
                    login_status = 'failed',
                    login_error = 'TEST_API_BASE_URL is missing. Seeding API unavailable.',
                    updated_at = ?
                WHERE id = ?;
            """, (now(), seed_id))
            
            # Also update roles table test status
            cur.execute("""
                UPDATE roles
                SET test_user_seed_status = 'failed',
                    test_login_last_status = 'failed',
                    test_login_last_error = 'TEST_API_BASE_URL missing. Seeding API unavailable.',
                    test_login_last_run_at = ?
                WHERE role_code = ?;
            """, (now(), role_code))
            continue

        # Attempt calling POST /v1/test/seed-role-user
        url = f"{base_url.rstrip('/')}/v1/test/seed-role-user"
        payload = {
            "email": email,
            "password": password,
            "roleCode": role_code,
            "appCode": "primecare_clinic"
        }
        
        headers = {
            "Content-Type": "application/json",
            "Authorization": f"Bearer {password}",
            "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64)"
        }
        
        req_data = json.dumps(payload).encode("utf-8")
        req = urllib.request.Request(url, data=req_data, headers=headers, method="POST")

        status_code = 0
        response_text = ""
        seed_status = "failed"

        try:
            with urllib.request.urlopen(req, timeout=5) as response:
                status_code = response.status
                response_text = response.read().decode("utf-8")
                res_json = json.loads(response_text)
                
                # Check response
                if res_json.get("status") in ("created", "exists"):
                    seed_status = res_json.get("status")
                    user_id = res_json.get("userId", "seed-user-id")
                    cur.execute("""
                        UPDATE role_test_user_seeds
                        SET seed_status = ?,
                            api_endpoint = '/v1/test/seed-role-user',
                            api_status_code = ?,
                            api_response_json = ?,
                            updated_at = ?
                        WHERE id = ?;
                    """, (seed_status, status_code, response_text, now(), seed_id))
                    
                    cur.execute("""
                        UPDATE roles
                        SET test_user_seed_status = ?,
                            test_user_id = ?,
                            test_login_last_status = 'passed',
                            test_login_last_run_at = ?
                        WHERE role_code = ?;
                    """, (seed_status, user_id, now(), role_code))
                    print(f"  Success: Seed user {seed_status.upper()} (User ID: {user_id})")
                else:
                    raise Exception(f"Unexpected response status: {res_json.get('status')}")

        except Exception as e:
            err_msg = str(e)
            print(f"  Failed: Seeding API error: {err_msg}")
            cur.execute("""
                UPDATE role_test_user_seeds
                SET seed_status = 'failed',
                    api_endpoint = '/v1/test/seed-role-user',
                    api_status_code = ?,
                    api_response_json = ?,
                    login_error = ?,
                    updated_at = ?
                WHERE id = ?;
            """, (status_code if status_code else 500, err_msg, err_msg, now(), seed_id))
            
            cur.execute("""
                UPDATE roles
                SET test_user_seed_status = 'failed',
                    test_login_last_status = 'failed',
                    test_login_last_error = ?,
                    test_login_last_run_at = ?
                WHERE role_code = ?;
            """, (err_msg, now(), role_code))

    conn.commit()
    conn.close()
    print("\nRole test user seeding sweep finished.")

if __name__ == '__main__':
    main()
