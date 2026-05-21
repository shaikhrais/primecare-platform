import os
import sys
import re
import json

# Add current folder to path to import governance_db
sys.path.append(os.path.dirname(os.path.abspath(__file__)))
import governance_db

def _camel_to_snake(input_str):
    return re.sub(r'(?<=[a-z])[A-Z]', lambda m: '_' + m.group(0), input_str).lower()

def main():
    print("--- PrimeCare Feature Generator (SQL-Backed) ---")

    intent_id = ''
    intent_goal = ''
    page_route = ''
    page_name = ''
    page_role = ''
    db_table = ''
    field_name = ''

    args = sys.argv[1:]
    if len(args) >= 7:
        intent_id = args[0]
        intent_goal = args[1]
        page_route = args[2]
        page_name = args[3]
        page_role = args[4]
        db_table = args[5]
        field_name = args[6]
    else:
        try:
            intent_id = input('What is the Intent ID? (e.g. create_shift): ').strip()
            intent_goal = input('What is the Business Goal? (e.g. Allow managers to create shifts): ').strip()
            page_route = input('What is the Route / Page Name path? (e.g. /manager/create-shift): ').strip()
            page_name = input('What is the Flutter UI Component Name? (e.g. CreateShiftForm): ').strip()
            page_role = input('What role is allowed? (e.g. manager_portal): ').strip()
            db_table = input('Which Prisma Database Table does this modify? (e.g. Shift): ').strip()
            field_name = input('Enter one primary field ID to track (e.g. shift_date_input): ').strip()
        except KeyboardInterrupt:
            print("\nAborted.")
            sys.exit(0)

    if not intent_id or not page_name:
        print("Error: Invalid inputs.")
        sys.exit(1)

    print("\nGenerating feature mapping in SQL database...")

    conn = governance_db.get_connection()
    cursor = conn.cursor()

    # 1. Add Intent
    cursor.execute("SELECT 1 FROM intents WHERE intent_id = ?;", (intent_id,))
    if not cursor.fetchone():
        cursor.execute("""
        INSERT INTO intents (intent_id, business_goal, status)
        VALUES (?, ?, 'pending');
        """, (intent_id, intent_goal))
        print(f"[OK] Added intent '{intent_id}' to SQLite database.")
    else:
        print(f"[WARN] Intent '{intent_id}' already exists in database.")

    # 2. Add Page
    page_id_str = _camel_to_snake(page_name)
    cursor.execute("SELECT 1 FROM pages WHERE page_id = ?;", (page_id_str,))
    if not cursor.fetchone():
        cursor.execute("""
        INSERT INTO pages (page_id, route, name, role_allowed, actions, linked_intent, implementation_status)
        VALUES (?, ?, ?, ?, ?, ?, 'pending');
        """, (page_id_str, page_route, page_name, json.dumps([page_role]), json.dumps(["submit"]), intent_id))
        print(f"[OK] Added page '{page_id_str}' to SQLite database.")
    else:
        print(f"[WARN] Page '{page_id_str}' already exists in database.")

    # 3. Add Data Map Field
    cursor.execute("SELECT 1 FROM fields WHERE field_id = ? AND page_id = ?;", (field_name, page_id_str))
    if not cursor.fetchone():
        cursor.execute("""
        INSERT INTO fields (
            field_id, page_id, linked_intent, validation, api_endpoint, 
            service_method, database_table, database_column, status
        ) VALUES (?, ?, ?, 'required', ?, ?, ?, ?, 'pending');
        """, (
            field_name, 
            page_id_str, 
            intent_id, 
            f"POST /api/v1/{db_table.lower()}s", 
            f"{db_table}Service.create", 
            db_table, 
            field_name.replace("_input", "")
        ))
        print(f"[OK] Added field '{field_name}' to SQLite database.")
    else:
        print(f"[WARN] Field '{field_name}' already mapped to page '{page_id_str}' in database.")

    conn.commit()
    conn.close()

    # 4. Scaffold UI Form File
    file_name = f"{page_id_str}.dart"
    form_dir_path = 'packages/primecare_ui/lib/src/components/forms/generated'
    os.makedirs(form_dir_path, exist_ok=True)
    scaffold_path = os.path.join(form_dir_path, file_name)

    if os.path.exists(scaffold_path):
        print(f"[WARN] Scaffold file already exists at {scaffold_path}. Skipping.")
    else:
        form_content = f'''import 'package:flutter/material.dart';

class {page_name} extends StatelessWidget {{
  const {page_name}({{super.key}});

  @override
  Widget build(BuildContext context) {{
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('{page_name} Planned View', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 16),
          // Scaffolded field
          TextFormField(
            key: const Key('{field_name}'),
            decoration: const InputDecoration(labelText: '{field_name} Field'),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {{}},
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }}
}}
'''
        with open(scaffold_path, 'w', encoding='utf-8') as sf:
            sf.write(form_content)
        print(f"[OK] Scaffolded UI code at {scaffold_path}")

    print("\nSuccess! Feature defined as pending in SQLite. Run the reconciliation engine later to verify.")

if __name__ == '__main__':
    main()
