import re

with open('lib/src/features/features_view.dart', 'r', encoding='utf-8') as f:
    content = f.read()

replacements = [
    ('ClientView', 'ClientViewModel'),
    ('ClinicalDirectorView', 'ClinicalDirectorViewModel'),
    ('IntakeCoordinatorView', 'IntakeCoordinatorViewModel'),
    ('PswView', 'PswViewModel'),
    ('RnView', 'RnViewModel'),
    ('RpnView', 'RpnViewModel'),
    ('ShareholderIntelligenceView', 'ShareholderIntelligenceViewModel'),
]

parts = re.split(r'(class \w+View(?:Model)? extends ConsumerWidget \{)', content)
new_parts = [parts[0]]

for i in range(1, len(parts), 2):
    class_def = parts[i]
    body = parts[i+1]
    
    found_type = None
    for c_name, t_name in replacements:
        if c_name in class_def:
            found_type = t_name
            break
            
    if found_type:
        body = body.replace('viewModel as dynamic', f'viewModel as {found_type}')
        body = body.replace('dynamic vm,', f'{found_type} vm,')
        body = body.replace('dynamic vm)', f'{found_type} vm)')
        
    new_parts.append(class_def)
    new_parts.append(body)

with open('lib/src/features/features_view.dart', 'w', encoding='utf-8') as f:
    f.write("".join(new_parts))
print("Done again")
