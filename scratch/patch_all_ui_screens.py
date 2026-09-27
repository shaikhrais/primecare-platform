import os
import re
import subprocess

PROJECT_ROOT = r"C:\Users\Admin2\Documents\GitHub\primecare-platform"
SCREENS_DIR = os.path.join(PROJECT_ROOT, "packages", "primecare_ui", "lib", "src", "screens")

# Subdirectories containing standard role screens, ordered: clinic roles first, then others
CLINIC_SUBDIRS = ["clinical", "allied", "rn", "rpn", "psw", "common"]
OTHER_SUBDIRS = ["executive", "management", "premium", "staff"]
ALL_SUBDIRS = CLINIC_SUBDIRS + OTHER_SUBDIRS

def find_matching_paren(text, start_idx):
    count = 0
    for idx in range(start_idx, len(text)):
        char = text[idx]
        if char == '(':
            count += 1
        elif char == ')':
            count -= 1
            if count == 0:
                return idx
    return -1

def patch_file(filepath):
    filename = os.path.basename(filepath)
    screen_code = filename.replace("_screen.dart", "").replace("_", "")
    
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()

    # 1. Check if the screen is a standard role screen by looking for Scaffold key
    scaffold_pattern = r"Scaffold\(\s*key:\s*const\s+Key\('" + screen_code + r"-screen'\),"
    scaffold_match = re.search(scaffold_pattern, content)
    if not scaffold_match:
        # Not a standard screen or already patched
        return False

    # 2. Wrap Scaffold in Semantics(label: 'data-cy:<screen_code>-screen')
    # Find the position of Scaffold( just before the key
    scaffold_start_idx = content.find("Scaffold(", scaffold_match.start() - 20)
    if scaffold_start_idx == -1:
        scaffold_start_idx = scaffold_match.start()

    # Find the matching closing paren of Scaffold
    scaffold_paren_idx = scaffold_start_idx + 8 # length of "Scaffold" is 8, index of '(' is +8
    closing_paren_idx = find_matching_paren(content, scaffold_paren_idx)
    if closing_paren_idx == -1:
        print(f"[-] Could not find matching closing parenthesis for Scaffold in {filename}")
        return False

    # Check the character after closing paren
    next_char = content[closing_paren_idx + 1]
    
    before_scaffold = content[:scaffold_start_idx]
    scaffold_body = content[scaffold_start_idx:closing_paren_idx + 1]
    after_scaffold = content[closing_paren_idx + 1:]

    wrapped_scaffold = (
        f"Semantics(\n      label: 'data-cy:{screen_code}-screen',\n      container: true,\n      child: "
        f"{scaffold_body}"
    )

    if next_char == ';':
        # Replace the semicolon to close both Semantics and Scaffold
        wrapped_scaffold += ",\n    );"
        after_scaffold = after_scaffold[1:]
    else:
        wrapped_scaffold += ",\n    )"

    content_patched = before_scaffold + wrapped_scaffold + after_scaffold

    # 3. Change body Semantics to data-cy:<screen_code>-content
    body_pattern = r"body:\s*Semantics\(\s*label:\s*'data-cy:" + screen_code + r"-screen',"
    content_patched = re.sub(
        body_pattern,
        f"body: Semantics(\n        label: 'data-cy:{screen_code}-content',\n        container: true,",
        content_patched
    )

    # 4. Wrap GovDashboardHero in Semantics(label: 'data-cy:<screen_code>-title')
    hero_start = content_patched.find("GovDashboardHero(")
    if hero_start != -1:
        # Check if already wrapped
        check_wrapped = content_patched.rfind("label:", 0, hero_start)
        is_already_wrapped = False
        if check_wrapped != -1 and (hero_start - check_wrapped < 100):
            label_text = content_patched[check_wrapped:hero_start]
            if f"data-cy:{screen_code}-title" in label_text:
                is_already_wrapped = True
                
        if not is_already_wrapped:
            hero_paren_idx = hero_start + 16 # length of "GovDashboardHero" is 16
            hero_end_idx = find_matching_paren(content_patched, hero_paren_idx)
            if hero_end_idx != -1:
                hero_block = content_patched[hero_start:hero_end_idx+1]
                
                # Check trailing character
                trailing = ""
                trailing_offset = 1
                if content_patched[hero_end_idx + 1] == ',':
                    trailing = ","
                    trailing_offset = 2
                
                wrapped_hero = (
                    f"Semantics(\n              label: 'data-cy:{screen_code}-title',\n              "
                    f"child: {hero_block}\n            ){trailing}"
                )
                
                content_patched = (
                    content_patched[:hero_start] + 
                    wrapped_hero + 
                    content_patched[hero_end_idx + trailing_offset:]
                )

    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(content_patched)
    return True

def main():
    print("=== STARTING PLATFORM-WIDE SEMANTICS PATCHING ===")
    
    # Let's restore the files using git first to ensure we start from a completely clean reverted state
    print("[*] Performing clean git checkout on packages/primecare_ui/lib/src/screens/...")
    subprocess.run(["git", "checkout", "--", "packages/primecare_ui/lib/src/screens/"], cwd=PROJECT_ROOT, shell=True)

    patched_by_subdir = {}
    total_patched = 0

    for subdir in ALL_SUBDIRS:
        subdir_path = os.path.join(SCREENS_DIR, subdir)
        if not os.path.exists(subdir_path):
            print(f"[-] Subdirectory does not exist: {subdir}")
            continue
            
        print(f"\n[*] Processing subdirectory: {subdir}")
        subdir_patched = 0
        
        for root, dirs, files in os.walk(subdir_path):
            for file in files:
                if file.endswith("_screen.dart"):
                    filepath = os.path.join(root, file)
                    try:
                        if patch_file(filepath):
                            subdir_patched += 1
                            total_patched += 1
                    except Exception as e:
                        print(f"[-] Error patching {file}: {e}")
                        
        patched_by_subdir[subdir] = subdir_patched
        print(f"[+] Subdirectory '{subdir}' complete. Patched: {subdir_patched}")

    print("\n=== PATCHING SUMMARY ===")
    for subdir, count in patched_by_subdir.items():
        role_type = "Clinic Role" if subdir in CLINIC_SUBDIRS else "Other Role"
        print(f" - {subdir} ({role_type}): {count} screens")
    print(f"Total screens successfully patched: {total_patched}")

    if total_patched > 0:
        print("\n[*] Formatting all patched screens using dart format...")
        subprocess.run(["dart", "format", "packages/primecare_ui/lib/src/screens/"], cwd=PROJECT_ROOT, shell=True)
        print("[+] Formatting completed successfully!")

if __name__ == '__main__':
    main()
