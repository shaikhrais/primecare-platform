import os
import json
import sqlite3
from datetime import datetime

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

welcome_updates = {
    "login_authorized_access": {
        "en": "Welcome to PrimeCare",
        "es": "Le damos la bienvenida a PrimeCare",
        "fr": "Bienvenue chez PrimeCare"
    },
    "login_enter_credentials": {
        "en": "We're glad you're here. Please enter your credentials to access your secure workspace.",
        "es": "Nos alegra tenerle aquí. Inicie sesión para acceder a su espacio de trabajo seguro.",
        "fr": "Nous sommes ravis de vous revoir. Veuillez entrer vos identifiants pour accéder à votre espace sécurisé."
    },
    "select_language_welcome": {
        "en": "HELLO & WELCOME",
        "es": "HOLA Y LE DAMOS LA BIENVENIDA",
        "fr": "BONJOUR & BIENVENUE"
    },
    "select_language_title": {
        "en": "Let's Set Up Your Workspace",
        "es": "Configuremos su espacio de trabajo",
        "fr": "Configurons votre espace de travail"
    },
    "select_language_subtitle": {
        "en": "Please choose your preferred language to begin customizing your experience.",
        "es": "Elija su idioma preferido para comenzar a personalizar su experiencia.",
        "fr": "Choisissez votre langue préférée pour commencer à personnaliser votre expérience."
    }
}

# Update JSON files (handling flat structure)
def update_json_file(file_path, welcome_dict):
    if not os.path.exists(file_path):
        print(f"File not found: {file_path}")
        return
    
    locale = os.path.basename(file_path).split('.')[0]
    
    with open(file_path, 'r', encoding='utf-8') as f:
        data = json.load(f)
    
    for key, translations in welcome_dict.items():
        val = translations.get(locale, translations['en'])
        data[key] = val
        
    with open(file_path, 'w', encoding='utf-8') as f:
        json.dump(data, f, indent=4, ensure_ascii=False)
    print(f"Updated {file_path}")

def main():
    # Directories to update
    dirs = [
        os.path.join(PROJECT_ROOT, "packages", "flutter_core", "assets", "translations"),
        os.path.join(PROJECT_ROOT, "packages", "flutter_core", "lib", "src", "localization")
    ]
    
    for d in dirs:
        for locale in ["en", "es", "fr"]:
            file_path = os.path.join(d, f"{locale}.json")
            update_json_file(file_path, welcome_updates)
            
    # Sync with SQLite DB
    if os.path.exists(DB_PATH):
        conn = sqlite3.connect(DB_PATH)
        cursor = conn.cursor()
        now = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        
        try:
            for key_code, translations in welcome_updates.items():
                default_text = translations["en"]
                cursor.execute("SELECT id FROM translation_keys WHERE key_code = ?", (key_code,))
                row = cursor.fetchone()
                
                if row:
                    key_id = row[0]
                    # Update key default text
                    cursor.execute(
                        "UPDATE translation_keys SET default_text = ? WHERE id = ?",
                        (default_text, key_id)
                    )
                else:
                    cursor.execute(
                        "INSERT INTO translation_keys (key_code, key_group, default_text, description, created_at) VALUES (?, 'auth', ?, 'Warm welcome message updates', ?)",
                        (key_code, default_text, now)
                    )
                    key_id = cursor.lastrowid
                
                all_locales = ['en', 'fr', 'es', 'hi', 'gu', 'ar', 'ur']
                for locale in all_locales:
                    translated_text = translations.get(locale)
                    if not translated_text:
                        translated_text = translations.get('en', default_text)
                    
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
            print("DB sync succeeded.")
        except Exception as e:
            conn.rollback()
            print(f"DB Error: {e}")
        finally:
            conn.close()

if __name__ == '__main__':
    main()
