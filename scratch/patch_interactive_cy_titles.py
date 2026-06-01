import os
import re

files_to_patch = [
    "apps/primecare_clinic/lib/features/psw/screens/psw_messages_screen.dart",
    "apps/primecare_clinic/lib/features/psw/screens/psw_visit_notes_screen.dart",
    "apps/primecare_clinic/lib/features/psw/screens/psw_shift_tracker_screen.dart",
    "apps/primecare_clinic/lib/features/psw/screens/psw_my_shifts_screen.dart",
    "apps/primecare_clinic/lib/features/psw/screens/psw_client_profile_screen.dart",
    "apps/primecare_clinic/lib/features/psw/screens/psw_care_plan_screen.dart",
    "apps/primecare_clinic/lib/features/psw/screens/psw_documents_screen.dart"
]

pattern = r"""                        Semantics\(
                          label: 'data-cy:([^']+)-title',
                          container: true,
                          button: true,
                          enabled: true,
                          onTap: \(\) \{\},
                          child: Text\(
                            title,
                            style: theme\.typography\.h4\.copyWith\(color: theme\.colors\.onSurface\),
                          \),
                        \),"""

replacement = r"""                        Cy(
                          id: '\1-title',
                          child: Semantics(
                            label: 'data-cy:\1-title',
                            container: true,
                            button: true,
                            enabled: true,
                            onTap: () {},
                            child: Text(
                              title,
                              style: theme.typography.h4.copyWith(color: theme.colors.onSurface),
                            ),
                          ),
                        ),"""

patched_count = 0

for file_path in files_to_patch:
    if not os.path.exists(file_path):
        print(f"[WARN] File not found: {file_path}")
        continue
        
    with open(file_path, "r", encoding="utf-8") as f:
        content = f.read()
        
    new_content = re.sub(pattern, replacement, content)
    if new_content != content:
        with open(file_path, "w", encoding="utf-8", newline="\n") as f:
            f.write(new_content)
        print(f"[PATCHED] {file_path}")
        patched_count += 1
    else:
        print(f"[NO CHANGE] {file_path}")

print(f"\nDone! Patched {patched_count} files successfully.")
