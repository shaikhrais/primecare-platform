import os
import re
from pathlib import Path

# Configuration
PROJECT_ROOT = Path(__file__).parent.parent.parent.parent
DOMAIN_REGISTRIES = PROJECT_ROOT / "packages/domain/src/registries"
FLUTTER_ENUM = PROJECT_ROOT / "packages/primecare_adapters/lib/src/registry/05_G_primecare_form_enum.dart"
TRAINING_SERVICE = PROJECT_ROOT / "packages/domain/src/services/TrainingService.ts"

def check_file(path, description):
    if path.exists():
        print(f"[OK] {description} exists: {path.relative_to(PROJECT_ROOT)}")
        return True
    else:
        print(f"[FAIL] {description} MISSING: {path}")
        return False

def check_registry_integration(master_path, import_pattern, integration_pattern, name):
    if not master_path.exists():
        print(f"[FAIL] Master registry {name} MISSING: {master_path}")
        return False
    
    content = master_path.read_text(encoding="utf-8")
    has_import = re.search(import_pattern, content)
    has_integration = re.search(integration_pattern, content)
    
    if has_import and has_integration:
        print(f"[OK] {name} properly integrated in {master_path.name}")
        return True
    else:
        print(f"[FAIL] {name} NOT fully integrated in {master_path.name}")
        return False

def verify_all():
    print("=== Training Director Portal High-Fidelity Audit ===\n")
    
    # 1. Check Registry Files
    files = [
        (DOMAIN_REGISTRIES / "FormRegistry/training-forms.ts", "Training Forms Registry"),
        (DOMAIN_REGISTRIES / "ButtonRegistry/training-buttons.ts", "Training Buttons Registry"),
        (DOMAIN_REGISTRIES / "PageActionRegistry/training-actions.ts", "Training Actions Registry"),
        (TRAINING_SERVICE, "Training Service Implementation")
    ]
    
    all_files_ok = all(check_file(p, d) for p, d in files)
    
    # 2. Check Master Integrations
    integrations = [
        (
            DOMAIN_REGISTRIES / "01_I_form_registry.ts",
            r"import { TRAINING_FORMS }",
            r"\.\.\.TRAINING_FORMS",
            "Training Forms"
        ),
        (
            DOMAIN_REGISTRIES / "01_I_button_registry.ts",
            r"import { TRAINING_BUTTONS }",
            r"\.\.\.TRAINING_BUTTONS",
            "Training Buttons"
        ),
        (
            DOMAIN_REGISTRIES / "01_I_page_action_registry.ts",
            r"import { TRAINING_ACTIONS }",
            r"\.\.\.TRAINING_ACTIONS",
            "Training Actions"
        )
    ]
    
    all_integrations_ok = all(check_registry_integration(*i) for i in integrations)
    
    # 3. Check Flutter Enum
    if FLUTTER_ENUM.exists():
        content = FLUTTER_ENUM.read_text(encoding="utf-8")
        if "verifyCertificateForm" in content:
            print("[OK] verifyCertificateForm found in Flutter Enum")
        else:
            print("[FAIL] verifyCertificateForm MISSING from Flutter Enum")
    else:
        print("[FAIL] Flutter Enum file missing")

    print("\n=== Audit Complete ===")

if __name__ == "__main__":
    verify_all()
