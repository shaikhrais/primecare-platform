import os
import sys
import sqlite3
from datetime import datetime

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

KEYS_DATA = [
    {
        "key": "select_language_welcome",
        "en": "WELCOME TO PRIMECARE",
        "fr": "BIENVENUE CHEZ PRIMECARE",
        "es": "BIENVENIDA A PRIMECARE"
    },
    {
        "key": "select_language_title",
        "en": "Select Your Preferred Language",
        "fr": "Sélectionnez Votre Langue Préférée",
        "es": "Seleccione Su Idioma Preferido"
    },
    {
        "key": "select_language_subtitle",
        "en": "Choose your interface language to customize your institutional workspace.",
        "fr": "Choisissez la langue de votre interface pour personnaliser votre espace de travail institutionnel.",
        "es": "Elija el idioma de su interfaz para personalizar su espacio de trabajo institucional."
    },
    {
        "key": "select_language_continue",
        "en": "Continue",
        "fr": "Continuer",
        "es": "Continuar"
    },
    {
        "key": "language_en_title",
        "en": "English (EN)",
        "fr": "English (EN)",
        "es": "English (EN)"
    },
    {
        "key": "language_en_subtitle",
        "en": "Secure portal default language",
        "fr": "Secure portal default language",
        "es": "Secure portal default language"
    },
    {
        "key": "language_fr_title",
        "en": "Français (FR)",
        "fr": "Français (FR)",
        "es": "Français (FR)"
    },
    {
        "key": "language_fr_subtitle",
        "en": "Ajustement de la session en français",
        "fr": "Ajustement de la session en français",
        "es": "Ajustement de la session en français"
    },
    {
        "key": "language_es_title",
        "en": "Español (ES)",
        "fr": "Español (ES)",
        "es": "Español (ES)"
    },
    {
        "key": "language_es_subtitle",
        "en": "Alineación de sesión en español",
        "fr": "Alineación de sesión en español",
        "es": "Alineación de sesión en español"
    },
    {
        "key": "system_language_detected",
        "en": "System language detected: {}",
        "fr": "Langue du système détectée : {}",
        "es": "Idioma del sistema detectado: {}"
    }
]

def insert_to_db(key_code, key_group, default_text, translations):
    if not os.path.exists(DB_PATH):
        print(f"Warning: Governance database not found at {DB_PATH}. Skipping.")
        return

    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()
    now = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    
    try:
        cursor.execute("SELECT id FROM translation_keys WHERE key_code = ?", (key_code,))
        row = cursor.fetchone()
        
        if row:
            key_id = row[0]
            print(f"Key '{key_code}' already exists. Updating translations...")
        else:
            cursor.execute(
                "INSERT INTO translation_keys (key_code, key_group, default_text, description, created_at) VALUES (?, ?, ?, ?, ?)",
                (key_code, key_group, default_text, "Added via localization scaffolder", now)
            )
            key_id = cursor.lastrowid
            print(f"Inserted key '{key_code}' with new ID {key_id}")
        
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
        print(f"Database Error: {e}")
    finally:
        conn.close()

def main():
    print(f"Connecting to database at {DB_PATH}...")
    for item in KEYS_DATA:
        key = item["key"]
        en_val = item["en"]
        translations = {
            "en": en_val,
            "fr": item["fr"],
            "es": item["es"]
        }
        insert_to_db(key, "auth", en_val, translations)
    print("Database sync completed successfully! 🎉")

if __name__ == '__main__':
    main()
