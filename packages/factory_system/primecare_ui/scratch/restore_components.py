import os
import re

FILES = ['features_view.dart', 'features_controller.dart', 'features_model.dart']
BASE_PATH = r'c:\Users\Admin2\Documents\GitHub\primecare-platform\packages\factory_system\primecare_ui\lib\src\features'

def fix():
    for filename in FILES:
        path = os.path.join(BASE_PATH, filename)
        if not os.path.exists(path): continue
        print(f"Fixing {filename}...")
        with open(path, 'r', encoding='utf-8') as f:
            content = f.read()
        
        # 1. Restore specific corruptions based on common patterns
        # 'const get()' -> 'const LoadingWidget()'
        content = content.replace('const get()', 'const LoadingWidget()')
        content = content.replace('const get(', 'const LoadingWidget(')
        
        # 'get(message:' -> 'GovernanceErrorWidget(message:'
        content = content.replace('get(message:', 'GovernanceErrorWidget(message:')
        
        # 'return out(' -> 'return ResponsiveLayout(' or 'return Layout('
        # Let's check what 'out' was.
        # In many places it's 'return out(' which might be 'return PageTemplate('
        content = content.replace('return out(', 'return PageTemplate(')
        
        # 2. Restore types in build methods
        content = content.replace('Widget build(BuildContext context, WidgetRef ref) {\n    final try =', 'Widget build(BuildContext context, WidgetRef ref) {\n    final state =')
        content = content.replace('ref.read(executionGateProvider)', 'ref.read(executionGateProvider)') # already okay
        
        # 3. Fix the 'get _methodName' corruption
        # 'get _' -> 'Widget _'
        content = re.sub(r'\bget\s+(_[a-zA-Z0-9_]+build)', r'Widget \1', content)
        
        # 4. Fix 'try' as variable name
        content = content.replace('final try =', 'final state =')
        content = content.replace('try.when(', 'state.when(')
        
        # 5. Restore 'double' if it was messed up
        # content = content.replace('class double', '...') # skipped
        
        with open(path, 'w', encoding='utf-8') as f:
            f.write(content)

if __name__ == "__main__":
    fix()
