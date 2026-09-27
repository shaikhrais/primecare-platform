import re

def main():
    content = open('tools/governance/d1_schema.sql', encoding='utf-8').read()
    inserts = re.findall(r'INSERT INTO screens\s*\((.*?)\)\s*VALUES\s*\((.*?)\);', content)
    
    total = len(inserts)
    has_route = 0
    cypress_ready = 0
    route_and_ready = 0
    
    for cols_str, vals_str in inserts:
        # Simple split on commas, but handles quotes roughly
        cols = [c.strip().replace('"', '') for c in cols_str.split(',')]
        # Split values (note: does not handle nested commas inside json/strings perfectly but good enough for route_path column)
        # Instead, let's find the exact indices
        vals = []
        # Parse SQL values list
        current = []
        in_string = False
        string_char = None
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
            
        # Map column to value
        row = dict(zip(cols, vals))
        
        route = row.get('route_path', 'NULL')
        ready = row.get('cypress_ready', '0')
        
        is_route_ok = (route != 'NULL' and route != "''" and route != '""')
        is_ready = (ready == '1')
        
        if is_route_ok:
            has_route += 1
        if is_ready:
            cypress_ready += 1
        if is_route_ok and is_ready:
            route_and_ready += 1
            
    print(f"Total inserts: {total}")
    print(f"Has route path: {has_route}")
    print(f"Cypress ready: {cypress_ready}")
    print(f"Route and Cypress ready: {route_and_ready}")

if __name__ == '__main__':
    main()
