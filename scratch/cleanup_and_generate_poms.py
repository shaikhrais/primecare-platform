import sqlite3
import os

PROJECT_ROOT = r"c:\Users\Admin2\Documents\GitHub\primecare-platform"
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")
PAGES_DIR = os.path.join(PROJECT_ROOT, "cypress", "e2e", "pages")

# List of old files to clean up
FILES_TO_DELETE = [
    os.path.join(PAGES_DIR, "business_development", "RegionalBdmPage.ts"),
    os.path.join(PAGES_DIR, "business_development", "RegionalManagerPage.ts"),
    os.path.join(PAGES_DIR, "client", "PatientDashboardPage.ts"),
    os.path.join(PAGES_DIR, "franchise", "SchedulerDashboardPage.ts")
]

def to_camel_case(s):
    parts = s.split('_')
    return "".join(p.capitalize() for p in parts)

def main():
    # Cleanup old files
    for filepath in FILES_TO_DELETE:
        if os.path.exists(filepath):
            print(f"Deleting old file: {filepath}")
            os.remove(filepath)
            
    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()
    cursor.execute("SELECT role_code, primary_app_code FROM roles;")
    rows = cursor.fetchall()
    
    for role_code, app_code in rows:
        if not app_code:
            continue
            
        app_dir = os.path.join(PAGES_DIR, app_code)
        os.makedirs(app_dir, exist_ok=True)
        
        class_name = f"{to_camel_case(role_code)}DashboardPage"
        filename = f"{class_name}.ts"
        filepath = os.path.join(app_dir, filename)
        
        # Overwrite to ensure correct import and structure
        print(f"Generating POM: {filepath}")
        content = f"""import {{ DashboardPage }} from "../auth/DashboardPage";

export class {class_name} extends DashboardPage {{
  isLoaded() {{
    this.initializeFromDb("{role_code}", "dashboard").then(() => {{
      this.assertLoaded();
      this.assertRequiredComponents();
    }});
    return this;
  }}

  clickBtn(index: number) {{
    this.getButton(index).click({{ force: true }});
    return this;
  }}
}}
"""
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(content)
            
    conn.close()

if __name__ == '__main__':
    main()
