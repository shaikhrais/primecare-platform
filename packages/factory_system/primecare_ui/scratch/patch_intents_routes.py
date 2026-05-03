import os
import re

INTENTS = {
    'PswDashboardIntent': '/offices/clinical/roles/psw/dashboard',
    'RmtDashboardIntent': '/offices/clinical/roles/rmt/dashboard',
    'RnDashboardIntent': '/offices/clinical/roles/rn/dashboard',
    'BillingAdminDashboardIntent': '/offices/corporate/roles/billing_admin/dashboard',
    'ComplianceManagerDashboardIntent': '/offices/corporate/roles/compliance_manager/dashboard',
    'CeoDashboardIntent': '/offices/corporate/roles/ceo/dashboard',
    'CtoDashboardIntent': '/offices/corporate/roles/cto/dashboard',
    'CfoDashboardIntent': '/offices/corporate/roles/cfo/dashboard',
    'FinanceDirectorDashboardIntent': '/offices/corporate/roles/finance_director/dashboard',
    'TrainingDirectorDashboardIntent': '/offices/corporate/roles/training_director/dashboard',
    'ClinicalDirectorDashboardIntent': '/offices/clinical/roles/clinical_director/dashboard',
    'GovernanceComplianceDashboardIntent': '/infrastructure/governance/monitor',
}

base_dir = r"c:\Users\Admin2\Documents\GitHub\primecare-platform\packages\factory_system\primecare_ui\lib\src\features"

for root, _, files in os.walk(base_dir):
    for file in files:
        if file.endswith('.dart'):
            filepath = os.path.join(root, file)
            with open(filepath, 'r', encoding='utf-8') as f:
                content = f.read()
            
            updated = False
            for intent_class, route in INTENTS.items():
                if f"class {intent_class}" in content:
                    # Looking for:
                    # IntentClass() : super(title: '...');
                    # Or IntentClass() : super(name: '...', title: '...', route: '...');
                    
                    # Pattern to match the constructor
                    pattern = r"(" + intent_class + r"\(\)\s*:\s*super\([^)]*)\)"
                    
                    def repl(match):
                        inner = match.group(1)
                        if 'route:' not in inner:
                            if inner.endswith('('):
                                return inner + f"route: '{route}'" + ")"
                            else:
                                return inner + f", route: '{route}'" + ")"
                        return match.group(0)
                        
                    new_content = re.sub(pattern, repl, content)
                    if new_content != content:
                        content = new_content
                        updated = True
            
            if updated:
                with open(filepath, 'w', encoding='utf-8') as f:
                    f.write(content)
                print(f"Updated {filepath}")
