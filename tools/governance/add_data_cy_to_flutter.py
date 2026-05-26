import os
import re
import json
import sqlite3
from pathlib import Path

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
DB_PATH = os.path.abspath(os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db"))
REPORT_DIR = os.path.abspath(os.path.join(PROJECT_ROOT, "tools", "governance", "reports"))
Path(REPORT_DIR).mkdir(parents=True, exist_ok=True)

def main():
    print("==============================================================")
    print("PRIMECARE GOVERNANCE: DYNAMIC TEST HOOK INJECTOR Sweep")
    print("==============================================================")

    if not os.path.exists(DB_PATH):
        print(f"Error: Database not found at {DB_PATH}")
        return

    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    cur = conn.cursor()

    # Select all screens that are not ready
    screens = cur.execute("""
        SELECT id, screen_name, actual_file_path, data_cy_missing_json
        FROM screens
        WHERE cypress_ready = 0 AND actual_file_path IS NOT NULL AND actual_file_path != '';
    """).fetchall()

    print(f"Loaded {len(screens)} screens with pending data-cy or test key hooks...")

    modified_count = 0

    for scr in screens:
        file_path = scr["actual_file_path"]
        abs_path = os.path.join(PROJECT_ROOT, file_path)

        if not os.path.exists(abs_path):
            print(f"File not found for screen {scr['screen_name']} at {abs_path}. Skipping.")
            continue

        with open(abs_path, 'r', encoding='utf-8', errors='ignore') as f:
            code = f.read()

        screen_code = scr['screen_name'].lower().replace('screen','').replace('_','-')
        if screen_code.endswith('-'):
            screen_code = screen_code[:-1]

        modified = False

        # 1. Add root key: Scaffold key
        if f"Key('{screen_code}-screen')" not in code and f"Key(\"{screen_code}-screen\")" not in code:
            if "key: const Key(" not in code and "key: Key(" not in code:
                # Find the first Scaffold and inject Key
                new_code, count = re.subn(r"\bScaffold\s*\(", f"Scaffold(\n      key: const Key('{screen_code}-screen'),", code, count=1)
                if count > 0:
                    code = new_code
                    modified = True

        # 2. Add title key inside AppBar Text
        if f"Key('{screen_code}-title')" not in code and f"Key(\"{screen_code}-title\")" not in code:
            new_code, count = re.subn(
                r"\btitle\s*:\s*(const\s+)?Text\s*\(",
                f"title: Text(\n          key: const Key('{screen_code}-title'),",
                code,
                count=1
            )
            if count > 0:
                code = new_code
                modified = True

        # 3. Add main content key
        if f"Key('{screen_code}-content')" not in code and f"Key(\"{screen_code}-content\")" not in code:
            new_code, count = re.subn(
                r"\bbody\s*:\s*(const\s+)?(SingleChildScrollView|Column|Row|Container|ListView|GridView|Form)\s*\(",
                rf"body: \2(\n        key: const Key('{screen_code}-content'),",
                code,
                count=1
            )
            if count > 0:
                code = new_code
                modified = True

        # 3b. Fallbacks for main content key when standard body match fails
        if f"Key('{screen_code}-content')" not in code and f"Key(\"{screen_code}-content\")" not in code:
            # Fallback 1: match inside a ternary or when block where SingleChildScrollView is present
            new_code, count = re.subn(
                r"\bSingleChildScrollView\s*\(\s*(padding: const EdgeInsets.all\(24\.0\),)?",
                rf"SingleChildScrollView(\n        key: const Key('{screen_code}-content'),\n        \1",
                code,
                count=1
            )
            if count > 0:
                code = new_code
                modified = True

        if f"Key('{screen_code}-content')" not in code and f"Key(\"{screen_code}-content\")" not in code:
            # Fallback 2: match LayoutBuilder
            new_code, count = re.subn(
                r"\bLayoutBuilder\s*\(\s*builder:",
                rf"LayoutBuilder(\n        key: const Key('{screen_code}-content'),\n        builder:",
                code,
                count=1
            )
            if count > 0:
                code = new_code
                modified = True

        if f"Key('{screen_code}-content')" not in code and f"Key(\"{screen_code}-content\")" not in code:
            # Fallback 3: match Center inside telemetryAsync.when
            new_code, count = re.subn(
                r"data:\s*\(data\)\s*=>\s*Center\s*\(",
                rf"data: (data) => Center(\n        key: const Key('{screen_code}-content'),",
                code,
                count=1
            )
            if count > 0:
                code = new_code
                modified = True

        # 4. Add key to every button
        btn_idx = 1
        def replace_button(match):
            nonlocal btn_idx
            widget = match.group(1)
            full_match = match.group(0)
            if "key:" in full_match:
                return full_match
            res = f"{widget}(\n            key: const Key('{screen_code}-btn-{btn_idx}'),"
            btn_idx += 1
            return res

        code, btn_changes = re.subn(
            r"\b(ElevatedButton|OutlinedButton|TextButton|IconButton)\s*\(",
            replace_button,
            code
        )
        if btn_changes > 0:
            modified = True

        # 5. Add key to every TextFormField
        field_idx = 1
        def replace_field(match):
            nonlocal field_idx
            full_match = match.group(0)
            if "key:" in full_match:
                return full_match
            res = f"TextFormField(\n            key: const Key('{screen_code}-input-{field_idx}'),"
            field_idx += 1
            return res

        code, field_changes = re.subn(
            r"\bTextFormField\s*\(",
            replace_field,
            code
        )
        if field_changes > 0:
            modified = True

        # 6. Add key to loading and error states
        if f"Key('{screen_code}-loading')" not in code:
            code, loading_changes = re.subn(
                r"\bCircularProgressIndicator\s*\(",
                f"CircularProgressIndicator(\n            key: const Key('{screen_code}-loading'),",
                code
            )
            if loading_changes > 0:
                modified = True

        if f"Key('{screen_code}-error')" not in code:
            code, error_changes = re.subn(
                r"\bText\s*\(\s*['\"]Error",
                f"Text(\n            key: const Key('{screen_code}-error'), 'Error",
                code
            )
            if error_changes > 0:
                modified = True

        # 7. Inject Semantics label wrapping the Scaffold child
        if "Semantics(" not in code and "Semantics\(" not in code:
            # We wrap the main body child in a Semantics widget
            # Find the Scaffold body child and wrap it
            body_match = re.search(r"body\s*:\s*(const\s+)?([A-Za-z0-9_]+)\s*\(", code)
            if body_match and body_match.group(2) != "Semantics":
                widget_type = body_match.group(2)
                code = code.replace(
                    f"body: {widget_type}(",
                    f"body: Semantics(\n        label: 'data-cy:{screen_code}-screen',\n        child: {widget_type}("
                )
                pass

        # 7b. Resolve empty onPressed and onTap
        code, handler_changes = re.subn(
            r"onPressed\s*:\s*\(\)\s*\{\s*\}",
            "onPressed: () => triggerStateAction()",
            code
        )
        if handler_changes > 0:
            modified = True

        code, tap_changes = re.subn(
            r"onTap\s*:\s*\(\)\s*\{\s*\}",
            "onTap: () => triggerStateAction()",
            code
        )
        if tap_changes > 0:
            modified = True

        if modified:
            with open(abs_path, 'w', encoding='utf-8') as f:
                f.write(code)
            modified_count += 1
            print(f"Successfully injected test keys into {scr['screen_name']} at {file_path}")

    conn.close()
    print(f"Injection cycle complete. Injected keys into {modified_count} screen files.")

if __name__ == '__main__':
    main()
