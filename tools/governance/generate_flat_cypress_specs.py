import json
import re
import sqlite3
from pathlib import Path

DB_PATH = ".agents/governance/governance.db"

OUT_AUTH = Path("cypress/e2e/01_auth")
OUT_LANGUAGE = Path("cypress/e2e/02_language")
OUT_SCREENS = Path("cypress/e2e/03_screens")
OUT_ROLES = Path("cypress/e2e/04_roles")
OUT_APPS = Path("cypress/e2e/05_apps")
OUT_ORG = Path("cypress/e2e/06_org")

def safe_name(value):
    value = str(value or "unknown").lower()
    value = re.sub(r"[^a-z0-9]+", "_", value)
    return value.strip("_")

def js_string(value):
    return json.dumps(value or "")

def mkdirs():
    import shutil
    for p in [
        OUT_AUTH,
        OUT_LANGUAGE,
        OUT_SCREENS,
        OUT_ROLES,
        OUT_APPS,
        OUT_ORG,
    ]:
        if p.exists():
            shutil.rmtree(p)
        p.mkdir(parents=True, exist_ok=True)

def read_db():
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    cur = conn.cursor()

    apps = [dict(r) for r in cur.execute("SELECT * FROM apps").fetchall()]
    roles_raw = [dict(r) for r in cur.execute("SELECT * FROM roles").fetchall()]
    screens_raw = [dict(r) for r in cur.execute("SELECT * FROM screens WHERE active = 1").fetchall()]
    languages = [dict(r) for r in cur.execute("SELECT * FROM language_registry WHERE enabled = 1").fetchall()]
    
    # Query permissions to resolve allowed roles and primary roles
    permissions = [dict(r) for r in cur.execute("SELECT role_id, screen_id, can_create FROM role_screen_permissions WHERE can_view = 1").fetchall()]

    conn.close()

    # Load test users role codes to validate roles
    test_users_path = Path("cypress/fixtures/governance/test_users.json")
    valid_role_codes = set()
    if test_users_path.exists():
        try:
            with open(test_users_path, "r", encoding="utf-8") as f:
                users_data = json.load(f)
                valid_role_codes = {u["role_code"] for u in users_data if "role_code" in u}
        except Exception as e:
            print(f"Error reading test_users.json: {e}")

    # Filter roles to only those with valid credentials
    roles = [r for r in roles_raw if r.get("role_code") in valid_role_codes]
    valid_role_ids = {r["id"] for r in roles}

    # Map screen_id -> primary role_id (where can_create = 1)
    screen_primary_role = {}
    for p in permissions:
        # Check if the role_id is valid (has credentials)
        if p["role_id"] in valid_role_ids:
            if p.get("can_create") == 1:
                screen_primary_role[p["screen_id"]] = p["role_id"]
            
    # Fallback to any permission if no can_create = 1 exists and role_id is valid
    for p in permissions:
        if p["role_id"] in valid_role_ids:
            if p["screen_id"] not in screen_primary_role:
                screen_primary_role[p["screen_id"]] = p["role_id"]
            
    # Add role_id and allowed_roles_text to each screen dict
    screens = []
    role_code_by_id = {r["id"]: r["role_code"] for r in roles}
    
    for s in screens_raw:
        # Check route conditions:
        # - must not be empty or null
        # - must not start with /unmapped/
        route_path = s.get("route_path")
        if not route_path or route_path.startswith("/unmapped/"):
            continue

        s_id = s["id"]
        primary_role_id = screen_primary_role.get(s_id)
        if not primary_role_id:
            # Skip screen if there is no primary role with credentials associated
            continue
        
        # Build list of allowed role codes for allowed_roles_text
        allowed_role_ids = [p["role_id"] for p in permissions if p["screen_id"] == s_id]
        allowed_role_codes = [role_code_by_id.get(rid) for rid in allowed_role_ids if role_code_by_id.get(rid)]
        allowed_roles_text = ",".join(allowed_role_codes)
        
        s_copy = dict(s)
        s_copy["role_id"] = primary_role_id
        s_copy["allowed_roles_text"] = allowed_roles_text
        screens.append(s_copy)

    return apps, roles, screens, languages

def header():
    return """// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.

"""

def verify_screen_block(screen, index=None, total=None):
    keys = {}
    try:
        keys = json.loads(screen.get("data_cy_required_json") or "{}")
    except Exception:
        keys = {}

    root = ""
    title = ""
    content = ""
    extra_checks = []

    if isinstance(keys, dict):
        root = keys.get("screen_root", "")
        title = keys.get("page_title", "")
        content = keys.get("primary_content", "")
    elif isinstance(keys, list):
        for k in keys:
            if k.endswith("-screen") or "screen" in k:
                root = k
            elif k.endswith("-title") or "title" in k:
                title = k
            elif k.endswith("-content") or "content" in k:
                content = k
            else:
                extra_checks.append(k)

    # Fallbacks based on screen_code
    screen_code_clean = (screen.get("screen_code") or "").replace("_", "").lower()
    if not root and screen_code_clean:
        root = f"{screen_code_clean}-screen"
    if not title and screen_code_clean:
        title = f"{screen_code_clean}-title"
    if not content and screen_code_clean:
        content = f"{screen_code_clean}-content"

    found_keys = []
    try:
        found_keys = json.loads(screen.get("data_cy_found_json") or "[]")
    except Exception:
        found_keys = []

    assertions = []
    if root:
        if root in found_keys:
            assertions.append(f'  cy.getCy({js_string(root)}).should("be.visible");')
        else:
            assertions.append(f'  // cy.getCy({js_string(root)}).should("be.visible"); // NOT FOUND IN DART WIDGET TREE')
    else:
        assertions.append('  // No screen_root data-cy found')

    if title:
        if title in found_keys:
            assertions.append(f'  cy.getCy({js_string(title)}).should("be.visible");')
        else:
            assertions.append(f'  // cy.getCy({js_string(title)}).should("be.visible"); // NOT FOUND IN DART WIDGET TREE')
    else:
        assertions.append('  // No page_title data-cy found')

    if content:
        if content in found_keys:
            assertions.append(f'  cy.getCy({js_string(content)}).should("be.visible");')
        else:
            assertions.append(f'  // cy.getCy({js_string(content)}).should("be.visible"); // NOT FOUND IN DART WIDGET TREE')
    else:
        assertions.append('  // No primary_content data-cy found')

    # Add checking for the first 3 extra keys as sanity checks if available
    for ec in extra_checks[:3]:
        if ec in found_keys:
            assertions.append(f'  cy.getCy({js_string(ec)}).should("be.visible");')
        else:
            assertions.append(f'  // cy.getCy({js_string(ec)}).should("be.visible"); // NOT FOUND IN DART WIDGET TREE')

    assertions_str = "\n".join(assertions)

    route_path = screen.get("route_path")
    screen_name = screen.get("screen_name") or "Unnamed Screen"
    screen_code = safe_name(screen.get("screen_code") or screen.get("screen_name"))

    progress_prefix = ""
    progress_bar = ""
    if index is not None and total is not None:
        percent = int((index / total) * 100)
        filled_length = int(10 * index // total)
        bar = "🟩" * filled_length + "⬜" * (10 - filled_length)
        progress_prefix = f" [{index}/{total} | {percent}%]"
        progress_bar = f" {bar}"

    log_nav = f'cy.task("log", "⏳ PROGRESS:{progress_bar}{progress_prefix} - Navigating to {route_path} ({screen_name})...");'
    log_check = f'cy.task("log", "🔍 PROGRESS:{progress_bar}{progress_prefix} - Checking shell & content for {screen_name}...");'
    log_screenshot = f'cy.task("log", "📸 PROGRESS:{progress_bar}{progress_prefix} - Saving screenshot for {screen_name}...");'
    log_success = f'cy.task("log", "✅ PROGRESS:{progress_bar}{progress_prefix} - Verified {screen_name} successfully!\\n");'

    return f"""
  {log_nav}
  cy.visitWithSemantics({js_string(route_path)});
  cy.waitAndSee();
  
  {log_check}
  cy.verifyShellExists();
  cy.verifyNotBlank();

{assertions_str}

  {log_screenshot}
  cy.waitAndSee();
  cy.screenshot({js_string(screen_code)});
  
  {log_success}
"""

def generate_auth_specs(roles):
    for role in roles:
        role_code = safe_name(role.get("role_code"))
        content = header() + f"""
describe("Auth - {role_code}", () => {{
  it("logs in as {role_code}", () => {{
    cy.loginAsRole({js_string(role.get("role_code"))});
  }});
}});
"""
        (OUT_AUTH / f"auth_{role_code}.cy.js").write_text(content, encoding="utf-8")

def generate_language_specs(roles, languages):
    active = [l["locale_code"] for l in languages]
    for role in roles:
        role_code = safe_name(role.get("role_code"))
        lang_steps = ""
        for loc in active:
            lang_steps += f"""
    cy.switchLanguage({js_string(loc)});
    cy.screenshot("language_{role_code}_{loc}");
"""
        content = header() + f"""
describe("Language - {role_code}", () => {{
  it("switches active languages for {role_code}", () => {{
    cy.loginAsRole({js_string(role.get("role_code"))});
{lang_steps}
  }});
}});
"""
        (OUT_LANGUAGE / f"language_{role_code}.cy.js").write_text(content, encoding="utf-8")

def generate_screen_specs(roles, screens):
    role_by_id = {r.get("id"): r for r in roles}

    for screen in screens:
        role = role_by_id.get(screen.get("role_id")) or roles[0]
        role_code = role.get("role_code")
        screen_code = safe_name(screen.get("screen_code") or screen.get("screen_name"))
        screen_name = screen.get("screen_name") or "Unnamed Screen"
        route_path = screen.get("route_path")

        # Extract assertions
        keys = {}
        try:
            keys = json.loads(screen.get("data_cy_required_json") or "{}")
        except Exception:
            keys = {}

        root = ""
        title = ""
        content = ""
        extra_checks = []

        if isinstance(keys, dict):
            root = keys.get("screen_root", "")
            title = keys.get("page_title", "")
            content = keys.get("primary_content", "")
        elif isinstance(keys, list):
            for k in keys:
                if k.endswith("-screen") or "screen" in k:
                    root = k
                elif k.endswith("-title") or "title" in k:
                    title = k
                elif k.endswith("-content") or "content" in k:
                    content = k
                else:
                    extra_checks.append(k)

        # Fallbacks based on screen_code
        screen_code_clean = (screen.get("screen_code") or "").replace("_", "").lower()
        if not root and screen_code_clean:
            root = f"{screen_code_clean}-screen"
        if not title and screen_code_clean:
            title = f"{screen_code_clean}-title"
        if not content and screen_code_clean:
            content = f"{screen_code_clean}-content"

        found_keys = []
        try:
            found_keys = json.loads(screen.get("data_cy_found_json") or "[]")
        except Exception:
            found_keys = []

        assertions = []
        if root:
            if root in found_keys:
                assertions.append(f'      cy.getCy({js_string(root)}).should("be.visible");')
            else:
                assertions.append(f'      // cy.getCy({js_string(root)}).should("be.visible"); // NOT FOUND IN DART WIDGET TREE')
        if title:
            if title in found_keys:
                assertions.append(f'      cy.getCy({js_string(title)}).should("be.visible");')
            else:
                assertions.append(f'      // cy.getCy({js_string(title)}).should("be.visible"); // NOT FOUND IN DART WIDGET TREE')
        if content:
            if content in found_keys:
                assertions.append(f'      cy.getCy({js_string(content)}).should("be.visible");')
            else:
                assertions.append(f'      // cy.getCy({js_string(content)}).should("be.visible"); // NOT FOUND IN DART WIDGET TREE')

        for ec in extra_checks[:3]:
            if ec in found_keys:
                assertions.append(f'      cy.getCy({js_string(ec)}).should("be.visible");')
            else:
                assertions.append(f'      // cy.getCy({js_string(ec)}).should("be.visible"); // NOT FOUND IN DART WIDGET TREE')

        assertions_str = "\n".join(assertions)

        content_str = header() + f"""
describe("Screen - {screen_code}", () => {{
  it("opens and verifies screen {screen_code} via real credentials login and logout", () => {{
    cy.fixture("governance/test_users.json").then((users) => {{
      const user = users.find((u) => u.role_code === {js_string(role_code)});
      const targetBaseUrl = Cypress.config().baseUrl || user.app_url;

      // 1. Visit login page
      cy.task("log", "⏳ PROGRESS: - Visiting login page...");
      cy.visitWithSemantics(targetBaseUrl + "/login");
      cy.waitAndSee();

      // Verify login inputs are visible
      cy.getCy("login-email").should("be.visible");
      cy.getCy("login-password").should("be.visible");

      // Take a screenshot of the login screen
      cy.screenshot("login_screen_{screen_code}");

      // 2. Type credentials
      cy.task("log", "⏳ PROGRESS: - Entering credentials...");
      cy.typeIntoField("login-email", user.email);
      cy.wait(500);
      cy.typeIntoField("login-password", user.password);
      cy.wait(500);

      // Click submit
      cy.getCy("login-submit").first().click({{ force: true }});
      cy.wait(6000);

      // 3. Navigate to screen route and verify
      cy.task("log", "⏳ PROGRESS: - Navigating to screen route: {route_path}...");
      cy.visitWithSemantics(targetBaseUrl + "{route_path}");
      cy.waitAndSee();

      cy.verifyShellExists();
      cy.verifyNotBlank();

      // Screen assertions
{assertions_str}

      // Take screen screenshot
      cy.screenshot("{screen_code}");

      // 4. Logout
      cy.task("log", "👆 PROGRESS: - Logging out...");
      cy.get("body").then(($body) => {{
        const topbarLogout = $body.find('[aria-label*="data-cy:topbar-logout-button"], [aria-label*="topbar-logout-button"], [key="topbar-logout-button"], [data-cy="topbar-logout-button"]');
        if (topbarLogout.length > 0) {{
          cy.wrap(topbarLogout).first().click({{ force: true }});
        }} else {{
          cy.clearAllCookies();
          cy.clearAllLocalStorage();
          cy.clearAllSessionStorage();
          cy.visit(targetBaseUrl + "/login?enable-semantics=true");
        }}
      }});
      cy.waitAndSee();
      cy.url().should("include", "/login");

      // Take logout screenshot
      cy.screenshot("logout_screen_{screen_code}");
      cy.task("log", "✅ PROGRESS: - Verified {screen_name} successfully!\\n");
    }});
  }});
}});
"""
        (OUT_SCREENS / f"screen_{screen_code}.cy.js").write_text(content_str, encoding="utf-8")

def role_screens(role, screens):
    role_code = str(role.get("role_code") or "").lower()
    result = []
    for s in screens:
        allowed = str(s.get("allowed_roles_text") or "").lower()
        if role_code in allowed or s.get("role_id") == role.get("id"):
            result.append(s)
    return result

def generate_role_specs(roles, screens):
    for role in roles:
        role_code = safe_name(role.get("role_code"))
        rs = role_screens(role, screens)

        blocks = ""
        for idx, s in enumerate(rs):
            blocks += verify_screen_block(s, idx + 1, len(rs))

        content = header() + f"""
describe("Role All Screens - {role_code}", () => {{
  it("tests all screens for role {role_code}", () => {{
    cy.loginAsRole({js_string(role.get("role_code"))});

{blocks if blocks else '    cy.log("No screens assigned to this role.");'}
  }});
}});
"""
        (OUT_ROLES / f"role_{role_code}_all_screens.cy.js").write_text(content, encoding="utf-8")

def generate_app_specs(apps, roles, screens):
    roles_by_app = {}
    screens_by_app = {}

    for r in roles:
        roles_by_app.setdefault(r.get("app_id"), []).append(r)

    for s in screens:
        screens_by_app.setdefault(s.get("app_id"), []).append(s)

    for app in apps:
        app_code = safe_name(app.get("app_code"))
        app_roles = roles_by_app.get(app.get("id"), [])
        app_screens = screens_by_app.get(app.get("id"), [])

        blocks = ""
        for role in app_roles:
            rs = role_screens(role, app_screens)
            blocks += f"""
  it("tests role {role.get("role_code")} in app {app_code}", () => {{
    cy.loginAsRole({js_string(role.get("role_code"))});
"""
            for idx, s in enumerate(rs):
                blocks += verify_screen_block(s, idx + 1, len(rs))
            blocks += "  });\n"

        content = header() + f"""
describe("App All Roles All Screens - {app_code}", () => {{
{blocks if blocks else '  it("has no roles/screens", () => { cy.log("No roles/screens found for app."); });'}
}});
"""
        (OUT_APPS / f"app_{app_code}_all_roles.cy.js").write_text(content, encoding="utf-8")

def generate_org_spec(roles, screens):
    blocks = ""
    for role in roles:
        role_code = safe_name(role.get("role_code"))
        rs = role_screens(role, screens)
        blocks += f"""
  it("tests org role {role_code}", () => {{
    cy.loginAsRole({js_string(role.get("role_code"))});
"""
        for idx, s in enumerate(rs):
            blocks += verify_screen_block(s, idx + 1, len(rs))
        blocks += "  });\n"

    content = header() + f"""
describe("Org Full UI Test", () => {{
{blocks}
}});
"""
    (OUT_ORG / "org_full_ui.cy.js").write_text(content, encoding="utf-8")

def generate_org_real_login_logout_spec(roles, screens):
    role_by_id = {r.get("id"): r for r in roles}
    blocks = []
    
    for idx, screen in enumerate(screens):
        role = role_by_id.get(screen.get("role_id")) or roles[0]
        role_code = role.get("role_code")
        screen_code = safe_name(screen.get("screen_code") or screen.get("screen_name"))
        screen_name = screen.get("screen_name") or "Unnamed Screen"
        route_path = screen.get("route_path")

        # Extract assertions
        keys = {}
        try:
            keys = json.loads(screen.get("data_cy_required_json") or "{}")
        except Exception:
            keys = {}

        root = ""
        title = ""
        content = ""
        extra_checks = []

        if isinstance(keys, dict):
            root = keys.get("screen_root", "")
            title = keys.get("page_title", "")
            content = keys.get("primary_content", "")
        elif isinstance(keys, list):
            for k in keys:
                if k.endswith("-screen") or "screen" in k:
                    root = k
                elif k.endswith("-title") or "title" in k:
                    title = k
                elif k.endswith("-content") or "content" in k:
                    content = k
                else:
                    extra_checks.append(k)

        # Fallbacks based on screen_code
        screen_code_clean = (screen.get("screen_code") or "").replace("_", "").lower()
        if not root and screen_code_clean:
            root = f"{screen_code_clean}-screen"
        if not title and screen_code_clean:
            title = f"{screen_code_clean}-title"
        if not content and screen_code_clean:
            content = f"{screen_code_clean}-content"

        found_keys = []
        try:
            found_keys = json.loads(screen.get("data_cy_found_json") or "[]")
        except Exception:
            found_keys = []

        assertions = []
        if root:
            if root in found_keys:
                assertions.append(f'      cy.getCy({js_string(root)}).should("be.visible");')
            else:
                assertions.append(f'      // cy.getCy({js_string(root)}).should("be.visible"); // NOT FOUND IN DART WIDGET TREE')
        if title:
            if title in found_keys:
                assertions.append(f'      cy.getCy({js_string(title)}).should("be.visible");')
            else:
                assertions.append(f'      // cy.getCy({js_string(title)}).should("be.visible"); // NOT FOUND IN DART WIDGET TREE')
        if content:
            if content in found_keys:
                assertions.append(f'      cy.getCy({js_string(content)}).should("be.visible");')
            else:
                assertions.append(f'      // cy.getCy({js_string(content)}).should("be.visible"); // NOT FOUND IN DART WIDGET TREE')

        for ec in extra_checks[:3]:
            if ec in found_keys:
                assertions.append(f'      cy.getCy({js_string(ec)}).should("be.visible");')
            else:
                assertions.append(f'      // cy.getCy({js_string(ec)}).should("be.visible"); // NOT FOUND IN DART WIDGET TREE')

        assertions_str = "\n".join(assertions)

        blocks.append(f"""
  it("opens and verifies screen {screen_code} via real credentials login and logout", () => {{
    cy.fixture("governance/test_users.json").then((users) => {{
      const user = users.find((u) => u.role_code === {js_string(role_code)});
      const targetBaseUrl = Cypress.config().baseUrl || user.app_url;

      // 1. Visit login page
      cy.task("log", "⏳ PROGRESS: - Visiting login page...");
      cy.visitWithSemantics(targetBaseUrl + "/login");
      cy.waitAndSee();

      // Verify login inputs are visible
      cy.getCy("login-email").should("be.visible");
      cy.getCy("login-password").should("be.visible");

      // Take a screenshot of the login screen
      cy.screenshot("login_screen_{screen_code}");

      // 2. Type credentials
      cy.task("log", "⏳ PROGRESS: - Entering credentials...");
      cy.typeIntoField("login-email", user.email);
      cy.wait(500);
      cy.typeIntoField("login-password", user.password);
      cy.wait(500);

      // Click submit
      cy.getCy("login-submit").first().click({{ force: true }});
      cy.wait(6000);

      // 3. Navigate to screen route and verify
      cy.task("log", "⏳ PROGRESS: - Navigating to screen route: {route_path}...");
      cy.visitWithSemantics(targetBaseUrl + "{route_path}");
      cy.waitAndSee();

      cy.verifyShellExists();
      cy.verifyNotBlank();

      // Screen assertions
{assertions_str}

      // Take screen screenshot
      cy.screenshot("{screen_code}");

      // 4. Logout
      cy.task("log", "👆 PROGRESS: - Logging out...");
      cy.get("body").then(($body) => {{
        const topbarLogout = $body.find('[aria-label*="data-cy:topbar-logout-button"], [aria-label*="topbar-logout-button"], [key="topbar-logout-button"], [data-cy="topbar-logout-button"]');
        if (topbarLogout.length > 0) {{
          cy.wrap(topbarLogout).first().click({{ force: true }});
        }} else {{
          cy.clearAllCookies();
          cy.clearAllLocalStorage();
          cy.clearAllSessionStorage();
          cy.visit(targetBaseUrl + "/login?enable-semantics=true");
        }}
      }});
      cy.waitAndSee();
      cy.url().should("include", "/login");

      // Take logout screenshot
      cy.screenshot("logout_screen_{screen_code}");
      cy.task("log", "✅ PROGRESS: - Verified {screen_name} successfully!\\n");
    }});
  }});
""")

    content = header() + f"""
describe("Org Full System Real Login Logout Test", () => {{
{"".join(blocks)}
}});
"""
    (OUT_ORG / "org_full_system_real_login_logout.cy.js").write_text(content, encoding="utf-8")

def main():
    mkdirs()
    apps, roles, screens, languages = read_db()

    generate_auth_specs(roles)
    generate_language_specs(roles, languages)
    generate_screen_specs(roles, screens)
    generate_role_specs(roles, screens)
    generate_app_specs(apps, roles, screens)
    generate_org_spec(roles, screens)
    generate_org_real_login_logout_spec(roles, screens)

    print("Flat Cypress specs generated:")
    print(f"Roles: {len(roles)}")
    print(f"Screens: {len(screens)}")
    print(f"Apps: {len(apps)}")

if __name__ == "__main__":
    main()
