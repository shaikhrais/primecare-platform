import os
import re
import sqlite3
from pathlib import Path

# Config
WORKSPACE_DIR = Path(__file__).resolve().parent.parent
DB_PATH = WORKSPACE_DIR / ".agents" / "primecare_index.db"

# Regexes
CLASS_RE = re.compile(r'^\s*(?:abstract\s+)?class\s+([A-Za-z0-9_]+)', re.MULTILINE)
MIXIN_RE = re.compile(r'^\s*mixin\s+([A-Za-z0-9_]+)', re.MULTILINE)
ENUM_RE = re.compile(r'^\s*enum\s+([A-Za-z0-9_]+)', re.MULTILINE)
FUNC_RE = re.compile(r'^\s*(?:[A-Za-z0-9_<>]+\s+)*([A-Za-z0-9_]+)\s*\([^)]*\)\s*(?:async\s*)?{', re.MULTILINE)
PROBLEM_RE = re.compile(r'//\s*(TODO|FIXME|HACK|ERROR):\s*(.*)', re.IGNORECASE)

def init_db(conn):
    c = conn.cursor()
    c.executescript('''
        DROP TABLE IF EXISTS problems;
        DROP TABLE IF EXISTS symbols;
        DROP TABLE IF EXISTS files;
        DROP TABLE IF EXISTS intents;
        
        CREATE TABLE files (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            path TEXT UNIQUE NOT NULL,
            size INTEGER,
            lines INTEGER
        );
        
        CREATE TABLE symbols (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            file_id INTEGER NOT NULL,
            symbol_type TEXT NOT NULL,
            name TEXT NOT NULL,
            line_number INTEGER,
            FOREIGN KEY (file_id) REFERENCES files (id) ON DELETE CASCADE
        );
        
        CREATE TABLE problems (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            file_id INTEGER NOT NULL,
            issue_type TEXT NOT NULL,
            description TEXT NOT NULL,
            line_number INTEGER,
            FOREIGN KEY (file_id) REFERENCES files (id) ON DELETE CASCADE
        );
        
        CREATE INDEX idx_symbols_name ON symbols(name);
        CREATE INDEX idx_problems_type ON problems(issue_type);

        CREATE TABLE intents (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            enum_name TEXT NOT NULL,
            intent_id TEXT UNIQUE NOT NULL,
            status TEXT NOT NULL, -- 'IMPLEMENTED' | 'PLACEHOLDER' | 'UNMAPPED'
            implementation_class TEXT
        );
        CREATE INDEX idx_intents_status ON intents(status);
    ''')
    conn.commit()

def process_file(file_path: Path, conn):
    rel_path = file_path.relative_to(WORKSPACE_DIR).as_posix()
    stat = file_path.stat()
    
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()
    except Exception as e:
        print(f"Failed to read {rel_path}: {e}")
        return

    lines = content.splitlines()
    c = conn.cursor()
    
    c.execute('INSERT INTO files (path, size, lines) VALUES (?, ?, ?)', (rel_path, stat.st_size, len(lines)))
    file_id = c.lastrowid
    
    symbols = []
    problems = []
    
    for i, line in enumerate(lines, start=1):
        # Extract problems
        prob_match = PROBLEM_RE.search(line)
        if prob_match:
            issue_type = prob_match.group(1).upper()
            description = prob_match.group(2).strip()
            problems.append((file_id, issue_type, description, i))
            continue
            
        # Extract symbols (Classes, Mixins, Enums) - simplistic matching
        cls_match = CLASS_RE.search(line)
        if cls_match:
            symbols.append((file_id, 'CLASS', cls_match.group(1), i))
            continue
            
        mix_match = MIXIN_RE.search(line)
        if mix_match:
            symbols.append((file_id, 'MIXIN', mix_match.group(1), i))
            continue
            
        enum_match = ENUM_RE.search(line)
        if enum_match:
            symbols.append((file_id, 'ENUM', enum_match.group(1), i))
            continue

    c.executemany('INSERT INTO symbols (file_id, symbol_type, name, line_number) VALUES (?, ?, ?, ?)', symbols)
    c.executemany('INSERT INTO problems (file_id, issue_type, description, line_number) VALUES (?, ?, ?, ?)', problems)

def index_ui_intents(conn):
    print("Indexing UI Intents from PrimeCareForm...")
    enum_path = WORKSPACE_DIR / "packages" / "flutter_core" / "lib" / "adapters" / "primecare_form_enum.dart"
    warehouse_path = WORKSPACE_DIR / "packages" / "factory_system" / "primecare_ui" / "lib" / "src" / "warehouse" / "component_warehouse.dart"
    output_json = WORKSPACE_DIR / ".agents" / "ui_intents.json"
    
    if not enum_path.exists() or not warehouse_path.exists():
        print("Warning: Intent or Warehouse file missing. Skipping intent indexing.")
        return

    # Parse Enums
    intents = []
    with open(enum_path, 'r', encoding='utf-8') as f:
        content = f.read()
        matches = re.finditer(r'(\w+)\(\s*\'([\w\s-]+)\'\s*\)', content)
        for m in matches:
            intents.append({'enum_name': m.group(1), 'intent_id': m.group(2)})

    def to_snake_case(name):
        name = re.sub('(.)([A-Z][a-z]+)', r'\1_\2', name)
        return re.sub('([a-z0-9])([A-Z])', r'\1_\2', name).lower()

    # Parse Warehouse for current status
    with open(warehouse_path, 'r', encoding='utf-8') as f:
        warehouse_content = f.read()

    # Narrow down search to the registry map using a more flexible pattern
    registry_match = re.search(r'static final Map<String, ComponentBuilder> _registry = \{(.*?)\};', warehouse_content, re.DOTALL)
    registry_str = registry_match.group(1) if registry_match else warehouse_content
    
    # Pre-parse all entries in the registry map for O(1) matching
    registry_entries = {}
    # More robust pattern for entries
    for m in re.finditer(r"'([^']+)':\s*(.*?)(?=\n\s*'\w+'|\n\s+\})", registry_str + "\n  }", re.DOTALL):
        key = m.group(1)
        val = m.group(2).rstrip(',').strip()
        registry_entries[key] = val


    data_to_insert = []
    json_output = []
    
    for it in intents:
        # Check both original ID and snake_case variant
        ids_to_check = [it['intent_id'], to_snake_case(it['intent_id'])]
        ids_to_check = list(dict.fromkeys([i for i in ids_to_check if i]))
        
        status = "UNMAPPED"
        impl_class = None
        raw_value = None

        for check_id in ids_to_check:
            if check_id in registry_entries:
                raw_value = registry_entries[check_id]
                status = "PLACEHOLDER" if "placeholder" in raw_value.lower() else "IMPLEMENTED"
                
                # Extract class name from arrow function: (c, p) => ClassName(...)
                class_match = re.search(r'=>\s*(?:const\s+)?([A-Za-z0-9_]+)', raw_value)
                if class_match:
                    impl_class = class_match.group(1)
                else:
                    # Direct function name or fallback
                    impl_class = raw_value.split('(')[0].strip()
                break

        data_to_insert.append((it['enum_name'], it['intent_id'], status, impl_class))
        json_output.append({
            "enumName": it['enum_name'],
            "intentId": it['intent_id'],
            "status": status,
            "implementationClass": impl_class,
            "mappedId": check_id if status != "UNMAPPED" else None
        })


    c = conn.cursor()
    c.executemany('INSERT INTO intents (enum_name, intent_id, status, implementation_class) VALUES (?, ?, ?, ?)', data_to_insert)
    conn.commit()
    
    import json
    with open(output_json, 'w', encoding='utf-8') as f:
        json.dump(json_output, f, indent=2)
        
    print(f"Indexed {len(data_to_insert)} UI Intents. Exported to {output_json}")


def build_index():
    print(f"Building codebase index at {DB_PATH} ...")
    
    os.makedirs(DB_PATH.parent, exist_ok=True)
    conn = sqlite3.connect(DB_PATH)
    init_db(conn)
    
    file_count = 0
    for root, dirs, files in os.walk(WORKSPACE_DIR):
        # Skip hidden/unwanted directories
        dirs[:] = [d for d in dirs if not d.startswith('.') and d not in ['build', 'web', 'ios', 'android', 'macos', 'windows', 'linux']]
        for file in files:
            if file.endswith('.dart'):
                file_path = Path(root) / file
                process_file(file_path, conn)
                file_count += 1
                
    index_ui_intents(conn)
    conn.commit()
    conn.close()
    print(f"Successfully indexed {file_count} Dart files!")

if __name__ == '__main__':
    build_index()
