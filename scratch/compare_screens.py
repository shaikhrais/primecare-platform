import sqlite3
import re

def main():
    conn = sqlite3.connect('.agents/governance/governance.db')
    cur = conn.cursor()
    local_names = {r[0]: r[1] for r in cur.execute('select id, screen_name from screens').fetchall()}
    conn.close()
    
    sql_content = open('tools/governance/d1_schema.sql', encoding='utf-8').read()
    # Find all screen inserts
    inserts = re.findall(r'INSERT INTO screens\s*\((.*?)\)\s*VALUES\s*\((.*?)\);', sql_content)
    
    sql_names = {}
    for cols_str, vals_str in inserts:
        # Simple parsing
        current = []
        in_string = False
        string_char = None
        vals = []
        for char in vals_str:
            if char in ("'", '"'):
                if not in_string:
                    in_string = True
                    string_char = char
                elif string_char == char:
                    in_string = False
            elif char == ',' and not in_string:
                vals.append("".join(current).strip())
                current = []
                continue
            current.append(char)
        if current:
            vals.append("".join(current).strip())
            
        cols = [c.strip().replace('"', '') for c in cols_str.split(',')]
        row = dict(zip(cols, vals))
        
        scr_id = int(row['id'])
        scr_name = row['screen_name'].replace("'", "").replace('"', '')
        sql_names[scr_id] = scr_name
        
    matching = 0
    mismatches = []
    for s_id, name in local_names.items():
        if s_id in sql_names:
            if sql_names[s_id] == name:
                matching += 1
            else:
                mismatches.append((s_id, name, sql_names[s_id]))
                
    print(f"Local screens count: {len(local_names)}")
    print(f"SQL screens count: {len(sql_names)}")
    print(f"Matching screens by ID and name: {matching}")
    if mismatches:
        print(f"Mismatches: {mismatches[:5]}")

if __name__ == '__main__':
    main()
