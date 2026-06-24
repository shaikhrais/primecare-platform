import sqlite3
import os
import re

db_path = r"C:\Users\Admin2\Documents\GitHub\primecare-platform\.agents\governance\governance.db"
project_root = r"C:\Users\Admin2\Documents\GitHub\primecare-platform"

# Value mappings for progress calculation
design_map = {
    'DESIGN_NOT_STARTED': 0.0,
    'DESIGN_STARTED': 0.5,
    'DESIGN_APPROVED': 1.0
}

html_map = {
    'HTML_EMPTY': 0.0,
    'HTML_DEFAULT': 0.25,
    'HTML_LAYOUT_DONE': 0.75,
    'HTML_RESPONSIVE_DONE': 1.0
}

comp_map = {
    'COMP_MISSING': 0.0,
    'COMP_BASIC': 0.5,
    'COMP_REUSABLE': 0.75,
    'COMP_FINAL': 1.0
}

logic_map = {
    'LOGIC_NONE': 0.0,
    'LOGIC_PARTIAL': 0.5,
    'LOGIC_WORKING': 0.75,
    'LOGIC_CLEAN': 1.0
}

api_map = {
    'API_NONE': 0.0,
    'API_MOCK': 0.5,
    'API_CONNECTED': 0.75,
    'API_ERROR_HANDLED': 1.0
}

db_map = {
    'DB_NONE': 0.0,
    'DB_QUERY_READY': 0.5,
    'DB_SAVE_WORKING': 0.75,
    'DB_FULLY_CONNECTED': 1.0
}

val_map = {
    'VALIDATION_NONE': 0.0,
    'VALIDATION_BASIC': 0.5,
    'VALIDATION_FULL': 1.0
}

qa_map = {
    'QA_NOT_STARTED': 0.0,
    'QA_FAILED': 0.0,
    'QA_PASSED': 1.0
}

def calculate_progress(values):
    p_design = design_map.get(values['design_stage'], 0.0) * 10
    p_html = html_map.get(values['html_stage'], 0.0) * 15
    p_comp = comp_map.get(values['component_stage'], 0.0) * 15
    p_logic = logic_map.get(values['logic_stage'], 0.0) * 15
    p_api = api_map.get(values['api_stage'], 0.0) * 15
    p_db = db_map.get(values['db_stage'], 0.0) * 10
    p_val = val_map.get(values['validation_stage'], 0.0) * 10
    p_qa = qa_map.get(values['qa_stage'], 0.0) * 10
    
    total = p_design + p_html + p_comp + p_logic + p_api + p_db + p_val + p_qa
    return int(round(total))

def update_file_header(file_path, screen_code, values):
    header = f"""/* 
PRIME:SCREEN={screen_code}
PRIME:DESIGN={values['design_stage']}
PRIME:HTML={values['html_stage']}
PRIME:COMP={values['component_stage']}
PRIME:LOGIC={values['logic_stage']}
PRIME:API={values['api_stage']}
PRIME:DB={values['db_stage']}
PRIME:VALIDATION={values['validation_stage']}
PRIME:QA={values['qa_stage']}
PRIME:FINAL={values['final_stage']}
PRIME:PROGRESS={values['progress_percent']}
PRIME:BLOCKER={values['blocker'] or ''}
PRIME:NEXT_ACTION={values['next_action'] or ''}
*/
"""
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()

    # Check if a PRIME header already exists
    if "PRIME:SCREEN" in content:
        new_content = re.sub(r'/\*\s*\n\s*PRIME:SCREEN.*?\*/\s*\n?', header, content, flags=re.DOTALL)
    else:
        new_content = header + content

    with open(file_path, 'w', encoding='utf-8') as f:
        f.write(new_content)

def main():
    if not os.path.exists(db_path):
        print("DB not found at:", db_path)
        exit(1)
        
    conn = sqlite3.connect(db_path)
    conn.row_factory = sqlite3.Row
    cursor = conn.cursor()
    
    # 1. Fetch screens and their current governance stages
    cursor.execute("""
        SELECT s.id, s.screen_name, s.screen_code, s.actual_file_path,
               (SELECT current_stage FROM screen_governance g WHERE g.file_path = s.actual_file_path OR g.screen_name = s.screen_name LIMIT 1) AS current_stage
        FROM screens s
    """)
    rows = cursor.fetchall()
    print(f"Fetched {len(rows)} screens from screens table.")
    
    updated_count = 0
    for row in rows:
        file_path = row['actual_file_path']
        if not file_path:
            continue
            
        full_path = os.path.join(project_root, file_path.replace("/", os.sep))
        if not os.path.exists(full_path):
            continue
            
        screen_code = row['screen_code'] or row['screen_name'].replace(" ", "")
        
        # Read file to check if it already has headers
        with open(full_path, 'r', encoding='utf-8') as f:
            content = f.read()
            
        # Default values
        values = {
            'design_stage': 'DESIGN_NOT_STARTED',
            'html_stage': 'HTML_NOT_STARTED',
            'component_stage': 'COMP_MISSING',
            'logic_stage': 'LOGIC_NONE',
            'api_stage': 'API_NONE',
            'db_stage': 'DB_NONE',
            'validation_stage': 'VALIDATION_NONE',
            'qa_stage': 'QA_NOT_STARTED',
            'final_stage': 'FINAL_NOT_READY',
            'progress_percent': 0,
            'blocker': '',
            'next_action': ''
        }
        
        # Check if file has header
        has_header = "PRIME:SCREEN" in content
        if has_header:
            # Parse existing values
            for line in content.split('\n'):
                if 'PRIME:' in line:
                    parts = line.strip().replace('PRIME:', '').split('=')
                    if len(parts) == 2:
                        key = parts[0].strip().lower()
                        val = parts[1].strip()
                        
                        if key == 'design': values['design_stage'] = val
                        elif key == 'html': values['html_stage'] = val
                        elif key == 'comp': values['component_stage'] = val
                        elif key == 'logic': values['logic_stage'] = val
                        elif key == 'api': values['api_stage'] = val
                        elif key == 'db': values['db_stage'] = val
                        elif key == 'validation': values['validation_stage'] = val
                        elif key == 'qa': values['qa_stage'] = val
                        elif key == 'final': values['final_stage'] = val
                        elif key == 'blocker': values['blocker'] = val
                        elif key == 'next_action': values['next_action'] = val
        else:
            # Seed based on current governance stage
            gov_stage = row['current_stage']
            if gov_stage in ('FINAL_FURNISHED', 'VALIDATED'):
                values['design_stage'] = 'DESIGN_APPROVED'
                values['html_stage'] = 'HTML_RESPONSIVE_DONE'
                values['component_stage'] = 'COMP_FINAL'
                values['logic_stage'] = 'LOGIC_CLEAN'
                values['api_stage'] = 'API_ERROR_HANDLED'
                values['db_stage'] = 'DB_FULLY_CONNECTED'
                values['validation_stage'] = 'VALIDATION_FULL'
                values['qa_stage'] = 'QA_PASSED'
                values['final_stage'] = 'FINAL_FURNISHED'
            elif gov_stage == 'DATA_CONNECTED':
                values['design_stage'] = 'DESIGN_APPROVED'
                values['html_stage'] = 'HTML_LAYOUT_DONE'
                values['component_stage'] = 'COMP_BASIC'
                values['logic_stage'] = 'LOGIC_WORKING'
                values['api_stage'] = 'API_CONNECTED'
                values['db_stage'] = 'DB_QUERY_READY'
                values['validation_stage'] = 'VALIDATION_BASIC'
                values['qa_stage'] = 'QA_NOT_STARTED'
                values['final_stage'] = 'FINAL_NOT_READY'
            elif gov_stage == 'PARTIAL_UI':
                values['design_stage'] = 'DESIGN_STARTED'
                values['html_stage'] = 'HTML_LAYOUT_DONE'
                values['component_stage'] = 'COMP_BASIC'
                values['logic_stage'] = 'LOGIC_PARTIAL'
                values['api_stage'] = 'API_NONE'
                values['db_stage'] = 'DB_NONE'
                values['validation_stage'] = 'VALIDATION_NONE'
                values['qa_stage'] = 'QA_NOT_STARTED'
                values['final_stage'] = 'FINAL_NOT_READY'
            else:
                values['design_stage'] = 'DESIGN_NOT_STARTED'
                values['html_stage'] = 'HTML_DEFAULT'
                values['component_stage'] = 'COMP_MISSING'
                values['logic_stage'] = 'LOGIC_NONE'
                values['api_stage'] = 'API_NONE'
                values['db_stage'] = 'DB_NONE'
                values['validation_stage'] = 'VALIDATION_NONE'
                values['qa_stage'] = 'QA_NOT_STARTED'
                values['final_stage'] = 'FINAL_NOT_READY'

        # Compute progress percent
        values['progress_percent'] = calculate_progress(values)
        
        # Verify final stage constraint: Screen is final only when all criteria are met
        is_fully_complete = (
            values['design_stage'] == 'DESIGN_APPROVED' and
            values['html_stage'] == 'HTML_RESPONSIVE_DONE' and
            values['component_stage'] == 'COMP_FINAL' and
            values['logic_stage'] == 'LOGIC_CLEAN' and
            values['api_stage'] == 'API_ERROR_HANDLED' and
            values['db_stage'] == 'DB_FULLY_CONNECTED' and
            values['validation_stage'] == 'VALIDATION_FULL' and
            values['qa_stage'] == 'QA_PASSED'
        )
        if is_fully_complete:
            values['final_stage'] = 'FINAL_FURNISHED'
            values['progress_percent'] = 100
        
        # Update the file header
        update_file_header(full_path, screen_code, values)
        
        # Update the database
        cursor.execute("""
            UPDATE screens
            SET design_stage = ?,
                html_stage = ?,
                component_stage = ?,
                logic_stage = ?,
                api_stage = ?,
                db_stage = ?,
                validation_stage = ?,
                qa_stage = ?,
                final_stage = ?,
                progress_percent = ?,
                blocker = ?,
                next_action = ?
            WHERE id = ?
        """, (
            values['design_stage'],
            values['html_stage'],
            values['component_stage'],
            values['logic_stage'],
            values['api_stage'],
            values['db_stage'],
            values['validation_stage'],
            values['qa_stage'],
            values['final_stage'],
            values['progress_percent'],
            values['blocker'],
            values['next_action'],
            row['id']
        ))
        updated_count += 1

    conn.commit()
    print(f"Updated {updated_count} screens in files and SQLite db.")

    # 2. Print KPI Dashboard Metrics
    print("\n==========================================")
    print("        PRIME GOVERNANCE KPI DASHBOARD    ")
    print("==========================================")
    
    cursor.execute("SELECT COUNT(*) AS total_screens FROM screens")
    print(f"Total Screens:    {cursor.fetchone()['total_screens']}")
    
    cursor.execute("SELECT COUNT(*) AS final_furnished FROM screens WHERE final_stage = 'FINAL_FURNISHED'")
    print(f"Final Furnished:  {cursor.fetchone()['final_furnished']}")
    
    cursor.execute("SELECT COUNT(*) AS default_code FROM screens WHERE html_stage = 'HTML_DEFAULT'")
    print(f"Default Code:     {cursor.fetchone()['default_code']}")
    
    cursor.execute("SELECT COUNT(*) AS api_missing FROM screens WHERE api_stage IN ('API_NONE', 'API_MOCK')")
    print(f"API Missing:      {cursor.fetchone()['api_missing']}")
    
    cursor.execute("SELECT COUNT(*) AS db_missing FROM screens WHERE db_stage IN ('DB_NONE', 'DB_QUERY_READY')")
    print(f"DB Missing:       {cursor.fetchone()['db_missing']}")
    
    cursor.execute("SELECT COUNT(*) AS qa_failed FROM screens WHERE qa_stage = 'QA_FAILED'")
    print(f"QA Failed:        {cursor.fetchone()['qa_failed']}")
    
    cursor.execute("SELECT COUNT(*) AS blocked_screens FROM screens WHERE blocker IS NOT NULL AND blocker <> ''")
    print(f"Blocked Screens:  {cursor.fetchone()['blocked_screens']}")
    
    cursor.execute("SELECT AVG(progress_percent) AS average_progress FROM screens")
    print(f"Average Progress: {cursor.fetchone()['average_progress']:.2f}%")
    print("==========================================\n")
    
    conn.close()

if __name__ == '__main__':
    main()
