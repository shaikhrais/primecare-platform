import sqlite3
import json

db_path = ".agents/governance/governance.db"
fixture_path = "cypress/fixtures/governance/test_users.json"
new_url = "https://49a64f6d.primecare-clinic.pages.dev"
new_redirect_url = "https://49a64f6d.primecare-clinic.pages.dev/auth/callback"

print(f"Updating chiropractor URLs in database: {db_path}")
conn = sqlite3.connect(db_path)
cursor = conn.cursor()
cursor.execute("""
    UPDATE roles
    SET primary_app_url = ?,
        auth_redirect_url = ?
    WHERE role_code = 'chiropractor';
""", (new_url, new_redirect_url))
conn.commit()
conn.close()
print("Database updated successfully!")

print(f"Updating chiropractor URLs in Cypress fixture: {fixture_path}")
with open(fixture_path, "r", encoding="utf-8") as f:
    users = json.load(f)

for user in users:
    if user["role_code"] == "chiropractor":
        user["app_url"] = new_url
        user["redirect_url"] = new_redirect_url
        print(f"Matched and updated chiropractor fixture: {user}")
        break

with open(fixture_path, "w", encoding="utf-8") as f:
    json.dump(users, f, indent=2)
print("Cypress fixture updated successfully!")
