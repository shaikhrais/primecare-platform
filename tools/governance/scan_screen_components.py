import os
import re
import json
import sqlite3
from pathlib import Path
from datetime import datetime

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
DB_PATH = os.path.abspath(os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db"))
REPORT_DIR = os.path.abspath(os.path.join(PROJECT_ROOT, "tools", "governance", "reports"))
Path(REPORT_DIR).mkdir(parents=True, exist_ok=True)

WIDGET_PATTERNS = [
    "Scaffold", "AppBar", "Text", "Card", "Container", "Column", "Row",
    "ListView", "GridView", "DataTable", "Form", "TextFormField",
    "ElevatedButton", "OutlinedButton", "TextButton", "IconButton",
    "DropdownButton", "Checkbox", "Switch", "TabBar", "TabBarView",
    "Dialog", "AlertDialog", "SnackBar"
]

BUTTON_PATTERNS = [
    "ElevatedButton",
    "OutlinedButton",
    "TextButton",
    "IconButton",
    "GestureDetector",
    "InkWell"
]

API_PATTERNS = [
    r"\.get\(",
    r"\.post\(",
    r"\.put\(",
    r"\.patch\(",
    r"\.delete\(",
    r"fetch\(",
    r"http\.",
    r"dio\.",
    r"apiClient\.",
    r"repository\.",
    r"service\."
]

def scan_file(file_path: str):
    abs_path = os.path.join(PROJECT_ROOT, file_path)
    path = Path(abs_path)

    if not path.exists():
        return {
            "file_exists": False,
            "components": [],
            "buttons": [],
            "api_calls": [],
            "data_cy_found": [],
            "problems": ["file_missing"]
        }

    text = path.read_text(encoding="utf-8", errors="ignore")

    components = []
    for widget in WIDGET_PATTERNS:
        count = len(re.findall(rf"\b{widget}\s*\(", text))
        if count:
            components.append({"name": widget, "count": count})

    buttons = []
    for button in BUTTON_PATTERNS:
        count = len(re.findall(rf"\b{button}\s*\(", text))
        if count:
            buttons.append({"name": button, "count": count})

    api_calls = []
    for pattern in API_PATTERNS:
        count = len(re.findall(pattern, text))
        if count:
            api_calls.append({"pattern": pattern, "count": count})

    data_cy_found = re.findall(r'data-cy["\']?\s*[:=]\s*["\']([^"\']+)["\']', text)
    key_found = re.findall(r'Key\s*\(\s*["\']([^"\']+)["\']\s*\)', text)

    # Clean duplicates & trim whitespace
    found_keys = list(set([k.strip() for k in (data_cy_found + key_found) if k.strip()]))

    fake_handlers = len(re.findall(r"onPressed\s*:\s*\(\)\s*\{\s*\}", text))
    null_handlers = len(re.findall(r"onPressed\s*:\s*null|onTap\s*:\s*null", text))

    problems = []
    if fake_handlers:
        problems.append("fake_empty_handlers")
    if null_handlers:
        problems.append("null_handlers")
    if not components:
        problems.append("no_components_found")

    return {
        "file_exists": True,
        "components": components,
        "buttons": buttons,
        "api_calls": api_calls,
        "data_cy_found": found_keys,
        "fake_handler_count": fake_handlers,
        "null_handler_count": null_handlers,
        "problems": problems
    }

def main():
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    cur = conn.cursor()

    screens = cur.execute("""
        SELECT id, screen_name, actual_file_path, required_components_json,
               required_buttons_json, required_apis_json
        FROM screens
        WHERE actual_file_path IS NOT NULL
          AND actual_file_path != ''
    """).fetchall()

    scan_results = []

    for screen in screens:
        result = scan_file(screen["actual_file_path"])

        screen_code = screen['screen_name'].lower().replace('screen','').replace('_','-')
        if screen_code.endswith('-'):
            screen_code = screen_code[:-1]
        
        required_data_cy = {
            "screen_root": f"{screen_code}-screen",
            "page_title": f"{screen_code}-title",
            "primary_content": f"{screen_code}-content"
        }

        missing_data_cy = [
            value for value in required_data_cy.values()
            if value not in result["data_cy_found"]
        ]

        cypress_ready = (
            result["file_exists"]
            and len(missing_data_cy) == 0
            and result.get("fake_handler_count", 0) == 0
            and result.get("null_handler_count", 0) == 0
        )

        cur.execute("""
            UPDATE screens
            SET
              actual_component_tree_json = ?,
              data_cy_required_json = ?,
              data_cy_found_json = ?,
              data_cy_missing_json = ?,
              fake_handler_detected = ?,
              null_onpressed_detected = ?,
              cypress_ready = ?,
              cypress_ready_status = ?,
              component_scan_status = ?,
              component_scan_log = ?,
              component_scan_at = ?
            WHERE id = ?
        """, (
            json.dumps(result, indent=2),
            json.dumps(required_data_cy, indent=2),
            json.dumps(result["data_cy_found"], indent=2),
            json.dumps(missing_data_cy, indent=2),
            1 if result.get("fake_handler_count", 0) else 0,
            1 if result.get("null_handler_count", 0) else 0,
            1 if cypress_ready else 0,
            "ready" if cypress_ready else "not_ready",
            "scanned",
            "; ".join(result["problems"]) if result["problems"] else "None",
            datetime.utcnow().isoformat(),
            screen["id"]
        ))

        scan_results.append({
            "screen_id": screen["id"],
            "screen_name": screen["screen_name"],
            "cypress_ready": cypress_ready,
            "missing_data_cy": missing_data_cy,
            "problems": result["problems"]
        })

    conn.commit()

    # Save E2E report proof json
    with open(os.path.join(REPORT_DIR, "component_scan_report.json"), "w", encoding="utf-8") as f:
        json.dump(scan_results, f, indent=2)

    conn.close()
    print(f"Scanned {len(screens)} screens. Saved scan report to reports/component_scan_report.json")

if __name__ == "__main__":
    main()
