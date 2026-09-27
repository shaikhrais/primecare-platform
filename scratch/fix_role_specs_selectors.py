import os

CYPRESS_DIR = r"c:\Users\Admin2\Documents\GitHub\primecare-platform\cypress\e2e\04_roles"

REPLACEMENTS = {
    'licensed practical nurse (lpn) analytics-screen': 'lpnanalytics-screen',
    'licensed practical nurse (lpn) analytics-title': 'lpnanalytics-title',
    'licensed practical nurse (lpn) analytics-content': 'lpnanalytics-content',
    
    'licensed practical nurse (lpn) compliance workflow-screen': 'lpnworkflow-screen',
    'licensed practical nurse (lpn) compliance workflow-title': 'lpnworkflow-title',
    'licensed practical nurse (lpn) compliance workflow-content': 'lpnworkflow-content',
    
    'nurse practitioner (np) analytics-screen': 'npanalytics-screen',
    'nurse practitioner (np) analytics-title': 'npanalytics-title',
    'nurse practitioner (np) analytics-content': 'npanalytics-content',
    
    'nurse practitioner (np) compliance workflow-screen': 'npworkflow-screen',
    'nurse practitioner (np) compliance workflow-title': 'npworkflow-title',
    'nurse practitioner (np) compliance workflow-content': 'npworkflow-content',
    
    'pediatric specialist analytics-screen': 'pediatricanalytics-screen',
    'pediatric specialist analytics-title': 'pediatricanalytics-title',
    'pediatric specialist analytics-content': 'pediatricanalytics-content',
    
    'pediatric specialist compliance workflow-screen': 'pediatricworkflow-screen',
    'pediatric specialist compliance workflow-title': 'pediatricworkflow-title',
    'pediatric specialist compliance workflow-content': 'pediatricworkflow-content',
    
    'physician analytics-screen': 'physiciananalytics-screen',
    'physician analytics-title': 'physiciananalytics-title',
    'physician analytics-content': 'physiciananalytics-content',
    
    'physician compliance workflow-screen': 'physicianworkflow-screen',
    'physician compliance workflow-title': 'physicianworkflow-title',
    'physician compliance workflow-content': 'physicianworkflow-content',
}

def main():
    for f in os.listdir(CYPRESS_DIR):
        if not f.endswith(".cy.js"):
            continue
            
        file_path = os.path.join(CYPRESS_DIR, f)
        with open(file_path, "r", encoding="utf-8") as file:
            content = file.read()
            
        original = content
        for messy, clean in REPLACEMENTS.items():
            content = content.replace(messy, clean)
            
        if content != original:
            with open(file_path, "w", encoding="utf-8") as file:
                file.write(content)
            print(f"Patched selectors in: {f}")

if __name__ == '__main__':
    main()
