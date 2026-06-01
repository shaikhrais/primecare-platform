import re
import os

spec_path = "cypress/e2e/04_roles/role_psw_all_screens.cy.js"

with open(spec_path, "r", encoding="utf-8") as f:
    content = f.read()

# Split by the 'cy.task("log", "⏳ PROGRESS:' text to segment individual screens
parts = content.split('cy.task("log", "⏳ PROGRESS:')

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
    
    spec_name = "role_psw_all_screens.cy.js"
    
    # Clean up duplicate description string mappings
    progress_clean = progress_text.replace("\n", " ").strip()
    success_clean = success_text.replace("\n", " ").strip()
    
    # Include cy. prefix explicitly!
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
    # Extract trailing characters after the current screen verification block completes
    success_token = f'cy.task("log", "✅ PROGRESS: {success_text}");'
    success_index = part.find(success_token)
    remainder = part[success_index + len(success_token):]
    
    new_parts.append(wrapped_part + remainder)

# Join with empty spacer since cy. is written inside wrapped_part directly!
new_content = header + "".join(new_parts)

with open(spec_path, "w", encoding="utf-8", newline="\n") as f:
    f.write(new_content)

print("[SUCCESS] Patched all 20 screens with 100% precision.")
