import os
import json

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
JSON_PATH = os.path.join(PROJECT_ROOT, "packages", "primecare_ui", "lib", "src", "shared", "src", "integration", "platform_governance_registry.json")
DART_PATH = os.path.join(PROJECT_ROOT, "packages", "primecare_ui", "lib", "src", "shared", "src", "integration", "platform_governance_registry.dart")

def main():
    print(f"Loading registry JSON from: {JSON_PATH}")
    if not os.path.exists(JSON_PATH):
        print("Error: JSON file not found!")
        return

    with open(JSON_PATH, "r", encoding="utf-8") as f:
        data = json.load(f)

    ui_mvc = data.get("ui_mvc", {})
    api_mvc = data.get("api_mvc", {})
    locs = data.get("locs", {})
    files = data.get("files", {})
    total_ui = data.get("total_ui", 12)
    total_api = data.get("total_api", 13)

    ui_projects = list(ui_mvc.keys())
    api_projects = list(api_mvc.keys())

    # Build Dart code content
    code = []
    code.append("// Governance - Category: service | Purpose: Layer: 00_GOVERNANCE_MANIFEST Architecture: Immutable Platform Master Registry")
    code.append("// Layer: 00_GOVERNANCE_MANIFEST")
    code.append("// Architecture: Immutable Platform Master Registry")
    code.append("")
    code.append("class PlatformGovernanceRegistry {")
    code.append("  static const String buildVersion = '4.5.0-STABLE';")
    code.append("  static const String buildSignature = 'UNIVERSAL-LOCK-INITIAL-STABLE';")
    code.append("")

    # LOC Manifest
    code.append("  static const Map<PlatformProject, int> projectLocManifest = {")
    for proj, val in locs.items():
        code.append(f"    PlatformProject.{proj}: {val},")
    code.append("  };")
    code.append("")

    # File Manifest
    code.append("  static const Map<PlatformProject, int> projectFileManifest = {")
    for proj, val in files.items():
        code.append(f"    PlatformProject.{proj}: {val},")
    code.append("  };")
    code.append("")

    # UI MVC Manifest
    code.append("  static const Map<PlatformProject, Map<String, int>> uiMvcManifest = {")
    for proj, mvc in ui_mvc.items():
        code.append(f"    PlatformProject.{proj}: {mvc},")
    code.append("  };")
    code.append("")

    # API MVC Manifest
    code.append("  static const Map<PlatformProject, Map<String, int>> apiMvcManifest = {")
    for proj, mvc in api_mvc.items():
        code.append(f"    PlatformProject.{proj}: {mvc},")
    code.append("  };")
    code.append("")

    code.append("  static const int totalRoles = 55;")
    code.append("  static const int rolesWithAccess = 55;")
    code.append("")
    code.append(f"  static const int totalUiProjects = {total_ui};")
    code.append(f"  static const int totalApiProjects = {total_api};")
    code.append("  static const int totalScreens = 160;")
    code.append("  static const bool isLoginWorking = true;")
    code.append("")

    # UI Projects List
    code.append("  static const List<PlatformProject> uiProjects = [")
    for proj in ui_projects:
        code.append(f"    PlatformProject.{proj},")
    code.append("  ];")
    code.append("")

    # API Projects List
    code.append("  static const List<PlatformProject> apiProjects = [")
    for proj in api_projects:
        code.append(f"    PlatformProject.{proj},")
    code.append("  ];")
    code.append("")

    code.append("  static Map<String, String> getManifestSummary() {")
    code.append("    return {")
    code.append("      'Version': buildVersion,")
    code.append("      'Status': 'STABLE',")
    code.append("      'Total Projects': '${projectLocManifest.length}',")
    code.append("    };")
    code.append("  }")
    code.append("}")
    code.append("")

    # PlatformProject Enum
    code.append("enum PlatformProject {")
    all_projects = list(locs.keys())
    for proj in all_projects:
        code.append(f"  {proj},")
    code.append("}")
    code.append("")

    # Write out Dart file
    print(f"Writing fully hydrated Dart registry to: {DART_PATH}")
    with open(DART_PATH, "w", encoding="utf-8") as f:
        f.write("\n".join(code))

    print("[SUCCESS] PlatformGovernanceRegistry fully hydrated and aligned with the manifest JSON!")

if __name__ == "__main__":
    main()
