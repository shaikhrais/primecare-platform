import re

with open('lib/src/features/features_view.dart', 'r', encoding='utf-8') as f:
    content = f.read()

classes_and_types = [
    ('BillingAdminDashboardView', 'BillingAdminDashboardViewModel'),
    ('CeoDashboardView', 'CeoDashboardModel'),
    ('ClientDashboardView', 'ClientViewModel'),
    ('ClientDashboardLegacyView', 'ClientDashboardViewModel'),
    ('ClinicalDirectorDashboardView', 'ClinicalDirectorViewModel'),
    ('ClinicalDirectorDashboardLegacyView', 'ClinicalDirectorDashboardViewModel'),
    ('ClinicDashboardView', 'ClinicDashboardModel'),
    ('CommunityOutreachDashboardView', 'CommunityOutreachDashboardViewModel'),
    ('CorporateGovernanceDashboardView', 'CorporateGovernanceDashboardViewModel'),
    ('IntakeCoordinatorDashboardView', 'IntakeCoordinatorViewModel'),
    ('PatientDashboardView', 'PatientDashboardViewModel'),
    ('PswDashboardView', 'PswViewModel'),
    ('RnDashboardView', 'RnViewModel'),
    ('RpnDashboardView', 'RpnViewModel'),
    ('ShareholderIntelligenceDashboardView', 'ShareholderIntelligenceViewModel'),
]

# Split content by classes
parts = re.split(r'(class \w+(?:Dashboard|Legacy)?View extends ConsumerWidget \{)', content)
new_parts = [parts[0]]

for i in range(1, len(parts), 2):
    class_def = parts[i]
    body = parts[i+1]
    
    # Identify the type for this class
    found_type = None
    for c_name, t_name in classes_and_types:
        if c_name in class_def:
            found_type = t_name
            break
            
    if found_type:
        # replace viewModel as dynamic with viewModel as TYPE
        body = body.replace('viewModel as dynamic', f'viewModel as {found_type}')
        # replace dynamic vm, with TYPE vm,
        body = body.replace('dynamic vm,', f'{found_type} vm,')
        # replace dynamic vm) with TYPE vm)
        body = body.replace('dynamic vm)', f'{found_type} vm)')
        
    new_parts.append(class_def)
    new_parts.append(body)

with open('lib/src/features/features_view.dart', 'w', encoding='utf-8') as f:
    f.write("".join(new_parts))
print("Done")
