import os
import re

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
ROLES_DIR = os.path.join(PROJECT_ROOT, "cypress", "e2e", "04_roles")

CLINICAL_SPECS = [
    "role_chiropractor_all_screens.cy.js",
    "role_physio_all_screens.cy.js",
    "role_rmt_all_screens.cy.js",
    "role_social_worker_all_screens.cy.js",
    "role_clinical_director_all_screens.cy.js",
    "role_intake_all_screens.cy.js",
    "role_rn_all_screens.cy.js",
    "role_rpn_all_screens.cy.js",
    "role_lpn_all_screens.cy.js",
    "role_np_all_screens.cy.js",
    "role_hsw_all_screens.cy.js",
    "role_pediatric_all_screens.cy.js",
    "role_physician_all_screens.cy.js",
]

def patch_spec(spec_name):
    spec_path = os.path.join(ROLES_DIR, spec_name)
    if not os.path.exists(spec_path):
        print(f"[WARNING] Spec file not found: {spec_name}")
        return False
        
    with open(spec_path, "r", encoding="utf-8") as f:
        content = f.read()
        
    # Check if already patched to avoid double patching
    if "checkTestRegistry" in content:
        print(f"[INFO] Spec is already patched: {spec_name}")
        return True

    # Split by individual screen blocks using progress logs
    parts = content.split('cy.task("log", "⏳ PROGRESS:')
    if len(parts) <= 1:
        print(f"[WARNING] Spec could not be segmented: {spec_name}")
        return False
        
    header = parts[0]
    new_parts = []
    
    for part in parts[1:]:
        # 1. Extract progress log text
        log_match = re.search(r'^ ([^"]+)"\);', part)
        if not log_match:
            new_parts.append('cy.task("log", "⏳ PROGRESS:' + part)
            continue
        progress_text = log_match.group(1)
        
        # 2. Extract visit path
        path_match = re.search(r'cy\.visitWithSemantics\("([^"]+)"\);', part)
        if not path_match:
            new_parts.append('cy.task("log", "⏳ PROGRESS:' + part)
            continue
        path = path_match.group(1)
        
        # 3. Extract screen selector code
        screen_id_match = re.search(r'cy\.getCy\("([^"]+)-screen"\)', part)
        if not screen_id_match:
            new_parts.append('cy.task("log", "⏳ PROGRESS:' + part)
            continue
        screen_id = screen_id_match.group(1)
        
        # 4. Extract screenshot file name
        screenshot_match = re.search(r'cy\.screenshot\("([^"]+)"\);', part)
        if not screenshot_match:
            new_parts.append('cy.task("log", "⏳ PROGRESS:' + part)
            continue
        screenshot_name = screenshot_match.group(1)
        
        # 5. Extract success log text
        success_match = re.search(r'cy\.task\("log", "✅ PROGRESS: ([^"]+)"\);', part)
        if not success_match:
            new_parts.append('cy.task("log", "⏳ PROGRESS:' + part)
            continue
        success_text = success_match.group(1)
        
        progress_clean = progress_text.replace("\n", " ").strip()
        success_clean = success_text.replace("\n", " ").strip()
        
        wrapped_part = f"""
  cy.checkTestRegistry("{screen_id}").then((shouldSkip) => {{
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: {progress_clean}");
    cy.visitWithSemantics("{path}");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: {progress_clean.replace('Navigating to', 'Checking shell & content for')}");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("{screen_id}-screen").should("be.visible");
    cy.getCy("{screen_id}-title").should("be.visible");
    cy.getCy("{screen_id}-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: {progress_clean.replace('Navigating to', 'Saving screenshot for')}");
    cy.waitAndSee();
    cy.screenshot("{screenshot_name}");
    
    cy.updateTestRegistry("{screen_id}", "PASS", "{spec_name}", "{screenshot_name}");
    cy.task("log", "✅ PROGRESS: {success_clean}");
  }});
"""
        success_token = f'cy.task("log", "✅ PROGRESS: {success_text}");'
        success_index = part.find(success_token)
        remainder = part[success_index + len(success_token):]
        
        new_parts.append(wrapped_part + remainder)
        
    new_content = header + "".join(new_parts)
    with open(spec_path, "w", encoding="utf-8", newline="\n") as f:
        f.write(new_content)
        
    print(f"[SUCCESS] Patched spec file: {spec_name}")
    return True

def main():
    print("🚀 Patching all clinical E2E specs to use smart skip & registry recording...")
    success_count = 0
    for spec in CLINICAL_SPECS:
        if patch_spec(spec):
            success_count += 1
    print(f"\n✨ Successfully patched {success_count}/{len(CLINICAL_SPECS)} specs!")

if __name__ == '__main__':
    main()
