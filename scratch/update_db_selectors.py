import sqlite3
import os
import json

DB_PATH = r"c:\Users\Admin2\Documents\GitHub\primecare-platform\.agents\governance\governance.db"

CLEAN_SELECTORS = {
    "lpn_analytics": {
        "screen_root": "lpnanalytics-screen",
        "page_title": "lpnanalytics-title",
        "primary_content": "lpnanalytics-content"
    },
    "lpn_workflow": {
        "screen_root": "lpnworkflow-screen",
        "page_title": "lpnworkflow-title",
        "primary_content": "lpnworkflow-content"
    },
    "np_analytics": {
        "screen_root": "npanalytics-screen",
        "page_title": "npanalytics-title",
        "primary_content": "npanalytics-content"
    },
    "np_workflow": {
        "screen_root": "npworkflow-screen",
        "page_title": "npworkflow-title",
        "primary_content": "npworkflow-content"
    },
    "pediatric_analytics": {
        "screen_root": "pediatricanalytics-screen",
        "page_title": "pediatricanalytics-title",
        "primary_content": "pediatricanalytics-content"
    },
    "pediatric_workflow": {
        "screen_root": "pediatricworkflow-screen",
        "page_title": "pediatricworkflow-title",
        "primary_content": "pediatricworkflow-content"
    },
    "physician_analytics": {
        "screen_root": "physiciananalytics-screen",
        "page_title": "physiciananalytics-title",
        "primary_content": "physiciananalytics-content"
    },
    "physician_workflow": {
        "screen_root": "physicianworkflow-screen",
        "page_title": "physicianworkflow-title",
        "primary_content": "physicianworkflow-content"
    }
}

def main():
    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()
    
    for screen_code, selectors in CLEAN_SELECTORS.items():
        selectors_json = json.dumps(selectors, indent=2)
        cursor.execute("""
            UPDATE screens
            SET data_cy_required_json = ?
            WHERE screen_code = ?;
        """, (selectors_json, screen_code))
        print(f"Updated screen_code: {screen_code} with clean selectors.")
        
    conn.commit()
    conn.close()
    print("Database updated successfully!")

if __name__ == '__main__':
    main()
