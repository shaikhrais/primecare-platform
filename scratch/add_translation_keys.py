import json
import os

PROJECT_ROOT = r"C:\Users\Admin2\Documents\GitHub\primecare-platform"
TRANSLATIONS_DIR = os.path.join(PROJECT_ROOT, "packages", "flutter_core", "assets", "translations")

keys_to_add = {
    "en.json": {
        "oncology_protocol_workspace": "Oncology Protocol Workspace",
        "active_protocols": "Active Protocols",
        "formulary_approvals": "Formulary Approvals",
        "draft_saved_successfully": "Draft saved successfully!",
        "save_draft": "Save Draft",
        "interact": "Interact",
        "platform_admin": "Platform Admin",
        "clinical_director": "Clinical Director",
        "hr_manager": "HR Manager",
        "field_staff": "Field Staff",
        "view_access": "View Access",
        "fill_fields_to_register_client": "Please fill out all fields to register a vulnerable client.",
        "client_registered_success": "Client {} registered successfully in vulnerable population list.",
        "public_health_care_registry": "Public Health Care Registry",
        "registered_clients": "Registered Clients",
        "critical_risk_clients": "Critical Risk Clients",
        "critical_risk": "Critical Risk",
        "high_risk": "High Risk",
        "medium_risk": "Medium Risk",
        "low_risk": "Low Risk",
        "enter_name_witness_verification": "Please enter your name for secondary witness verification.",
        "pharmacy_narcotic_vault_ledger": "Pharmacy Narcotic Vault Ledger",
        "dispensing_audit_logs": "Dispensing Audit Logs",
        "pending_double_signs": "Pending Double-Signs",
        "co_sign": "Co-Sign"
    },
    "fr.json": {
        "oncology_protocol_workspace": "Espace de travail du protocole d'oncologie",
        "active_protocols": "Protocoles actifs",
        "formulary_approvals": "Approbations du formulaire",
        "draft_saved_successfully": "Brouillon enregistré avec succès !",
        "save_draft": "Enregistrer le brouillon",
        "interact": "Interagir",
        "platform_admin": "Administrateur de plateforme",
        "clinical_director": "Directeur clinique",
        "hr_manager": "Gestionnaire des RH",
        "field_staff": "Personnel de terrain",
        "view_access": "Voir l'accès",
        "fill_fields_to_register_client": "Veuillez remplir tous les champs pour inscrire un client vulnérable.",
        "client_registered_success": "Le client {} a été enregistré avec succès dans la liste de la population vulnérable.",
        "public_health_care_registry": "Registre des soins de santé publique",
        "registered_clients": "Clients enregistrés",
        "critical_risk_clients": "Clients à risque critique",
        "critical_risk": "Risque critique",
        "high_risk": "Risque élevé",
        "medium_risk": "Risque moyen",
        "low_risk": "Risque faible",
        "enter_name_witness_verification": "Veuillez saisir votre nom pour la vérification du témoin secondaire.",
        "pharmacy_narcotic_vault_ledger": "Registre du coffre-fort des stupéfiants de la pharmacie",
        "dispensing_audit_logs": "Registres d'audit de distribution",
        "pending_double_signs": "Double signatures en attente",
        "co_sign": "Co-signer"
    },
    "es.json": {
        "oncology_protocol_workspace": "Espacio de trabajo del protocolo de oncología",
        "active_protocols": "Protocolos activos",
        "formulary_approvals": "Aprobaciones del formulario",
        "draft_saved_successfully": "¡Borrador guardado con éxito!",
        "save_draft": "Guardar borrador",
        "interact": "Interactuar",
        "platform_admin": "Administrador de la plataforma",
        "clinical_director": "Director clínico",
        "hr_manager": "Gerente de recursos humanos",
        "field_staff": "Personal de campo",
        "view_access": "Ver acceso",
        "fill_fields_to_register_client": "Por favor complete todos los campos para registrar a un cliente vulnerable.",
        "client_registered_success": "El cliente {} se registró con éxito en la lista de población vulnerable.",
        "public_health_care_registry": "Registro de atención de salud pública",
        "registered_clients": "Clientes registrados",
        "critical_risk_clients": "Clientes de riesgo crítico",
        "critical_risk": "Riesgo crítico",
        "high_risk": "Alto riesgo",
        "medium_risk": "Riesgo medio",
        "low_risk": "Riesgo bajo",
        "enter_name_witness_verification": "Por favor ingrese su nombre para la verificación del testigo secundario.",
        "pharmacy_narcotic_vault_ledger": "Libro de registro de la bóveda de narcóticos de la farmacia",
        "dispensing_audit_logs": "Registros de auditoría de dispensación",
        "pending_double_signs": "Doble firma pendiente",
        "co_sign": "Co-firmar"
    }
}

for lang_file, translations in keys_to_add.items():
    file_path = os.path.join(TRANSLATIONS_DIR, lang_file)
    if os.path.exists(file_path):
        with open(file_path, "r", encoding="utf-8") as f:
            data = json.load(f)
        
        # Add keys if not already present
        for key, val in translations.items():
            data[key] = val
            
        with open(file_path, "w", encoding="utf-8") as f:
            json.dump(data, f, indent=4, ensure_ascii=False)
        print(f"Updated {lang_file} with new translation keys.")
    else:
        print(f"File not found: {file_path}")
