import os
import re

PROJECT_ROOT = r"C:\Users\Admin2\Documents\GitHub\primecare-platform"
SCREENS_DIR_COMMON = os.path.join(PROJECT_ROOT, "packages", "primecare_ui", "lib", "src", "screens", "common")
SCREENS_DIR_ALLIED = os.path.join(PROJECT_ROOT, "packages", "primecare_ui", "lib", "src", "screens", "allied")

def patch_file(filepath):
    filename = os.path.basename(filepath)
    screen_code = filename.replace("_screen.dart", "").replace("_", "")
    
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()

    # Restore file first to get a clean slate
    # Let's run a simple git checkout on the file to make sure it's fresh
    os.system(f"git checkout -- {filepath}")
    
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()

    # 1. Wrap Scaffold in Semantics(label: 'data-cy:<screen_code>-screen')
    scaffold_pattern = r"return Scaffold\(\s*key: const Key\('" + screen_code + r"-screen'\),"
    if re.search(scaffold_pattern, content):
        content = re.sub(
            scaffold_pattern,
            f"return Semantics(\n      label: 'data-cy:{screen_code}-screen',\n      container: true,\n      child: Scaffold(\n        key: const Key('{screen_code}-screen'),",
            content
        )
        # Ensure it has the closing parenthesis at the end
        last_semicolon_idx = content.rfind("    );")
        if last_semicolon_idx != -1:
            content = content[:last_semicolon_idx] + "    ),\n    );" + content[last_semicolon_idx + 6:]

    # 2. Change body Semantics to data-cy:<screen_code>-content
    body_pattern = (
        r"body:\s*Semantics\(\s*label:\s*'data-cy:" + screen_code + r"-screen',\s*child:\s*SingleChildScrollView\("
    )
    if re.search(body_pattern, content):
        content = re.sub(
            body_pattern,
            f"body: Semantics(\n        label: 'data-cy:{screen_code}-content',\n        container: true,\n        child: SingleChildScrollView(",
            content
        )

    # 3. Wrap GovDashboardHero in Semantics(label: 'data-cy:<screen_code>-title')
    hero_start = content.find("GovDashboardHero(")
    if hero_start != -1:
        hero_end = content.find("),", hero_start)
        if hero_end != -1:
            hero_block = content[hero_start:hero_end+2]
            wrapped_hero = f"Semantics(\n              label: 'data-cy:{screen_code}-title',\n              child: {hero_block}\n            ),"
            content = content[:hero_start] + wrapped_hero + content[hero_end+2:]

    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(content)
        
    print(f"[+] Successfully patched {filename}")
    return True

def main():
    common_files = [
        "chiropractor_analytics_screen.dart",
        "chiropractor_compliance_screen.dart",
        "chiropractor_workflow_screen.dart"
    ]
    
    allied_files = [
        "chiropractor_command_center_screen.dart",
        "chiropractor_appointments_screen.dart",
        "chiropractor_client_intake_screen.dart",
        "chiropractor_assessment_screen.dart",
        "chiropractor_treatment_notes_screen.dart",
        "chiropractor_exercise_plan_screen.dart",
        "chiropractor_billing_link_screen.dart",
        "chiropractor_reports_screen.dart",
        "chiropractic_assessment_screen.dart",
        "adjustment_notes_screen.dart",
        "xray_review_screen.dart",
        "chiropractic_progress_tracking_screen.dart"
    ]
    
    for f in common_files:
        path = os.path.join(SCREENS_DIR_COMMON, f)
        patch_file(path)
        
    for f in allied_files:
        path = os.path.join(SCREENS_DIR_ALLIED, f)
        patch_file(path)

if __name__ == '__main__':
    main()
