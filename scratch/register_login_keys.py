import os
import sys
import json
import sqlite3
from datetime import datetime

# Reconfigure stdout to use UTF-8 on Windows
if sys.platform == 'win32':
    sys.stdout.reconfigure(encoding='utf-8')

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")
ASSETS_DIR = os.path.join(PROJECT_ROOT, "packages", "flutter_core", "assets", "translations")
LIB_DIR = os.path.join(PROJECT_ROOT, "packages", "flutter_core", "lib", "src", "localization")

KEYS_TO_ADD = {
    "login_authorized_access": {
        "en": "Authorized Access",
        "fr": "Accès Autorisé",
        "es": "ACCESO AUTORIZADO ÚNICAMENTE"
    },
    "login_enter_credentials": {
        "en": "Enter your secure credentials to continue",
        "fr": "Entrez vos identifiants sécurisés pour continuer",
        "es": "Ingrese sus credenciales institucionales para autenticarse."
    },
    "login_identifier_label": {
        "en": "USERNAME",
        "fr": "NOM D'UTILISATEUR",
        "es": "NOMBRE DE USUARIO"
    },
    "login_security_token_label": {
        "en": "PASSWORD",
        "fr": "MOT DE PASSE",
        "es": "CONTRASEÑA"
    },
    "login_forgot_password": {
        "en": "Forgot Password?",
        "fr": "Mot de passe oublié ?",
        "es": "Recuperar Token de Seguridad"
    },
    "login_button": {
        "en": "LOGIN",
        "fr": "CONNEXION",
        "es": "LOGIN"
    },
    "login_access_demo": {
        "en": "ACCESS DEMO MODE",
        "fr": "ACCÉDER AU MODE DÉMO",
        "es": "Simular Sesión (Modo Demostración)"
    },
    "login_role_simulation_center": {
        "en": "ROLE SIMULATION CENTER",
        "fr": "CENTRE DE SIMULATION DES RÔLES",
        "es": "CENTRO DE SIMULACIÓN DE ROLES"
    }
}

def insert_to_db(key_code, key_group, default_text, translations):
    if not os.path.exists(DB_PATH):
        print(f"Warning: Governance database not found at {DB_PATH}. Skipping DB sync.")
        return

    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()
    now = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    
    try:
        cursor.execute("SELECT id FROM translation_keys WHERE key_code = ?", (key_code,))
        row = cursor.fetchone()
        
        if row:
            key_id = row[0]
            print(f"DB: Key '{key_code}' already exists. Updating...")
        else:
            cursor.execute(
                "INSERT INTO translation_keys (key_code, key_group, default_text, description, created_at) VALUES (?, ?, ?, ?, ?)",
                (key_code, key_group, default_text, "Added via localization scaffolder", now)
            )
            key_id = cursor.lastrowid
            print(f"DB: Inserted key '{key_code}' with new ID {key_id}")
        
        all_locales = ['en', 'fr', 'es', 'hi', 'gu', 'ar', 'ur']
        
        for locale in all_locales:
            translated_text = translations.get(locale)
            if not translated_text:
                en_val = translations.get('en', default_text)
                translated_text = f"[{locale.upper()}] {en_val}"
            
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
    except Exception as e:
        conn.rollback()
        print(f"DB Error: {e}")
    finally:
        conn.close()

def update_json_directory(directory, keys_dict):
    locales = ['en', 'fr', 'es']
    for locale in locales:
        file_path = os.path.join(directory, f"{locale}.json")
        if not os.path.exists(file_path):
            print(f"File not found: {file_path}")
            continue
            
        with open(file_path, "r", encoding="utf-8") as f:
            data = json.load(f)
            
        for key, val in keys_dict.items():
            locale_val = val.get(locale)
            if not locale_val:
                locale_val = val.get('en', key)
            data[key] = locale_val
            
        with open(file_path, "w", encoding="utf-8") as f:
            json.dump(data, f, indent=4, ensure_ascii=False)
            
        print(f"Successfully updated {locale}.json in {os.path.basename(directory)}")

def main():
    # 1. Update Core Assets JSON
    print("Updating core assets translations...")
    update_json_directory(ASSETS_DIR, KEYS_TO_ADD)
    
    # 2. Update Core Lib Src JSON
    print("Updating core lib translations...")
    update_json_directory(LIB_DIR, KEYS_TO_ADD)
    
    # 3. Sync to SQLite
    print("Syncing with central DB...")
    for key, val in KEYS_TO_ADD.items():
        insert_to_db(key, "auth", val["en"], val)
        
    print("Login keys registration complete! 🎉")

if __name__ == '__main__':
    main()
