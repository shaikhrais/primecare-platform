import json
import os

translation_map = {
    "common": {
        "languages": {
            "en": "English",
            "fr": "Français",
            "es": "Español"
        },
        "language": {
            "en": "English",
            "fr": "Français",
            "es": "Español"
        },
        "aura": {
            "execute_action": {"en": "Execute Action", "fr": "Exécuter l'action", "es": "Ejecutar acción"},
            "search_placeholder": {"en": "Search commands or ask Aura...", "fr": "Rechercher des commandes ou demander à Aura...", "es": "Buscar comandos o preguntar a Aura..."},
            "disclaimer": {"en": "Aura AI may provide inaccurate information. Verify critical data.", "fr": "Aura AI peut fournir des informations inexactes. Vérifiez les données critiques.", "es": "Aura AI puede proporcionar información inexacta. Verifique los datos críticos."},
            "title": {"en": "Aura Intelligence", "fr": "Intelligence Aura", "es": "Inteligencia Aura"},
            "subtitle": {"en": "Your enterprise AI co-pilot", "fr": "Votre co-pilote IA d'entreprise", "es": "Su copiloto de IA empresarial"},
            "suggestions_label": {"en": "Suggested for you", "fr": "Suggéré pour vous", "es": "Sugerido para ti"}
        },
        "tooltips": {
            "change_language": {"en": "Change Language", "fr": "Changer de langue", "es": "Cambiar idioma"}
        }
    },
    "auth": {
        "title_curator": {"en": "PrimeCare Curator", "fr": "Conservateur PrimeCare", "es": "Curador de PrimeCare"},
        "curator_subtitle": {"en": "Enterprise Health Operations Registry", "fr": "Registre des opérations de santé d'entreprise", "es": "Registro de operaciones de salud empresarial"},
        "welcome_back": {"en": "Welcome Back", "fr": "Bon retour", "es": "Bienvenido de nuevo"},
        "login_instructions": {"en": "Please enter your institutional credentials to access your workspace.", "fr": "Veuillez saisir vos identifiants institutionnels pour accéder à votre espace de travail.", "es": "Ingrese sus credenciales institucionales para acceder a su espacio de trabajo."},
        "email": {"en": "Email Address", "fr": "Adresse e-mail", "es": "Correo electrónico"},
        "email_placeholder": {"en": "name@institution.com", "fr": "nom@institution.com", "es": "nombre@institucion.com"},
        "password": {"en": "Password", "fr": "Mot de passe", "es": "Contraseña"},
        "forgot_password": {"en": "Forgot Password?", "fr": "Mot de passe oublié ?", "es": "¿Olvidó su contraseña?"},
        "sign_in": {"en": "Sign In", "fr": "Se connecter", "es": "Iniciar sesión"},
        "register": {"en": "Register", "fr": "S'inscrire", "es": "Registrarse"},
        "create_account": {"en": "Create Account", "fr": "Créer un compte", "es": "Crear cuenta"},
        "already_have_account": {"en": "Already have an account?", "fr": "Vous avez déjà un compte ?", "es": "¿Ya tienes una cuenta?"},
        "back_to_login": {"en": "Back to Login", "fr": "Retour à la connexion", "es": "Volver al inicio de sesión"},
        "authentication_failed": {"en": "Authentication failed. Please check your credentials.", "fr": "Échec de l'authentification. Veuillez vérifier vos identifiants.", "es": "Error de autenticación. Por favor, compruebe sus credenciales."},
        "enter_credentials_to_continue": {"en": "Please enter your email and password to continue.", "fr": "Veuillez saisir votre e-mail et votre mot de passe pour continuer.", "es": "Por favor, introduzca su correo electrónico y contraseña para continuar."},
        "security_notice_long": {
            "en": "This system is restricted to authorized PrimeCare personnel and partners. All access and activities are monitored, recorded, and audited to ensure compliance with global health data regulations (HIPAA/GDPR). Unauthorized access attempts or misuse of this platform is strictly prohibited and will be prosecuted to the fullest extent of the law. By proceeding, you acknowledge and consent to these terms.",
            "fr": "Ce système est réservé au personnel et aux partenaires autorisés de PrimeCare. Tous les accès et activités sont surveillés, enregistrés et audités pour garantir la conformité aux réglementations mondiales sur les données de santé (HIPAA/RGPD). Les tentatives d'accès non autorisées ou l'utilisation abusive de cette plateforme sont strictement interdites et seront poursuivies dans toute la mesure de la loi. En continuant, vous reconnaissez et acceptez ces conditions.",
            "es": "Este sistema está restringido al personal y socios autorizados de PrimeCare. Todos los accesos y actividades son monitoreados, registrados y auditados para garantizar el cumplimiento de las regulaciones mundiales de datos de salud (HIPAA/GDPR). Los intentos de acceso no autorizados o el uso indebido de esta plataforma están estrictamente prohibidos y serán procesados con todo el rigor de la ley. Al continuar, usted reconoce y acepta estos términos."
        },
        "security_notice_short": {"en": "Authorized Access Only", "fr": "Accès autorisé uniquement", "es": "Solo acceso autorizado"},
        "zero_trust_platform": {"en": "Zero Trust Platform", "fr": "Plateforme Zero Trust", "es": "Plataforma Zero Trust"},
        "encryption_active": {"en": "End-to-End Encryption Active", "fr": "Chiffrement de bout en bout actif", "es": "Cifrado de extremo a extremo activo"},
        "provision_workspace": {"en": "Provisioning Workspace...", "fr": "Provisionnement de l'espace de travail...", "es": "Aprovisionando espacio de trabajo..."},
        "hydrating_registries": {"en": "Hydrating Platform Registries...", "fr": "Hydratation des registres de plateforme...", "es": "Hidratando registros de plataforma..."},
        "account_recovery": {"en": "Account Recovery", "fr": "Récupération de compte", "es": "Recuperación de cuenta"},
        "recovery_subtitle": {"en": "Enter your email to receive a recovery link.", "fr": "Entrez votre e-mail pour recevoir un lien de récupération.", "es": "Ingrese su correo electrónico para recibir un enlace de recuperación."},
        "send_recovery_link": {"en": "Send Recovery Link", "fr": "Envoyer le lien de récupération", "es": "Enviar enlace de recuperación"},
        "recovery_link_sent": {"en": "Recovery link has been sent to your email.", "fr": "Le lien de récupération a été envoyé à votre e-mail.", "es": "Se ha enviado el enlace de recuperación a su correo electrónico."},
        "reset_password": {"en": "Reset Password", "fr": "Réinitialiser le mot de passe", "es": "Restablecer contraseña"},
        "reset_password_page": {
            "title": {"en": "Create New Password", "fr": "Créer un nouveau mot de passe", "es": "Crear nueva contraseña"},
            "new_password": {"en": "New Password", "fr": "Nouveau mot de passe", "es": "Nueva contraseña"},
            "confirm_password": {"en": "Confirm New Password", "fr": "Confirmer le nouveau mot de passe", "es": "Confirmar nueva contraseña"},
            "update_password": {"en": "Update Password", "fr": "Mettre à jour le mot de passe", "es": "Actualizar contraseña"}
        },
        "mfa": {
            "title": {"en": "Multi-Factor Authentication", "fr": "Authentification multifactorielle", "es": "Autenticación de múltiples factores"},
            "subtitle": {"en": "Enter the verification code sent to your device.", "fr": "Entrez le code de vérification envoyé à votre appareil.", "es": "Ingrese el código de verificación enviado a su dispositivo."}
        },
        "first_name": {"en": "First Name", "fr": "Prénom", "es": "Nombre"},
        "last_name": {"en": "Last Name", "fr": "Nom", "es": "Apellido"},
        "role": {"en": "Platform Role", "fr": "Rôle de plateforme", "es": "Rol de plataforma"},
        "language_system": {"en": "Language System", "fr": "Système de langue", "es": "Sistema de idiomas"},
        "join_clinical_atelier": {"en": "Join Clinical Atelier", "fr": "Rejoindre l'Atelier Clinique", "es": "Unirse al Taller Clínico"},
        "send_again": {"en": "Send Again", "fr": "Renvoyer", "es": "Enviar de nuevo"}
    },
    "aura": {
        "adjust_budget": {"en": "Adjust Budget", "fr": "Ajuster le budget", "es": "Ajustar presupuesto"},
        "marketing_roi_surge": {"en": "Marketing ROI Surge", "fr": "Augmentation du ROI marketing", "es": "Aumento del ROI de marketing"},
        "critical_insights": {"en": "Critical Insights", "fr": "Aperçus critiques", "es": "Información crítica"},
        "system_preferences": {"en": "System Preferences", "fr": "Préférences système", "es": "Preferencias del sistema"},
        "operational_summary": {"en": "Operational Summary", "fr": "Résumé opérationnel", "es": "Resumen operativo"},
        "intelligence": {"en": "Intelligence", "fr": "Intelligence", "es": "Inteligencia"},
        "stay": {"en": "Stay", "fr": "Rester", "es": "Quedarse"},
        "view_retention_plan": {"en": "View Retention Plan", "fr": "Voir le plan de rétention", "es": "Ver plan de retención"},
        "exit_message": {"en": "Are you sure you want to exit the session?", "fr": "Êtes-vous sûr de vouloir quitter la session ?", "es": "¿Está seguro de que desea salir de la sesión?"},
        "marketing_roi_desc": {"en": "ROI has increased by 24% this quarter.", "fr": "Le ROI a augmenté de 24 % ce trimestre.", "es": "El ROI ha aumentado un 24% este trimestre."},
        "sign_out": {"en": "Sign Out", "fr": "Déconnexion", "es": "Cerrar sesión"},
        "executive_overview": {"en": "Executive Overview", "fr": "Aperçu exécutif", "es": "Resumen ejecutivo"},
        "see_report": {"en": "See Report", "fr": "Voir le rapport", "es": "Ver informe"},
        "staff_retention_desc": {"en": "Staff retention is at an all-time high of 98%.", "fr": "La rétention du personnel est à un niveau record de 98 %.", "es": "La retención de personal está en un máximo histórico del 98%."},
        "confirm_departure": {"en": "Confirm Departure", "fr": "Confirmer le départ", "es": "Confirmar salida"},
        "daily_briefing": {"en": "Daily Briefing", "fr": "Briefing quotidien", "es": "Informe diario"},
        "profile": {"en": "User Profile", "fr": "Profil utilisateur", "es": "Perfil de usuario"},
        "supply_chain_sync": {"en": "Supply Chain Sync", "fr": "Sync de la chaîne d'approvisionnement", "es": "Sincronización de la cadena de suministro"},
        "exit_session": {"en": "Exit Session", "fr": "Quitter la session", "es": "Salir de la sesión"},
        "staff_retention_alert": {"en": "Staff Retention Alert", "fr": "Alerte de rétention du personnel", "es": "Alerta de retención de personal"},
        "search_hint": {"en": "Type '/' for commands", "fr": "Tapez '/' pour les commandes", "es": "Escriba '/' para comandos"},
        "supply_chain_desc": {"en": "All nodes are synchronized.", "fr": "Tous les nœuds sont synchronisés.", "es": "Todos los nodos están sincronizados."}
    },
    "navigation": {
        "footer": {
            "language": {"en": "Language", "fr": "Langue", "es": "Idioma"}
        }
    }
}

def set_nested_item(data, key_parts, value):
    curr = data
    for part in key_parts[:-1]:
        curr = curr.setdefault(part, {})
    curr[key_parts[-1]] = value

def deep_merge(dict1, dict2):
    for key, value in dict2.items():
        if key in dict1 and isinstance(dict1[key], dict) and isinstance(value, dict):
            deep_merge(dict1[key], value)
        else:
            dict1[key] = value

def process():
    locales = ['en', 'fr', 'es']
    base_path = r"C:\Users\Admin2\Documents\GitHub\primecare-platform\packages\flutter_core\assets\translations"
    
    for locale in locales:
        file_path = os.path.join(base_path, f"{locale}.json")
        
        # Load existing data to merge
        existing_data = {}
        if os.path.exists(file_path):
            try:
                with open(file_path, 'r', encoding='utf-8') as f:
                    existing_data = json.load(f)
            except:
                pass

        new_data = {}
        
        # Flatten the map for this locale
        def flatten_map(m, data, path=[]):
            for k, v in m.items():
                new_path = path + [k]
                if isinstance(v, dict) and locale in v:
                    set_nested_item(new_data, new_path, v[locale])
                elif isinstance(v, dict):
                    flatten_map(v, data, new_path)
                else:
                    pass

        flatten_map(translation_map, new_data)
        
        # Merge new data into existing data
        deep_merge(existing_data, new_data)
        
        with open(file_path, 'w', encoding='utf-8') as f:
            json.dump(existing_data, f, indent=2, ensure_ascii=False)
        print(f"Updated {file_path}")

if __name__ == "__main__":
    process()
