import os

pubspecs_to_fix = [
    r"./packages/flutter_ui/pubspec.yaml",
    r"./apps/primecare_corporate/pubspec.yaml",
    r"./apps/primecare_clinic/pubspec.yaml",
    r"./apps/primecare_client/pubspec.yaml",
    r"./apps/primecare_franchise/pubspec.yaml",
    r"./apps/primecare_support/pubspec.yaml",
    r"./apps/primecare_business_development/pubspec.yaml",
    r"./apps/primecare_marketing/pubspec.yaml"
]

for pubspec in pubspecs_to_fix:
    if os.path.exists(pubspec):
        with open(pubspec, 'r', encoding='utf-8') as f:
            content = f.read()

        # Fix literal \n
        content = content.replace(r"\n", "\n")
        
        with open(pubspec, 'w', encoding='utf-8') as f:
            f.write(content)
        print(f"Fixed {pubspec}")
