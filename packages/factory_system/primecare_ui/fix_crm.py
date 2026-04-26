import os

files = [
    r'lib\src\components\forms\crm\01_I_assign_lead_form.dart',
    r'lib\src\components\forms\crm\01_I_create_ad_placement_form.dart',
    r'lib\src\components\forms\crm\01_I_franchise_onboarding_checklist_form.dart',
    r'lib\src\components\forms\crm\01_I_log_franchisee_vetting_call_form.dart',
    r'lib\src\components\forms\crm\01_I_nurture_localized_lead_form.dart',
    r'lib\src\components\forms\crm\01_I_review_lead_conversion_form.dart',
    r'lib\src\components\forms\crm\01_I_review_market_share_form.dart',
    r'lib\src\components\forms\crm\01_I_schedule_open_house_form.dart',
    r'lib\src\components\forms\crm\01_I_submit_marketing_budget_form.dart',
    r'lib\src\components\forms\domain_forms\01_I_create_user_form.dart',
    r'lib\src\components\forms\domain_forms\01_I_password_reset_form.dart',
]

for fpath in files:
    if os.path.exists(fpath):
        with open(fpath, 'r', encoding='utf-8') as f:
            content = f.read()
        if 'primecare_ui.dart' not in content:
            content = "import 'package:primecare_ui/primecare_ui.dart';\n" + content
            with open(fpath, 'w', encoding='utf-8') as f:
                f.write(content)
            print(f'Fixed {fpath}')
