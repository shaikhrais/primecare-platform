import sqlite3
import os
import json

DB_PATH = r"c:\Users\Admin2\Documents\GitHub\primecare-platform\.agents\governance\governance.db"
PROJECT_ROOT = r"c:\Users\Admin2\Documents\GitHub\primecare-platform"

# Templates
SCREEN_TEMPLATE = """// Governance - Category: view | Purpose: Coordinator layout for {screen_name}
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class {class_name}Screen extends ConsumerWidget {{
  const {class_name}Screen({{super.key}});

  @override
  Widget build(BuildContext context, WidgetRef ref) {{
    return const Scaffold(
      body: Center(
        child: Text('{screen_name} Coordinator'),
      ),
    );
  }}
}}
"""

SECTION_TEMPLATE = """// Governance - Category: section | Purpose: UI Section rendering {section_name}
// TODO: Implement section view and element bindings.
import 'package:flutter/material.dart';

class {class_name}Section extends StatelessWidget {{
  const {class_name}Section({{super.key}});

  @override
  Widget build(BuildContext context) {{
    return const SizedBox(
      child: Text('{section_name} Section'),
    );
  }}
}}
"""

MODEL_TEMPLATE = """// Governance - Category: model | Purpose: Data entity definition for {screen_name}
// TODO: Implement DTO, serialization mapping, and state values.

class {class_name}Model {{
  const {class_name}Model();
  
  factory {class_name}Model.fromJson(Map<String, dynamic> json) {{
    return const {class_name}Model();
  }}
  
  Map<String, dynamic> toJson() => {{}};
}}
"""

PROVIDER_TEMPLATE = """// Governance - Category: state | Purpose: Riverpod state notifier for {screen_name}
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class {class_name}Notifier extends StateNotifier<AsyncValue<void>> {{
  {class_name}Notifier() : super(const AsyncValue.data(null));
}}
"""

API_TEMPLATE = """// Governance - Category: service | Purpose: Backend API service mapping for {screen_name}
// TODO: Implement API requests, routes, methods, and error mapping.

class {class_name}Api {{
  const {class_name}Api();
}}
"""

CYPRESS_TEMPLATE = """// AUTO-GENERATED SKELETON SPEC FOR {screen_name}
// TODO: Implement assertions and Cypress user journeys.

describe("Runtime Mounting - {screen_name}", () => {{
  it("visits the route and asserts main content visibility", () => {{
    cy.visit("{route_path}");
  }});
}});
"""

def to_camel_case(s):
    # Convert psw_visit_notes to PswVisitNotes
    parts = s.replace("-", "_").split("_")
    return "".join(p.capitalize() for p in parts if p)

def main():
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    cur = conn.cursor()

    # Clear old registry tables to start clean
    print("Resetting project_file_registry tables...")
    cur.execute("DELETE FROM project_file_registry;")
    cur.execute("DELETE FROM project_file_dependencies;")
    cur.execute("DELETE FROM implementation_execution_plan;")
    conn.commit()

    # Load screens, sections, apps, roles
    cur.execute("SELECT * FROM screens;")
    screens = [dict(row) for row in cur.fetchall()]

    cur.execute("SELECT * FROM apps;")
    apps = {row['id']: dict(row) for row in cur.fetchall()}

    cur.execute("SELECT * FROM roles;")
    roles = {row['id']: dict(row) for row in cur.fetchall()}

    cur.execute("SELECT * FROM screen_sections;")
    all_sections = [dict(row) for row in cur.fetchall()]
    sections_by_screen = {}
    for sec in all_sections:
        sections_by_screen.setdefault(sec['screen_id'], []).append(sec)

    files_to_insert = []
    dependencies_to_insert = []
    
    project_map_lines = ["# PROJECT ARCHITECTURE MAP\n\n", "This file details the generated file skeletons and registry order.\n\n"]

    print("Generating filesystem architecture...")
    
    file_id_counter = 1
    
    for s in screens:
        screen_id = s["id"]
        screen_code = s["screen_code"]
        screen_name = s["screen_name"]
        role_code = roles.get(s["role_id"], {}).get("role_code", "common").lower()
        class_name = to_camel_case(screen_code)
        
        # Determine screen base folder
        # Standard folder: packages/primecare_ui/lib/src/screens/<role_code>/<screen_code>/
        screen_dir = os.path.join(PROJECT_ROOT, "packages", "primecare_ui", "lib", "src", "screens", role_code, screen_code)
        
        # If actual_file_path is populated, we can extract the base folder (e.g. packages/primecare_ui/lib/src/screens/clinical)
        # and then append the screen_code to keep it nested!
        if s.get("actual_file_path"):
            raw_path = s["actual_file_path"]
            # Remove leading slashes/backslashes if any
            if raw_path.startswith("/") or raw_path.startswith("\\"):
                raw_path = raw_path[1:]
            
            base_dir = os.path.dirname(raw_path)
            # Ensure it is normalized
            base_dir = base_dir.replace("/", os.sep).replace("\\", os.sep)
            
            # Check if the folder name is already screen_code
            if os.path.basename(base_dir) == screen_code:
                screen_dir = os.path.join(PROJECT_ROOT, base_dir)
            else:
                screen_dir = os.path.join(PROJECT_ROOT, base_dir, screen_code)

        # Ensure directory paths are normalized with correct OS separators
        screen_dir = os.path.normpath(screen_dir)

        # 1. Screen coordinator file
        screen_file_name = f"{screen_code}_screen.dart"
        screen_path = os.path.join(screen_dir, screen_file_name)
        
        # 2. Sections subfolder
        sections_dir = os.path.join(screen_dir, "sections")
        
        # 3. Models subfolder
        models_dir = os.path.join(screen_dir, "models")
        model_file_name = f"{screen_code}_model.dart"
        model_path = os.path.join(models_dir, model_file_name)

        # 4. State subfolder
        state_dir = os.path.join(screen_dir, "state")
        provider_file_name = f"{screen_code}_provider.dart"
        provider_path = os.path.join(state_dir, provider_file_name)

        # 5. Services subfolder
        services_dir = os.path.join(screen_dir, "services")
        api_file_name = f"{screen_code}_api.dart"
        api_path = os.path.join(services_dir, api_file_name)

        # 6. Cypress E2E file
        cypress_dir = os.path.join(PROJECT_ROOT, "cypress", "e2e", "generated")
        cypress_file_name = f"{screen_code}.cy.ts"
        cypress_path = os.path.join(cypress_dir, cypress_file_name)

        # Pre-format the skeleton code contents
        screen_code_content = SCREEN_TEMPLATE.format(screen_name=screen_name, class_name=class_name)
        model_code_content = MODEL_TEMPLATE.format(screen_name=screen_name, class_name=class_name)
        provider_code_content = PROVIDER_TEMPLATE.format(screen_name=screen_name, class_name=class_name)
        api_code_content = API_TEMPLATE.format(screen_name=screen_name, class_name=class_name)
        test_code_content = CYPRESS_TEMPLATE.format(screen_name=screen_name, route_path=s["route_path"])

        # Build registry tuples
        # Registry columns: id, app_id, role_id, screen_id, section_id, file_code, file_name, file_type, absolute_path, folder_path, parent_file_id, dependency_file_ids_json, purpose, generation_order, implementation_status, code_content
        
        screen_file_id = file_id_counter
        files_to_insert.append((
            screen_file_id, s["app_id"], s["role_id"], screen_id, None,
            f"{screen_code}_screen", screen_file_name, "screen", screen_path, screen_dir,
            None, None, f"Main coordinator layout for {screen_name}", 1, "skeleton", screen_code_content
        ))
        file_id_counter += 1

        model_file_id = file_id_counter
        files_to_insert.append((
            model_file_id, s["app_id"], s["role_id"], screen_id, None,
            f"{screen_code}_model", model_file_name, "model", model_path, models_dir,
            screen_file_id, None, f"Data models for {screen_name}", 2, "skeleton", model_code_content
        ))
        file_id_counter += 1

        provider_file_id = file_id_counter
        files_to_insert.append((
            provider_file_id, s["app_id"], s["role_id"], screen_id, None,
            f"{screen_code}_provider", provider_file_name, "provider", provider_path, state_dir,
            screen_file_id, None, f"Riverpod provider for {screen_name}", 3, "skeleton", provider_code_content
        ))
        file_id_counter += 1

        api_file_id = file_id_counter
        files_to_insert.append((
            api_file_id, s["app_id"], s["role_id"], screen_id, None,
            f"{screen_code}_api", api_file_name, "api_client", api_path, services_dir,
            screen_file_id, None, f"API Service requests for {screen_name}", 4, "skeleton", api_code_content
        ))
        file_id_counter += 1

        test_file_id = file_id_counter
        files_to_insert.append((
            test_file_id, s["app_id"], s["role_id"], screen_id, None,
            f"{screen_code}_test", cypress_file_name, "test", cypress_path, cypress_dir,
            screen_file_id, None, f"Cypress spec for {screen_name}", 5, "skeleton", test_code_content
        ))
        file_id_counter += 1

        # Mapped dependencies
        # Screen coordinator depends on model, provider, api_client, and test
        dependencies_to_insert.extend([
            (screen_file_id, model_file_id, "layout_binding"),
            (screen_file_id, provider_file_id, "state_binding"),
            (screen_file_id, api_file_id, "data_fetch"),
            (test_file_id, screen_file_id, "e2e_verification")
        ])

        # Generate each planned section
        for sec in sections_by_screen.get(screen_id, []):
            sec_code = sec["section_code"]
            sec_name = sec["section_name"]
            sec_file_name = f"{sec_code}_section.dart"
            sec_path = os.path.join(sections_dir, sec_file_name)
            
            sec_code_content = SECTION_TEMPLATE.format(section_name=sec_name, class_name=to_camel_case(sec_code))
            
            sec_file_id = file_id_counter
            files_to_insert.append((
                sec_file_id, s["app_id"], s["role_id"], screen_id, sec["id"],
                f"{sec_code}_section", sec_file_name, "section", sec_path, sections_dir,
                screen_file_id, None, f"UI Section rendering {sec_name}", 6, "skeleton", sec_code_content
            ))
            file_id_counter += 1
            
            # Screen coordinator depends on its sections
            dependencies_to_insert.append((screen_file_id, sec_file_id, "layout_assembly"))

            # Create Section File Skeleton
            if not os.path.exists(sec_path):
                os.makedirs(sections_dir, exist_ok=True)
                with open(sec_path, "w", encoding="utf-8") as f:
                    f.write(sec_code_content)

        # Create Screen Coordinator File Skeleton
        if not os.path.exists(screen_path):
            os.makedirs(screen_dir, exist_ok=True)
            with open(screen_path, "w", encoding="utf-8") as f:
                f.write(screen_code_content)

        # Create Model File Skeleton
        if not os.path.exists(model_path):
            os.makedirs(models_dir, exist_ok=True)
            with open(model_path, "w", encoding="utf-8") as f:
                f.write(model_code_content)

        # Create Provider File Skeleton
        if not os.path.exists(provider_path):
            os.makedirs(state_dir, exist_ok=True)
            with open(provider_path, "w", encoding="utf-8") as f:
                f.write(provider_code_content)

        # Create API Service File Skeleton
        if not os.path.exists(api_path):
            os.makedirs(services_dir, exist_ok=True)
            with open(api_path, "w", encoding="utf-8") as f:
                f.write(api_code_content)

        # Create Cypress Test File Skeleton
        if not os.path.exists(cypress_path):
            os.makedirs(cypress_dir, exist_ok=True)
            with open(cypress_path, "w", encoding="utf-8") as f:
                f.write(test_code_content)

        project_map_lines.append(f"### Screen: {screen_name} ({screen_code})\n")
        project_map_lines.append(f"- Directory: `{screen_dir}`\n")
        project_map_lines.append(f"- Files:\n")
        project_map_lines.append(f"  - `{screen_file_name}`\n")
        project_map_lines.append(f"  - `models/{model_file_name}`\n")
        project_map_lines.append(f"  - `state/{provider_file_name}`\n")
        project_map_lines.append(f"  - `services/{api_file_name}`\n")
        for sec in sections_by_screen.get(screen_id, []):
            project_map_lines.append(f"  - `sections/{sec['section_code']}_section.dart`\n")
        project_map_lines.append("\n")

    # Bulk insert into database
    print("Writing project file records to governance.db...")
    cur.executemany("""
        INSERT INTO project_file_registry (
            id, app_id, role_id, screen_id, section_id, file_code, file_name, file_type, 
            absolute_path, folder_path, parent_file_id, dependency_file_ids_json, purpose, generation_order, implementation_status, code_content
        ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    """, files_to_insert)

    cur.executemany("""
        INSERT INTO project_file_dependencies (file_id, depends_on_file_id, dependency_type)
        VALUES (?, ?, ?)
    """, dependencies_to_insert)


    # Seed implementation execution plan
    # Order: model (1), api_client (2), provider (3), section (4), screen (5), test (6)
    exec_plans = []
    for f in files_to_insert:
        fid = f[0]
        ftype = f[7]
        step = 5
        phase = "UI screen layout assembly"
        if ftype == "model":
            step = 1
            phase = "Data entities serialization model"
        elif ftype == "api_client":
            step = 2
            phase = "Backend API endpoints client service"
        elif ftype == "provider":
            step = 3
            phase = "Riverpod state notifier controller"
        elif ftype == "section":
            step = 4
            phase = "UI sub-component sections view"
        elif ftype == "test":
            step = 6
            phase = "Cypress E2E suite verification"
        
        exec_plans.append((fid, step, phase))

    cur.executemany("""
        INSERT INTO implementation_execution_plan (file_id, build_step, phase_name)
        VALUES (?, ?, ?)
    """, exec_plans)

    conn.commit()
    conn.close()

    # Write PROJECT_ARCHITECTURE_MAP.md
    print("Writing PROJECT_ARCHITECTURE_MAP.md...")
    with open(os.path.join(PROJECT_ROOT, "PROJECT_ARCHITECTURE_MAP.md"), "w", encoding="utf-8") as f:
        f.writelines(project_map_lines)

    print("Project architecture skeleton generated successfully!")

if __name__ == "__main__":
    main()
