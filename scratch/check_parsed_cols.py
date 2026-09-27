import re

def parse_create_table_cols(create_table_str):
    match = re.search(r'CREATE TABLE \w+\s*\((.*?)\);', create_table_str, re.DOTALL)
    if not match:
        return []
    inner = match.group(1)
    parts = []
    current = []
    depth = 0
    in_string = False
    string_char = None
    for char in inner:
        if char in ("'", '"'):
            if not in_string:
                in_string = True
                string_char = char
            elif string_char == char:
                in_string = False
        elif char == '(' and not in_string:
            depth += 1
        elif char == ')' and not in_string:
            depth -= 1
        elif char == ',' and depth == 0 and not in_string:
            parts.append("".join(current).strip())
            current = []
            continue
        current.append(char)
    if current:
        parts.append("".join(current).strip())
    columns = []
    for p in parts:
        p_upper = p.upper()
        if not p or p_upper.startswith(('PRIMARY', 'FOREIGN', 'UNIQUE', 'KEY', 'CONSTRAINT')):
            continue
        tokens = p.split()
        if not tokens:
            continue
        col_name = tokens[0].replace('"', '').replace('`', '').strip()
        col_type = " ".join(tokens[1:]).strip()
        columns.append((col_name, col_type))
    return columns

def main():
    content = open('tools/governance/d1_schema.sql', encoding='utf-8').read()
    match = re.search(r'CREATE TABLE roles\s*\(.*?\);', content, re.DOTALL)
    if match:
        cols = parse_create_table_cols(match.group(0))
        print("Parsed columns:", [c[0] for c in cols])
        print("Full details of parsed columns:")
        for c in cols:
            print(" ", c)

if __name__ == '__main__':
    main()
