import json
import os
import sqlite3
from pathlib import Path

DB_PATH = ".agents/governance/governance.db"
OUT_DIR = Path("cypress/fixtures/governance")
OUT_DIR.mkdir(parents=True, exist_ok=True)

conn = sqlite3.connect(DB_PATH)
conn.row_factory = sqlite3.Row
cur = conn.cursor()

def dump(name, query):
    rows = cur.execute(query).fetchall()
    OUT_DIR.joinpath(name).write_text(
        json.dumps([dict(r) for r in rows], indent=2),
        encoding="utf-8"
    )

dump("apps.json", "SELECT * FROM apps")
dump("roles.json", "SELECT * FROM roles")
dump("screens.json", "SELECT * FROM screens WHERE cypress_ready = 1")
dump("languages.json", "SELECT * FROM language_registry WHERE enabled = 1")
dump("api_endpoints.json", "SELECT * FROM api_endpoints")

# Query our migrated role app columns with test_password
roles = cur.execute("""
    SELECT role_code, test_email, test_password, primary_app_code, primary_app_url, auth_redirect_url, post_login_route
    FROM roles
""").fetchall()

users = []
for role in roles:
    email = role["test_email"] or f"qa.{role['role_code']}@test.primecare.local"
    password = role["test_password"] or "Test@12345"
    users.append({
        "role_code": role["role_code"],
        "email": email,
        "password": password,
        "app_code": role["primary_app_code"],
        "app_url": role["primary_app_url"],
        "redirect_url": role["auth_redirect_url"],
        "post_login_route": role["post_login_route"]
    })

OUT_DIR.joinpath("test_users.json").write_text(
    json.dumps(users, indent=2),
    encoding="utf-8"
)

# --- Generate E2E Role Auth redirection specs ---
SPEC_DIR = Path("cypress/e2e/01_auth")
SPEC_DIR.mkdir(parents=True, exist_ok=True)

# 1. Clean up old auto-generated auth specs
print("Cleaning up old Cypress spec files in cypress/e2e/01_auth/...")
for f in SPEC_DIR.glob("*.cy.js"):
    try:
        f.unlink()
    except Exception as e:
        print(f"  Warning: Could not delete old spec {f.name}: {e}")

# 2. Write new individual spec files for all 64 roles
print("Generating new dynamic role-app redirect specs...")
for u in users:
    role_code = u["role_code"]
    app_code = u["app_code"]
    
    spec_content = f"""// AUTO-GENERATED ROLE-APP REDIRECT SPEC. DO NOT EDIT.
// Generated from SQLite governance database.
// Dynamic targets: app = {app_code}, role = {role_code}

describe("Auth Redirect - {role_code}", () => {{
  it("performs dynamic SSO auth and verifies landing on {app_code} app shell", () => {{
    cy.loginAsRole("{role_code}");
  }});
}});
"""
    spec_filename = f"{app_code}_auth_redirect_{role_code}.cy.js"
    SPEC_DIR.joinpath(spec_filename).write_text(spec_content, encoding="utf-8")
    print(f"  Generated: {spec_filename}")

# 3. Generate master loop file as well for convenience
master_loop_content = """// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.

const users = require("../../fixtures/governance/test_users.json");

describe("Auth - Master Loop All Roles", () => {
  users.forEach((user) => {
    it(`verifies login for role: ${user.role_code}`, () => {
      // Use custom reusable command defined in cypress/support/commands.js
      cy.loginAsRole(user.role_code);
    });
  });
});
"""

SPEC_DIR.joinpath("auth_master_loop.cy.js").write_text(master_loop_content, encoding="utf-8")
print("  Generated: auth_master_loop.cy.js")

conn.close()
print("Generated Cypress governance fixtures and dynamic spec files.")
