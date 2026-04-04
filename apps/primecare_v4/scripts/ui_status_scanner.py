import os
import re
import json
import csv
from datetime import datetime

# Configuration
SOURCE_DIR = r"c:\Users\Admin2\Documents\GitHub\primecare-platform\apps\primecare_v4\lib"
OUTPUT_DIR = r"c:\Users\Admin2\Documents\GitHub\primecare-platform\apps\primecare_v4\reports"

# Regex Patters
# We look for standard Flutter interactive widgets
INTERACTIVE_PATTERN = re.compile(r'(ElevatedButton|IconButton|TextButton|InkWell|GestureDetector|OutlinedButton|ListTile|FloatingActionButton)\s*\(|GoRouter\.of\(context\)\.(push|go)\(|context\.(push|go)\(')
KEY_INJECTION_PATTERN = re.compile(r'(ElevatedButton|IconButton|TextButton|InkWell|GestureDetector|OutlinedButton|ListTile|FloatingActionButton)\s*\(')

PLACEHOLDER_WORDS = ["todo", "coming soon", "dummy", "placeholder", "mock", "lorem ipsum"]

class ComponentStatus:
    IMPLEMENTED = "implemented"
    UI_ONLY = "ui_only"
    PLACEHOLDER = "placeholder"
    NOT_WIRED = "not_wired"
    MISSING_ROUTE = "missing_route"
    MISSING_API = "missing_api"
    DISABLED = "disabled"
    PARTIAL = "partial"

def get_hierarchy(filepath):
    """
    Returns (Office, Role, Screen) based on primecare_v4 folder structure
    Example: lib/offices/franchise/roles/franchise_owner/owner_dashboard.dart
    -> Office: Franchise, Role: Franchise Owner, Screen: Owner Dashboard
    """
    parts = filepath.replace('\\', '/').split('/')
    office = "Shared"
    role = "Global"
    screen = parts[-1].replace('.dart', '').replace('_', ' ').title()
    
    if 'offices' in parts:
        idx = parts.index('offices')
        if len(parts) > idx + 1:
            office = parts[idx + 1].replace('_', ' ').title()
        if 'roles' in parts:
            role_idx = parts.index('roles')
            if len(parts) > role_idx + 1:
                role = parts[role_idx + 1].replace('_', ' ').title()
    
    # Generate a tight prefix ID
    short_office = office.split(' ')[0].lower()
    short_role = role.split(' ')[0].lower()
    short_screen = parts[-1].replace('.dart', '').split('_')[0].lower()
    
    prefix_id = f"{short_office}-{short_role}-{short_screen}"
    return office, role, screen, prefix_id

def analyze_and_inject(filepath, auto_inject=True):
    try:
        with open(filepath, 'r', encoding='utf-8') as f:
            content = f.read()
    except:
        return []
        
    components = []
    office, role, screen_name, prefix_id = get_hierarchy(filepath)
    
    # Check screen placebo
    file_status = None
    lower_content = content.lower()
    for word in PLACEHOLDER_WORDS:
        if word in lower_content:
            file_status = ComponentStatus.PLACEHOLDER
            break
            
    lines = content.split('\n')
    modified_lines = list(lines)
    made_changes = False
    
    button_counter = 1
    
    for i, line in enumerate(lines):
        if INTERACTIVE_PATTERN.search(line):
            # Extract basic context
            chunk = " ".join(lines[i:min(i+10, len(lines))])
            
            # Identify label
            label = "Interactive Element"
            text_match = re.search(r"child:\s*Text\s*\(['\"](.*?)['\"]", chunk)
            if text_match:
                label = text_match.group(1)
            elif 'icon:' in chunk:
                label = "Icon Button"
                
            # Assign Unique Component ID
            component_id = f"{prefix_id}-action-{button_counter}"
            button_counter += 1
            
            # Inject data-status-id equivalent (Key in Flutter)
            if auto_inject and KEY_INJECTION_PATTERN.search(line):
                if 'key: Key(' not in chunk and 'key: const Key(' not in chunk:
                    # We inject key: const Key('data-status-id=xxx'),
                    injection_str = f"key: const Key('data-status-id={component_id}'), "
                    # Find the exact widget instantiation line and add the key right after the opening parenthesis
                    modified_lines[i] = KEY_INJECTION_PATTERN.sub(r'\1(' + injection_str, modified_lines[i], count=1)
                    made_changes = True

            # Determine Action / Status
            expected_action = "Navigate or Trigger Logic"
            actual_behavior = ""
            status = ComponentStatus.IMPLEMENTED
            notes = "Wired"
            
            if 'context.go' in chunk or 'context.push' in chunk:
                route_match = re.search(r"context\.(?:go|push)\(['\"](.*?)['\"]", chunk)
                actual_behavior = f"Navigates to {route_match.group(1) if route_match else 'dynamic route'}"
                if 'todo' in (route_match.group(1).lower() if route_match else ''):
                    status = ComponentStatus.PLACEHOLDER
                    notes = "Route points to placeholder"
            else:
                tap_match = re.search(r'(?:onPressed|onTap)\s*:\s*(.*?)(?:,|\]|\)|$)', chunk)
                if tap_match:
                    handler = tap_match.group(1).strip()
                    if handler in ['null', '() {}', '(context) {}', '() => {}']:
                        status = ComponentStatus.NOT_WIRED
                        actual_behavior = "Empty Callback"
                        notes = "Missing logic"
                    elif handler.startswith('print(') or 'print(' in chunk[:100]:
                        status = ComponentStatus.NOT_WIRED
                        actual_behavior = "Logs to console only"
                        notes = "Console print placeholder"
                    elif '// TODO' in chunk:
                        status = ComponentStatus.PARTIAL
                        actual_behavior = "Contains TODO comment"
                        notes = "Incomplete"
                    else:
                        actual_behavior = "Executes defined logic"
                        if 'mock' in handler.lower():
                            status = ComponentStatus.PLACEHOLDER
                            notes = "Uses mock API call"
                else:
                    status = ComponentStatus.UI_ONLY
                    actual_behavior = "No tap handler defined"
                    notes = "Visual only"

            if file_status == ComponentStatus.PLACEHOLDER and status == ComponentStatus.IMPLEMENTED:
                status = ComponentStatus.PLACEHOLDER
                notes = "Screen contains dummy data"
                
            components.append({
                "office": office,
                "role": role,
                "screen": screen_name,
                "component": component_id,
                "type": "Action/Navigation",
                "label": label,
                "expected_behavior": expected_action,
                "actual_behavior": actual_behavior,
                "status": status,
                "notes": notes,
                "filepath": filepath
            })
            
    if made_changes and auto_inject:
        # Write back injected keys, conditionally adding the flutter material import if Key is used
        new_content = '\n'.join(modified_lines)
        if "package:flutter/material.dart" not in new_content and "package:flutter/widgets.dart" not in new_content:
            new_content = "import 'package:flutter/material.dart';\n" + new_content
            
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(new_content)
            
    return components

def generate_html_report(data, filename):
    total = len(data)
    implemented = len([d for d in data if d['status'] == 'implemented'])
    not_wired = len([d for d in data if d['status'] == 'not_wired'])
    partial = len([d for d in data if d['status'] == 'partial'])
    placeholder = len([d for d in data if d['status'] == 'placeholder'])
    ui_only = len([d for d in data if d['status'] == 'ui_only'])

    html = f"""
    <html>
    <head>
        <title>PrimeCare UI Implementation Report</title>
        <style>
            body {{ font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; padding: 30px; background: #f0f2f5; color: #1c1e21; }}
            h1 {{ border-bottom: 2px solid #1877f2; padding-bottom: 10px; display: inline-block; }}
            .summary-container {{ display: flex; flex-wrap: wrap; gap: 20px; margin-bottom: 40px; }}
            .card {{ background: white; padding: 20px; border-radius: 12px; box-shadow: 0 4px 6px rgba(0,0,0,0.05); min-width: 140px; text-align: center; border-top: 4px solid #ddd; }}
            .card h3 {{ margin: 0; color: #65676b; font-size: 14px; text-transform: uppercase; letter-spacing: 1px; }}
            .card h2 {{ margin: 10px 0 0 0; font-size: 32px; }}
            .card.total {{ border-color: #1877f2; }}
            .card.implemented {{ border-color: #31a24c; }}
            .card.not-wired {{ border-color: #e41e3f; }}
            .card.placeholder {{ border-color: #f1a817; }}
            .card.partial {{ border-color: #2b5db6; }}
            
            table {{ width: 100%; border-collapse: collapse; background: white; border-radius: 12px; overflow: hidden; box-shadow: 0 4px 6px rgba(0,0,0,0.05); }}
            th, td {{ padding: 15px; text-align: left; border-bottom: 1px solid #e4e6eb; font-size: 14px; }}
            th {{ background-color: #f7f8fa; font-weight: 600; color: #65676b; text-transform: uppercase; font-size: 12px; letter-spacing: 0.5px; }}
            tr:hover {{ background-color: #f0f2f5; }}
            
            .badge {{ font-weight: 600; padding: 6px 10px; border-radius: 20px; font-size: 12px; display: inline-block; }}
            .badge-implemented {{ color: #1e4620; background: #d3fbe0; }}
            .badge-not_wired {{ color: #79101d; background: #ffe4e8; }}
            .badge-placeholder {{ color: #704700; background: #fff1d6; }}
            .badge-partial {{ color: #122b5e; background: #dce7ff; }}
            .badge-ui_only {{ color: #4b4c4f; background: #e4e6eb; }}
            
            .hierarchy {{ color: #65676b; font-size: 12px; }}
        </style>
    </head>
    <body>
        <h1>PrimeCare Action Manifest & Component Status</h1>
        <p><strong>Generated:</strong> {datetime.now().strftime("%Y-%m-%d %H:%M:%S")}</p>
        
        <div class="summary-container">
            <div class="card total"><h3>Total Actions</h3><h2>{total}</h2></div>
            <div class="card implemented"><h3>Implemented</h3><h2 style="color:#31a24c;">{implemented}</h2></div>
            <div class="card not-wired"><h3>Missing/Not Wired</h3><h2 style="color:#e41e3f;">{not_wired}</h2></div>
            <div class="card partial"><h3>Partial</h3><h2 style="color:#2b5db6;">{partial}</h2></div>
            <div class="card placeholder"><h3>Placeholder/Dummy</h3><h2 style="color:#f1a817;">{placeholder}</h2></div>
        </div>

        <table>
            <tr>
                <th>Hierarchy (Office > Role > Screen)</th>
                <th>Component ID</th>
                <th>Label / Target</th>
                <th>Expected Behavior</th>
                <th>Actual Behavior</th>
                <th>Status</th>
                <th>Developer Notes</th>
            </tr>
    """
    for entry in sorted(data, key=lambda x: x['status']):
        html += f"""
            <tr>
                <td><div class="hierarchy">{entry['office']} &gt; {entry['role']} &gt;<br><strong>{entry['screen']}</strong></div></td>
                <td><code>{entry['component']}</code></td>
                <td>{entry['label']}</td>
                <td>{entry['expected_behavior']}</td>
                <td>{entry['actual_behavior']}</td>
                <td><span class="badge badge-{entry['status']}">{entry['status']}</span></td>
                <td>{entry['notes']}</td>
            </tr>
        """
        
    html += """
        </table>
    </body>
    </html>
    """
    with open(filename, 'w', encoding='utf-8') as f:
        f.write(html)

def main():
    os.makedirs(OUTPUT_DIR, exist_ok=True)
    all_components = []
    
    print(f"Executing Deep Component Scan and Auto-Injection on: {SOURCE_DIR}")
    for root, _, files in os.walk(SOURCE_DIR):
        for file in files:
            if file.endswith('.dart'):
                filepath = os.path.join(root, file)
                # auto_inject=True allows the script to inject Flutter Keys
                all_components.extend(analyze_and_inject(filepath, auto_inject=True))
                
    # 1. Component Status Registry
    registry_path = os.path.join(OUTPUT_DIR, 'component-status-registry.json')
    with open(registry_path, 'w', encoding='utf-8') as f:
        json.dump(all_components, f, indent=2)
        
    # 2. Action Manifest
    actions = [c for c in all_components if 'Action' in c['type']]
    manifest_path = os.path.join(OUTPUT_DIR, 'action-manifest.json')
    with open(manifest_path, 'w', encoding='utf-8') as f:
        json.dump(actions, f, indent=2)
        
    # 3. Missing Actions CSV
    missing = [c for c in all_components if c['status'] in ['not_wired', 'placeholder', 'ui_only', 'missing_api', 'missing_route']]
    csv_path = os.path.join(OUTPUT_DIR, 'missing-actions.csv')
    with open(csv_path, 'w', newline='', encoding='utf-8') as f:
        writer = csv.DictWriter(f, fieldnames=[
            "office", "role", "screen", "component", "type", "label", 
            "expected_behavior", "actual_behavior", "status", "notes", "filepath"
        ])
        writer.writeheader()
        writer.writerows(missing)
        
    # 4. Status Report HTML
    html_path = os.path.join(OUTPUT_DIR, 'implementation-report.html')
    generate_html_report(all_components, html_path)
    
    print(f"\\n--- PrimeCare Scan Complete ---")
    print(f"Total Interactive Elements Tracked: {len(all_components)}")
    print(f"Missing/Incomplete Items: {len(missing)}")
    print(f"Reports successfully generated to: {OUTPUT_DIR}")

if __name__ == '__main__':
    main()
