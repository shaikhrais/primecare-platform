import json
import os

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
LIB_LOCALIZATION_DIR = os.path.join(PROJECT_ROOT, "packages", "flutter_core", "lib", "src", "localization")

KEYS_TO_ADD = {
    "en": {
        "select_language_welcome": "WELCOME TO PRIMECARE",
        "select_language_title": "Select Your Preferred Language",
        "select_language_subtitle": "Choose your interface language to customize your institutional workspace.",
        "select_language_continue": "Continue",
        "language_en_title": "English (EN)",
        "language_en_subtitle": "Secure portal default language",
        "language_fr_title": "Français (FR)",
        "language_fr_subtitle": "Ajustement de la session en français",
        "language_es_title": "Español (ES)",
        "language_es_subtitle": "Alineación de sesión en español",
        "system_language_detected": "System language detected: {}"
    },
    "fr": {
        "select_language_welcome": "BIENVENUE CHEZ PRIMECARE",
        "select_language_title": "Sélectionnez Votre Langue Préférée",
        "select_language_subtitle": "Choisissez la langue de votre interface pour personnaliser votre espace de travail institutionnel.",
        "select_language_continue": "Continuer",
        "language_en_title": "English (EN)",
        "language_en_subtitle": "Secure portal default language",
        "language_fr_title": "Français (FR)",
        "language_fr_subtitle": "Ajustement de la session en français",
        "language_es_title": "Español (ES)",
        "language_es_subtitle": "Alineación de session en español",
        "system_language_detected": "Langue du système détectée : {}"
    },
    "es": {
        "select_language_welcome": "BIENVENIDA A PRIMECARE",
        "select_language_title": "Seleccione Su Idioma Preferido",
        "select_language_subtitle": "Elija el idioma de su interfaz para personalizar su espacio de trabajo institucional.",
        "select_language_continue": "Continuar",
        "language_en_title": "English (EN)",
        "language_en_subtitle": "Idioma predeterminado del portal seguro",
        "language_fr_title": "Français (FR)",
        "language_fr_subtitle": "Ajustement de la session en français",
        "language_es_title": "Español (ES)",
        "language_es_subtitle": "Alineación de sesión en español",
        "system_language_detected": "Idioma del sistema detectado: {}"
    }
}

def update_lib():
    for locale, keys in KEYS_TO_ADD.items():
        file_path = os.path.join(LIB_LOCALIZATION_DIR, f"{locale}.json")
        if not os.path.exists(file_path):
            print(f"File not found: {file_path}")
            continue
            
        with open(file_path, "r", encoding="utf-8") as f:
            data = json.load(f)
            
        for key, val in keys.items():
            data[key] = val
            
        with open(file_path, "w", encoding="utf-8") as f:
            json.dump(data, f, indent=2, ensure_ascii=False)
            
        print(f"Successfully updated {locale}.json in lib/src/localization")

if __name__ == "__main__":
    update_lib()
