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
        
        # 1. Restore core Flutter base classes
        # 'extends get' was likely 'extends ConsumerStatefulWidget' or 'extends StatefulWidget'
        # In this project, most are ConsumerStatefulWidget if they have a State.
        content = content.replace(' extends get {', ' extends ConsumerStatefulWidget {')
        content = content.replace(' extends out {', ' extends StatelessWidget {')
        
        # 2. Restore mixins
        content = content.replace(' with in {', ' with TickerProviderStateMixin {')
        
        # 3. Restore build method signature
        content = content.replace(' @override get build(', ' @override Widget build(')
        content = content.replace(' @override\n  get build(', ' @override\n  Widget build(')
        
        # 4. Fix 'out' (AuthLayout corruption)
        content = content.replace('class out extends', 'class AuthLayout extends')
        content = content.replace('ConsumerState<out>', 'ConsumerState<AuthLayout>')
        content = content.replace('extends ConsumerState<out>', 'extends ConsumerState<AuthLayout>')
        
        # 5. Fix 'AuthForgotPasswordViewAuthView' (Double prefixing?)
        content = content.replace('AuthForgotPasswordViewAuthView', 'AuthForgotPasswordView')
        
        # 6. Fix 'AdministrativeFormsstate' -> 'state' (if any left)
        # ...
        
        with open(path, 'w', encoding='utf-8') as f:
            f.write(content)

if __name__ == "__main__":
    fix()
