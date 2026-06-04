import os
import sys
import json
import sqlite3
import argparse
from datetime import datetime

# Reconfigure stdout to use UTF-8 on Windows
if sys.platform == 'win32':
    sys.stdout.reconfigure(encoding='utf-8')

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")
APPS_DIR = os.path.join(PROJECT_ROOT, "apps")

def find_translation_dirs(root_dir):
    """Finds all assets/translations directories recursively within apps."""
    translation_dirs = []
    for root, dirs, files in os.walk(root_dir):
        if os.path.basename(root) == "translations" and os.path.basename(os.path.dirname(root)) == "assets":
            translation_dirs.append(root)
    return translation_dirs

def insert_to_db(key_code, key_group, default_text, translations):
    """Inserts a new key and its translation values into the SQLite central DB."""
    if not os.path.exists(DB_PATH):
        print(f"Warning: Governance database not found at {DB_PATH}. Skipping database sync.")
        return

    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()
    
    now = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    
    try:
        # Check if key already exists
        cursor.execute("SELECT id FROM translation_keys WHERE key_code = ?", (key_code,))
        row = cursor.fetchone()
        
        if row:
            key_id = row[0]
            print(f"Database: Key '{key_code}' already exists with ID {key_id}. Updating translations...")
        else:
            # Insert key
            cursor.execute(
                "INSERT INTO translation_keys (key_code, key_group, default_text, description, created_at) VALUES (?, ?, ?, ?, ?)",
                (key_code, key_group, default_text, "Added via localization scaffolder", now)
            )
            key_id = cursor.lastrowid
            print(f"Database: Inserted key '{key_code}' with new ID {key_id}")
        
        # We also need to support hi, gu, ar, ur as seen in the registry
        all_locales = ['en', 'fr', 'es', 'hi', 'gu', 'ar', 'ur']
        
        for locale in all_locales:
            translated_text = translations.get(locale)
            if not translated_text:
                # Generate a bracketed fallback for other locales
                en_val = translations.get('en', default_text)
                translated_text = f"[{locale.upper()}] {en_val}"
            
            # Check if value exists
            cursor.execute("SELECT id FROM translation_values WHERE key_id = ? AND locale_code = ?", (key_id, locale))
            val_row = cursor.fetchone()
            
            if val_row:
                cursor.execute(
                    "UPDATE translation_values SET translated_text = ? WHERE id = ?",
                    (translated_text, val_row[0])
                )
            else:
                cursor.execute(
                    "INSERT INTO translation_values (key_id, locale_code, translated_text, verified, created_at) VALUES (?, ?, ?, 1, ?)",
                    (key_id, locale, translated_text, now)
                )
        
        conn.commit()
        print("Database: Succeeded synchronizing all locales.")
    except Exception as e:
        conn.rollback()
        print(f"Database Error: Failed to write to SQLite: {e}")
    finally:
        conn.close()

def update_json_files(key_code, translations):
    """Updates en.json, fr.json, and es.json across all application directories."""
    dirs = find_translation_dirs(APPS_DIR)
    print(f"\nScanning apps for localization directories... Found {len(dirs)} directories.")
    
    locales_to_update = ['en', 'fr', 'es']
    
    for trans_dir in dirs:
        app_name = os.path.basename(os.path.dirname(os.path.dirname(trans_dir)))
        print(f"Processing app: {app_name}")
        
        for locale in locales_to_update:
            file_path = os.path.join(trans_dir, f"{locale}.json")
            if not os.path.exists(file_path):
                # If file doesn't exist, let's skip or initialize it
                continue
                
            val = translations.get(locale)
            if not val:
                # Fallback to English value
                val = translations.get('en', key_code)
                
            try:
                with open(file_path, 'r', encoding='utf-8') as f:
                    data = json.load(f)
                
                # Append/Update the key at the flat level
                data[key_code] = val
                
                # Write back sorted and formatted json
                with open(file_path, 'w', encoding='utf-8') as f:
                    json.dump(data, f, indent=4, ensure_ascii=False)
                
                print(f"  -> Updated {locale}.json")
            except Exception as e:
                print(f"  -> Error updating {file_path}: {e}")

def main():
    parser = argparse.ArgumentParser(description="PrimeCare Centralized Localization Scaffolder")
    parser.add_argument("--key", help="The translation key (e.g. auth_login_title)")
    parser.add_argument("--group", default="auth", help="The key group (default: auth)")
    parser.add_argument("--en", help="English translation text")
    parser.add_argument("--fr", help="French translation text")
    parser.add_argument("--es", help="Spanish translation text")
    parser.add_argument("--interactive", action="store_true", help="Run in interactive CLI mode")
    
    args = parser.parse_args()
    
    key = args.key
    group = args.group
    en_val = args.en
    fr_val = args.fr
    es_val = args.es
    
    if args.interactive or not key:
        print("=== PrimeCare Localization Scaffolder (Interactive Mode) ===")
        key = input("Enter Translation Key (e.g. select_language_title): ").strip()
        if not key:
            print("Error: Key is required.")
            sys.exit(1)
        group = input("Enter Key Group (default 'auth'): ").strip() or "auth"
        en_val = input("Enter English (EN) Text: ").strip()
        fr_val = input("Enter French (FR) Text: ").strip()
        es_val = input("Enter Spanish (ES) Text: ").strip()
    
    if not key or not en_val:
        print("Error: Both key and English translation are required to scaffold a key.")
        sys.exit(1)
        
    translations = {
        'en': en_val,
        'fr': fr_val or f"[FR] {en_val}",
        'es': es_val or f"[ES] {en_val}"
    }
    
    print("\n--- Scaffolding Summary ---")
    print(f"Key:   {key}")
    print(f"Group: {group}")
    print(f"EN:    {translations['en']}")
    print(f"FR:    {translations['fr']}")
    print(f"ES:    {translations['es']}")
    print("---------------------------\n")
    
    # 1. Sync Central SQLite Governance Database
    insert_to_db(key, group, en_val, translations)
    
    # 2. Sync Local Assets JSON files for all apps
    update_json_files(key, translations)
    
    print("\nScaffolding localization completed successfully! 🎉")

if __name__ == '__main__':
    main()
