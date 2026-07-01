import json
import os
import sqlite3

PROJECT_ROOT = r"c:\Users\Admin2\Documents\GitHub\primecare-platform"
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")
FIXTURE_PATH = os.path.join(PROJECT_ROOT, "cypress", "fixtures", "governance", "test_users.json")
SPEC_PATH = os.path.join(PROJECT_ROOT, "cypress", "e2e", "auth", "role-loading.cy.ts")

def to_camel_case(s):
    parts = s.split('_')
    return "".join(p.capitalize() for p in parts)

def main():
    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()
    cursor.execute("SELECT role_code, primary_app_code FROM roles;")
    db_roles = {r[0]: r[1] for r in cursor.fetchall()}
    conn.close()
    
    with open(FIXTURE_PATH, 'r', encoding='utf-8') as f:
        users = json.load(f)
        
    imports = []
    class_mappings = []
    
    # Sort users by role_code to keep it clean
    users.sort(key=lambda u: u["role_code"])
    
    for u in users:
        role_code = u["role_code"]
        app_code = db_roles.get(role_code)
        if not app_code:
            continue
            
        class_name = f"{to_camel_case(role_code)}DashboardPage"
        imports.append(f'import {{ {class_name} }} from "../pages/{app_code}/{class_name}";')
        class_mappings.append(f'  "{role_code}": {class_name},')
        
    imports_str = "\n".join(imports)
    mappings_str = "\n".join(class_mappings)
    
    spec_content = f"""import {{ AppHubPage }} from "../pages/auth/AppHubPage";
import {{ DashboardPage }} from "../pages/auth/DashboardPage";
{imports_str}

function getCardNameForAppCode(appCode: string): string {{
  switch (appCode) {{
    case "corporate": return "Corporate Headquarters";
    case "business_development": return "Business Development";
    case "franchise": return "Franchise Operations";
    case "support": return "Customer Support";
    case "marketing": return "Marketing & Outreach";
    case "clinic": return "Clinical Intelligence";
    case "client": return "Client Care Portal";
    case "governance": return "Platform Governance";
    default: return "";
  }}
}}

const pageClasses: Record<string, any> = {{
{mappings_str}
}};

describe("Authentication - Role Loading & Dynamic Dashboard Spec", () => {{
  const appHubPage = new AppHubPage();

  beforeEach(() => {{
    cy.clearAuthState();
  }});

  // Load list of users from Cypress fixture dynamically
  it("should systematically run through all registered roles and verify their pages", () => {{
    cy.fixture("governance/test_users.json").then((users: any[]) => {{
      // Run sequentially inside the Cypress chain to avoid overlapping browser sessions
      users.forEach((user) => {{
        const role = user.role_code;
        const email = user.email;
        const appCode = user.app_code;
        const expectedCard = getCardNameForAppCode(appCode);
        
        if (!expectedCard) return; // Skip if no card mapping exists
        
        cy.log(`====== STARTING AUDIT FOR ROLE: ${{role.toUpperCase()}} ======`);
        
        // 1. Clear session and log in
        cy.clearAuthState();
        cy.login(email, "password");
        
        // 2. Assert Hub title is visible and the expected portal card is rendered
        appHubPage.assertTitleVisible()
          .assertCardVisible(expectedCard);
          
        // 3. Click the card to navigate to the portal dashboard
        appHubPage.clickCard(expectedCard);
        
        // 4. Instantiation of role-specific POM class dynamically
        const PageClass = pageClasses[role] || DashboardPage;
        const roleDashboard = new PageClass();
        
        // 5. Verify the dashboard screen itself via DB-driven POM assertions
        roleDashboard.isLoaded();
        
        cy.log(`====== COMPLETED AUDIT FOR ROLE: ${{role.toUpperCase()}} ======`);
      }});
    }});
  }});
}});
"""
    with open(SPEC_PATH, 'w', encoding='utf-8') as f:
        f.write(spec_content)
    print(f"Successfully generated spec file: {SPEC_PATH}")

if __name__ == '__main__':
    main()
