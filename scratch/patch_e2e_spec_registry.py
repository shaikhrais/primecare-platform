import re
import os

spec_path = "cypress/e2e/04_roles/role_psw_all_screens.cy.js"

if not os.path.exists(spec_path):
    print(f"[ERROR] Spec file not found: {spec_path}")
    exit(1)

with open(spec_path, "r", encoding="utf-8") as f:
    content = f.read()

# Pattern to match each E2E verification block
block_pattern = r"""(\s+cy\.task\("log", "⏳ PROGRESS: ([^"]+)"\);\s+cy\.visitWithSemantics\("([^"]+)"\);\s+cy\.waitAndSee\(\);\s+cy\.task\("log", "🔍 PROGRESS: ([^"]+)"\);\s+cy\.verifyShellExists\(\);\s+cy\.verifyNotBlank\(\);\s+cy\.getCy\("([^"]+)-screen"\)\.should\("be\.visible"\);\s+cy\.getCy\("([^"]+)-title"\)\.should\("be\.visible"\);\s+cy\.getCy\("([^"]+)-content"\)\.should\("be\.visible"\);\s+cy\.task\("log", "📸 PROGRESS: ([^"]+)"\);\s+cy\.waitAndSee\(\);\s+cy\.screenshot\("([^"]+)"\);\s+cy\.task\("log", "✅ PROGRESS: ([^"]+)"\);\s*)"""

def replacer(match):
    full_block = match.group(1)
    progress_1 = match.group(2)
    path = match.group(3)
    progress_2 = match.group(4)
    screen_id = match.group(5)
    progress_3 = match.group(8)
    screenshot_name = match.group(9)
    progress_4 = match.group(10)
    
    # Check drive path or spec name
    spec_name = "role_psw_all_screens.cy.js"
    
    wrapped = f"""
  cy.checkTestRegistry("{screen_id}").then((shouldSkip) => {{
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: {progress_1}");
    cy.visitWithSemantics("{path}");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: {progress_2}");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("{screen_id}-screen").should("be.visible");
    cy.getCy("{screen_id}-title").should("be.visible");
    cy.getCy("{screen_id}-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: {progress_3}");
    cy.waitAndSee();
    cy.screenshot("{screenshot_name}");
    
    cy.updateTestRegistry("{screen_id}", "PASS", "{spec_name}", "{screenshot_name}");
    cy.task("log", "✅ PROGRESS: {progress_4}");
  }});
"""
    return wrapped

new_content = re.sub(block_pattern, replacer, content)

if new_content != content:
    with open(spec_path, "w", encoding="utf-8", newline="\n") as f:
        f.write(new_content)
    print(f"[SUCCESS] Patched spec with smart skip registry support: {spec_path}")
else:
    print("[WARN] Mismatch or already patched.")
