import os

files_to_clean = [
    "apps/primecare_clinic/lib/features/physician/screens/physician_dashboard_screen.dart",
    "apps/primecare_clinic/lib/features/psw/screens/psw_dashboard_screen.dart",
    "apps/primecare_clinic/lib/features/rn/screens/rn_dashboard_screen.dart",
    "apps/primecare_clinic/lib/features/shared/screens/chiropractor_dashboard_screen.dart",
    "apps/primecare_clinic/lib/features/shared/screens/clinical_director_dashboard_screen.dart",
    "apps/primecare_clinic/lib/features/shared/screens/intake_coordinator_dashboard_screen.dart",
    "apps/primecare_clinic/lib/features/shared/screens/physiotherapist_dashboard_screen.dart",
    "apps/primecare_clinic/lib/features/shared/screens/qa_dashboard_screen.dart",
    "apps/primecare_clinic/lib/features/shared/screens/receptionist_dashboard_screen.dart",
    "apps/primecare_clinic/lib/features/shared/screens/rmt_dashboard_screen.dart",
    "apps/primecare_clinic/lib/features/shared/screens/social_worker_dashboard_screen.dart",
    "apps/primecare_clinic/lib/features/shared/screens/training_coordinator_dashboard_screen.dart",
]

for f_path in files_to_clean:
    full_path = os.path.join(os.getcwd(), f_path)
    if os.path.exists(full_path):
        with open(full_path, 'r', encoding='utf-8') as f:
            content = f.read()
        
        # Remove material and riverpod imports if they exist
        new_content = content
        new_content = new_content.replace("import 'package:flutter/material.dart';\n", "")
        new_content = new_content.replace("import 'package:flutter_riverpod/flutter_riverpod.dart';\n", "")
        
        if new_content != content:
            with open(full_path, 'w', encoding='utf-8') as f:
                f.write(new_content)
            print(f"Cleaned imports in {f_path}")
