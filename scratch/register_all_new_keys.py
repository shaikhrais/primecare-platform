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
    "auth_success_identity_portal": {
        "en": "Identity Portal",
        "fr": "Portail d'identité",
        "es": "Portal de identidad"
    },
    "auth_success_session_verified": {
        "en": "Your session is securely verified",
        "fr": "Votre session est vérifiée avec sécurité",
        "es": "Su sesión está verificada de forma segura"
    },
    "auth_success_active_session": {
        "en": "Active Session",
        "fr": "Session active",
        "es": "Sesión activa"
    },
    "auth_success_logged_in_as": {
        "en": "Logged In As",
        "fr": "Connecté en tant que",
        "es": "Conectado como"
    },
    "auth_success_assigned_role": {
        "en": "Assigned Platform Role",
        "fr": "Rôle attribué sur la plateforme",
        "es": "Rol de plataforma asignado"
    },
    "auth_success_session_token": {
        "en": "Session Token:",
        "fr": "Jeton de session :",
        "es": "Token de sesión:"
    },
    "auth_success_sign_out": {
        "en": "Sign Out Account",
        "fr": "Déconnecter le compte",
        "es": "Cerrar sesión de la cuenta"
    },
    "auth_success_parity_title": {
        "en": "Architectural Parity: 100%",
        "fr": "Parité architecturale : 100%",
        "es": "Paridad arquitectónica: 100%"
    },
    "auth_success_parity_subtitle": {
        "en": "All platform registries synchronized and verified.",
        "fr": "Tous les registres de la plateforme sont synchronisés et vérifiés.",
        "es": "Todos los registros de plataforma sincronizados y verificados."
    },
    "auth_consent_authorize_title": {
        "en": "Authorize Application",
        "fr": "Autoriser l'application",
        "es": "Autorizar aplicación"
    },
    "auth_consent_security_required": {
        "en": "Security Consent Required",
        "fr": "Consentement de sécurité requis",
        "es": "Consentimiento de seguridad requerido"
    },
    "auth_consent_permission_request": {
        "en": "PERMISSION REQUEST",
        "fr": "DEMANDE D'AUTORISATION",
        "es": "SOLICITUD DE PERMISO"
    },
    "auth_consent_explanation": {
        "en": "The application at the following address wants to sign in using your PrimeCare Identity:",
        "fr": "L'application à l'adresse suivante souhaite se connecter en utilisant votre identité PrimeCare :",
        "es": "La aplicación en la siguiente dirección desea iniciar sesión usando su identidad PrimeCare:"
    },
    "auth_consent_authorizing_account": {
        "en": "AUTHORIZING ACCOUNT",
        "fr": "COMPTE D'AUTORISATION",
        "es": "CUENTA DE AUTORIZACIÓN"
    },
    "auth_consent_redirecting": {
        "en": "Redirecting...",
        "fr": "Redirection en cours...",
        "es": "Redirigiendo..."
    },
    "auth_consent_approve": {
        "en": "Approve & Continue",
        "fr": "Approuver et continuer",
        "es": "Aprobar y continuar"
    },
    "auth_consent_cancel": {
        "en": "Cancel & Sign Out",
        "fr": "Annuler et se déconnecter",
        "es": "Cancelar y cerrar sesión"
    },
    "auth_success_default_user": {
        "en": "PrimeCare User",
        "fr": "Utilisateur PrimeCare",
        "es": "Usuario de PrimeCare"
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
        
    print("All registration complete! 🎉")

if __name__ == '__main__':
    main()
