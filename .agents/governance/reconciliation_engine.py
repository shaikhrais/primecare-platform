import os
import sys
import sqlite3
import re
import json

# Add current folder to path to import governance_db
sys.path.append(os.path.dirname(os.path.abspath(__file__)))
import governance_db

def reconcile():
    print("Starting SQL-Backed PrimeCare Reconciliation Engine...")
    
    schema_path = 'packages/database/generated/client/schema.prisma'
    report_path = '.agents/governance/reconciliation_report.md'
    
    schema_str = ''
    if os.path.exists(schema_path):
        with open(schema_path, 'r', encoding='utf-8') as sf:
            schema_str = sf.read()
            
    conn = governance_db.get_connection()
    cursor = conn.cursor()
    
    # 1. Load Intents
    cursor.execute("SELECT intent_id, status FROM intents;")
    intent_rows = cursor.fetchall()
    intents = {row['intent_id']: row['status'] for row in intent_rows}
    
    # 2. Load Pages
    cursor.execute("SELECT page_id, linked_intent, implementation_status, actions FROM pages;")
    page_rows = cursor.fetchall()
    pages = {row['page_id']: dict(row) for row in page_rows}
    
    # 3. Load Fields
    cursor.execute("""
    SELECT field_id, page_id, linked_intent, validation, api_endpoint, 
           service_method, database_table, database_column, status 
    FROM fields;
    """)
    field_rows = cursor.fetchall()
    fields = [dict(row) for row in field_rows]
    
    db_changed = False
    
    # 4. Auto-Verify Pending Fields
    for fd in fields:
        if fd['status'] == 'pending':
            table = fd['database_table'] or ''
            column = fd['database_column'] or ''
            page_id = fd['page_id'] or ''
            field_id = fd['field_id']
            
            # Database Schema Verification
            db_verified = False
            if table == 'UNMAPPED_SYNC' or not table:
                db_verified = True
            else:
                pattern = r'model\s+' + re.escape(table) + r'\s*\{([\s\S]*?)\}'
                match = re.search(pattern, schema_str)
                if match and re.search(r'\b' + re.escape(column) + r'\b', match.group(1)):
                    db_verified = True
            
            # UI Widget Verification
            ui_verified = False
            if page_id:
                paths_to_check = [
                    f'packages/primecare_ui/lib/src/components/forms/generated/{page_id}.dart',
                    f'packages/primecare_ui/lib/src/components/forms/domain_forms/{page_id}.dart',
                    f'packages/primecare_ui/lib/src/screens/auth/{page_id}.dart'
                ]
                for path in paths_to_check:
                    if os.path.exists(path):
                        with open(path, 'r', encoding='utf-8') as pf:
                            if field_id in pf.read():
                                ui_verified = True
                                break
                                
            if db_verified and ui_verified:
                fd['status'] = 'verified'
                cursor.execute("UPDATE fields SET status = 'verified' WHERE field_id = ?;", (field_id,))
                db_changed = True
                
                # Check/verify parent Page
                if page_id in pages and pages[page_id]['implementation_status'] == 'pending':
                    pages[page_id]['implementation_status'] = 'verified'
                    cursor.execute("UPDATE pages SET implementation_status = 'verified' WHERE page_id = ?;", (page_id,))
                    
                # Check/verify parent Intent
                linked_intent = fd['linked_intent']
                if linked_intent in intents and intents[linked_intent] == 'pending':
                    intents[linked_intent] = 'verified'
                    cursor.execute("UPDATE intents SET status = 'verified' WHERE intent_id = ?;", (linked_intent,))
                    
    if db_changed:
        conn.commit()
        
    # 5. Compile Global Statistics
    total_intents = len(intents)
    total_pages = len(pages)
    total_fields = len(fields)
    
    report = []
    report.append('# PrimeCare Feature Reconciliation Report\n')
    report.append('## Global Statistics')
    report.append(f'- **Total Registered Intents:** {total_intents}')
    report.append(f'- **Total Registered Pages:** {total_pages}')
    report.append(f'- **Total Tracked Fields:** {total_fields}\n')
    report.append('## Anomalies & Orphaned Components')
    
    has_errors = False
    has_anomalies = False
    
    # 6. Check Page Anomalies
    for page_id, pg in pages.items():
        linked_intent = pg['linked_intent']
        if linked_intent and linked_intent not in intents:
            report.append(f'- **[ERROR]** Page `{page_id}` references unknown intent: `{linked_intent}`')
            has_errors = True
            has_anomalies = True
            
        # Check if Page requires fields
        actions = json.loads(pg['actions']) if pg['actions'] else []
        page_requires_fields = any(a in ('submit', 'save') for a in actions) or page_id.endswith('_form')
        
        # Check if there are any fields for this page
        page_fields = [f for f in fields if f['page_id'] == page_id]
        if page_requires_fields and not page_fields and pg['implementation_status'] != 'pending':
            report.append(f'- **[WARNING]** Form Page `{page_id}` exists but has no mapped data entry fields.')
            has_anomalies = True
            
    # 7. Zero-Trust Physical File Check
    all_dart_files = set()
    for root, _, filenames in os.walk('packages/primecare_ui/lib'):
        for name in filenames:
            if name.endswith('.dart'):
                all_dart_files.add(name)
    for root, _, filenames in os.walk('apps'):
        for name in filenames:
            if name.endswith('.dart'):
                all_dart_files.add(name)
                
    for page_id, pg in pages.items():
        # Exclude synthetic stub pages like UNMAPPED_SYNC
        if page_id == 'UNMAPPED_SYNC':
            continue
            
        expected_file = f"{page_id}.dart"
        if expected_file not in all_dart_files and pg['implementation_status'] != 'pending':
            report.append(f'- **[ERROR]** Zero-Trust Audit Failed: Page `{page_id}` is registered in governance but has NO physical `{expected_file}` file anywhere in code.')
            has_errors = True
            has_anomalies = True
            
    # 8. Check Field Anomalies
    for fd in fields:
        intent = fd['linked_intent']
        status = fd['status']
        if intent != 'UNMAPPED_SYNC' and intent and intent not in intents:
            report.append(f"- **[ERROR]** Field `{fd['field_id']}` references unknown intent: `{intent}`")
            has_errors = True
            has_anomalies = True
            
        if status == 'pending':
            report.append(f"- **[INFO]** Feature Mapping Pending Code Verification: Field `{fd['field_id']}` for Page `{fd['page_id']}`. Reasons: Database Column Missing in Schema OR UI Widget missing in Component.")
            has_anomalies = True
            
    if not has_anomalies:
        report.append('All components are fully synchronized. Zero orphans or mismatched intents detected.')
        
    report.append('\n## Planned VS Actual Implementation')
    report.append('| Field ID | Page | API Endpoint | DB Table | Status |')
    report.append('|----------|------|--------------|----------|--------|')
    for fd in fields:
        report.append(f"| `{fd['field_id']}` | `{fd['page_id'] or ''}` | `{fd['api_endpoint'] or ''}` | `{fd['database_table'] or ''}` | `{fd['status']}` |")
        
    # Write reconciliation report
    with open(report_path, 'w', encoding='utf-8') as f:
        f.write('\n'.join(report))
        
    conn.close()
    
    print(f"Reconciliation complete! Report generated at: {report_path}")
    
    if has_errors:
        print("GOVERNANCE FAILURE: Errors detected in architectural integrity! Please fix before committing.")
        sys.exit(1)
    elif has_anomalies:
        print("GOVERNANCE WARNING: Anomalies/Pending features detected, but no critical structural errors. Commit allowed.")
        sys.exit(0)
    else:
        print("Architectural Integrity Verified.")
        sys.exit(0)

if __name__ == "__main__":
    reconcile()
