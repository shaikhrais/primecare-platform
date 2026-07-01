import os
import sys
import subprocess

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
SCHEMA_PATH = os.path.join(PROJECT_ROOT, "tools", "governance", "d1_schema.sql")
DATABASE_NAME = "primecare-governance-db"

def run_command(cmd):
    result = subprocess.run(cmd, capture_output=True, text=True, encoding="utf-8", errors="ignore", shell=True)
    return result

def split_sql(sql):
    statements = []
    current = []
    in_string = False
    escape = False
    for char in sql:
        if escape:
            current.append(char)
            escape = False
            continue
        if char == '\\':
            current.append(char)
            escape = True
            continue
        if char == "'":
            in_string = not in_string
            current.append(char)
            continue
        if char == ';' and not in_string:
            statements.append(''.join(current).strip())
            current = []
            continue
        current.append(char)
    if current:
        stmt = ''.join(current).strip()
        if stmt:
            statements.append(stmt)
    return statements

def main():
    print("==============================================================")
    print("IMPORTING D1 SCHEMA VIA QUERY COMMAND BATCHING")
    print("==============================================================")

    if not os.path.exists(SCHEMA_PATH):
        print(f"Error: Schema file not found at {SCHEMA_PATH}")
        sys.exit(1)

    print("Reading and parsing schema file...")
    with open(SCHEMA_PATH, "r", encoding="utf-8") as f:
        sql_content = f.read()

    # Strip comments and empty lines
    lines = []
    for line in sql_content.splitlines():
        trimmed = line.strip()
        if trimmed.startswith("--") or trimmed.startswith("//"):
            continue
        lines.append(line)
    clean_sql = "\n".join(lines)

    all_statements = split_sql(clean_sql)
    # Remove any empty statements
    all_statements = [s for s in all_statements if s]
    
    print(f"Parsed {len(all_statements)} SQL statements.")

    # Batch statements up to 5KB or 10 statements per batch
    batches = []
    current_batch = []
    current_length = 0
    
    for stmt in all_statements:
        stmt_len = len(stmt.encode("utf-8"))
        if len(current_batch) >= 10 or (current_length + stmt_len > 5000):
            batches.append(current_batch)
            current_batch = [stmt]
            current_length = stmt_len
        else:
            current_batch.append(stmt)
            current_length += stmt_len
    if current_batch:
        batches.append(current_batch)

    print(f"Grouped into {len(batches)} batches.")

    for i, batch in enumerate(batches):
        print(f"Executing batch {i+1}/{len(batches)} ({len(batch)} statements)...")
        combined_sql = ";\n".join(batch) + ";"
        
        # Escape double quotes for shell/cmd if running on Windows
        # We run wrangler programmatically passing arguments in an array instead of shell=True
        # This is MUCH safer and avoids all quote escaping issues!
        
        wrangler_path = os.path.join(PROJECT_ROOT, "node_modules", "wrangler", "bin", "wrangler.js")
        cmd_args = ["node", wrangler_path, "d1", "execute", DATABASE_NAME, f"--command={combined_sql}", "--remote", "--yes"]
        
        # Run subprocess without shell to preserve arguments exactly
        res = subprocess.run(cmd_args, capture_output=True, text=True, encoding="utf-8", errors="ignore")
        
        if res.returncode != 0:
            print(f"ERROR in batch {i+1}:")
            print("STDOUT:", res.stdout.encode('ascii', errors='replace').decode('ascii'))
            print("STDERR:", res.stderr.encode('ascii', errors='replace').decode('ascii'))
            sys.exit(1)
        else:
            print(f"Batch {i+1} executed successfully.")

    print("==============================================================")
    print("D1 SCHEMA IMPORT COMPLETED SUCCESSFULLY!")
    print("==============================================================")

if __name__ == '__main__':
    main()
