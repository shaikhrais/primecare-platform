import os
import re

registry_dir = r'c:\Users\Admin2\Documents\GitHub\primecare-platform\apps\primecare_governance\lib\core\governance\registries'

mapping = {
    'admin_infrastructure_registry.dart': 'AdminInfrastructureRegistryRegistry',
    'business_development_registry.dart': 'BusinessDevelopmentRegistryRegistry',
    'client_portal_registry.dart': 'ClientPortalRegistryRegistry',
    'clinical_registry.dart': 'ClinicalRegistryRegistry',
    'corporate_registry.dart': 'CorporateRegistryRegistry',
    'franchise_registry.dart': 'FranchiseRegistryRegistry',
    'marketing_registry.dart': 'MarketingRegistryRegistry',
    'operational_registry.dart': 'OperationalRegistryRegistry',
    'support_registry.dart': 'SupportRegistryRegistry',
    'workflows_forms_registry.dart': 'WorkflowsFormsRegistryRegistry'
}

for filename, class_name in mapping.items():
    filepath = os.path.join(registry_dir, filename)
    if not os.path.exists(filepath):
        print(f"Skipping {filename} - does not exist")
        continue
        
    print(f"Fixing {filename}...")
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()
        
    # Fix class name
    content = re.sub(r'class [A-Z_]+Registry {', f'class {class_name} {{', content)
    
    # Fix double single quotes like ''/path''
    content = content.replace("''", "'")
    
    # Fix routePath which might have double slashes if I messed up in migration
    # Actually, looking at: routePath: '/'/workflows-and-forms/add-franchise-lead-form'',
    # content.replace("''", "'") will make it routePath: '/'/path'', which is still wrong.
    
    # Let's fix '/'/path' -> '/path'
    content = content.replace("'/'/", "'/")
    
    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(content)

print("Done!")
