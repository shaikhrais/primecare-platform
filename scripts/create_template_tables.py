import sqlite3
import os

PROJECT_ROOT = r"C:\Users\Admin2\Documents\GitHub\primecare-platform"
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def main():
    conn = sqlite3.connect(DB_PATH)
    c = conn.cursor()

    print("Creating template tables...")

    # 1. code_file_templates
    c.execute("""
    CREATE TABLE IF NOT EXISTS code_file_templates (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        file_type TEXT UNIQUE,
        template_content TEXT,
        description TEXT
    );
    """)

    # 2. element_templates
    c.execute("""
    CREATE TABLE IF NOT EXISTS element_templates (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        element_type TEXT UNIQUE,
        template_content TEXT,
        description TEXT
    );
    """)

    # 3. api_client_templates
    c.execute("""
    CREATE TABLE IF NOT EXISTS api_client_templates (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        template_content TEXT,
        description TEXT
    );
    """)

    # 4. state_management_templates
    c.execute("""
    CREATE TABLE IF NOT EXISTS state_management_templates (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        template_content TEXT,
        description TEXT
    );
    """)

    # 5. button_logic_templates
    c.execute("""
    CREATE TABLE IF NOT EXISTS button_logic_templates (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        action_type TEXT UNIQUE,
        template_content TEXT,
        description TEXT
    );
    """)

    # 6. route_templates
    c.execute("""
    CREATE TABLE IF NOT EXISTS route_templates (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        template_content TEXT,
        description TEXT
    );
    """)

    # 7. sidebar_templates
    c.execute("""
    CREATE TABLE IF NOT EXISTS sidebar_templates (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        template_content TEXT,
        description TEXT
    );
    """)

    # 8. test_templates
    c.execute("""
    CREATE TABLE IF NOT EXISTS test_templates (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        template_content TEXT,
        description TEXT
    );
    """)

    # 9. screen_file_graph
    c.execute("""
    CREATE TABLE IF NOT EXISTS screen_file_graph (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        screen_id INTEGER,
        file_id INTEGER,
        depends_on_file_id INTEGER,
        dependency_type TEXT
    );
    """)

    print("Tables created. Seeding default templates...")

    # Seed code_file_templates
    templates = [
        ("screen", """import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
{section_imports}

class {class_name}Screen extends StatelessWidget {{
  const {class_name}Screen({{super.key}});

  @override
  Widget build(BuildContext context) {{
    return ScreenScaffold(
      screenCode: '{screen_code}',
      title: '{screen_name}',
      child: Column(
        children: const [
{section_widgets}
        ],
      ),
    );
  }}
}}
""", "Main coordinator layout template"),

        ("section", """import 'package:flutter/material.dart';

class {class_name}Section extends StatelessWidget {{
  const {class_name}Section({{super.key}});

  @override
  Widget build(BuildContext context) {{
    return Container(
      key: const Key('{section_code}-section'),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('{section_name}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          // TODO: Add element slots here from DB
        ],
      ),
    );
  }}
}}
""", "UI Section container template"),

        ("element", """import 'package:flutter/material.dart';

class {class_name}Element extends StatelessWidget {{
  const {class_name}Element({{super.key}});

  @override
  Widget build(BuildContext context) {{
    return Container(
      key: const Key('{element_key}-element'),
      child: const Text('Element: {element_label} ({element_type})'),
      // TODO: Implement custom element behaviour
    );
  }}
}}
""", "Custom elements template"),

        ("model", """import 'package:primecare_models/primecare_models.dart';

class {class_name}Model extends BaseScreenState<{class_name}Model> {{
  const {class_name}Model({{
    super.isLoading = false,
    super.errorMessage,
    super.data = const {{}},
  }});

  @override
  {class_name}Model rebuild({{
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }}) => {class_name}Model(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}}
""", "Shared inherited screen state template"),

        ("state", """import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/{screen_code}_model.dart';

class {class_name}Notifier extends StateNotifier<{class_name}Model> {{
  {class_name}Notifier() : super(const {class_name}Model(isLoading: true));

  Future<void> loadData() async {{
    state = state.copyWith(isLoading: true);
    try {{
      // TODO: Call API service
      state = state.copyWith(isLoading: false, data: const {{}});
    }} catch (e) {{
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }}
  }}
}}

final {screen_code}Provider = StateNotifierProvider<{class_name}Notifier, {class_name}Model>((ref) {{
  return {class_name}Notifier()..loadData();
}});
""", "Riverpod state management notifier template"),

        ("api_client", """// API Client for {screen_name}
// Endpoint: {api_endpoint}

class {class_name}Api {{
  // TODO: Add methods linked to button actions
  Future<Map<String, dynamic>> fetchData() async {{
    // Stub call
    return const {{}};
  }}
}}
""", "API client integration template"),

        ("test", """describe('{screen_name} E2E Test', () => {{
  beforeEach(() => {{
    cy.visit('{route_path}');
  }});

  it('should mount screen and display elements', () => {{
    cy.get('[data-cy="{screen_code}-screen"]').should('exist');
    // TODO: Add assertions for sections and elements
  }});
}});
""", "Cypress e2e spec template")
    ]

    for file_type, content, desc in templates:
        c.execute("""
        INSERT OR REPLACE INTO code_file_templates (file_type, template_content, description)
        VALUES (?, ?, ?);
        """, (file_type, content, desc))

    conn.commit()
    print("Done! Seeding templates completed successfully.")
    conn.close()

if __name__ == "__main__":
    main()
