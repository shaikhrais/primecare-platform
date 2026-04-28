import os
import re

def get_undefined_classes(report_path):
    # Try different encodings
    for encoding in ['utf-8', 'utf-16', 'latin-1']:
        try:
            with open(report_path, 'r', encoding=encoding) as f:
                content = f.read()
                # Extract undefined class names
                matches = re.findall(r"Undefined class '(\w+)'", content)
                if matches: return sorted(list(set(matches)))
        except:
            continue
    return []

def recover_types_v7():
    undefined_classes = get_undefined_classes('analyze_results_recovery_v6.txt')
    if not undefined_classes:
        print("No undefined classes found or file could not be read.")
        return

    typedefs = []
    for cls in undefined_classes:
        if cls.endswith('ViewModel') or cls.endswith('Object'):
            typedefs.append(f'typedef {cls} = PrimeCareViewModel;')
        elif cls.endswith('State') or cls.endswith('Data'):
            typedefs.append(f'typedef {cls} = PrimeCareState;')
        else:
            typedefs.append(f'typedef {cls} = dynamic;')
            
    with open('lib/src/features/features_model.dart', 'a', encoding='utf-8') as f:
        f.write('\n\n// --- Type-Erasure Recovery V7 ---\n')
        f.write('\n'.join(typedefs))
    print(f"Recovered {len(typedefs)} types.")

recover_types_v7()
