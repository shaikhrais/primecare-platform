import os
import re

FILES = ['features_view.dart', 'features_controller.dart', 'features_model.dart']
BASE_PATH = r'c:\Users\Admin2\Documents\GitHub\primecare-platform\packages\factory_system\primecare_ui\lib\src\features'

BLACKLIST = [
    'class', 'abstract', 'mixin', 'enum', 'extension', 'final', 'const', 'var', 'void', 'Future', 'Stream', 
    'return', 'if', 'else', 'for', 'while', 'switch', 'case', 'break', 'continue', 'default', 'try', 'catch', 
    'finally', 'throw', 'rethrow', 'import', 'export', 'part', 'library', 'as', 'show', 'hide', 'is', 'in', 
    'out', 'extends', 'with', 'implements', 'external', 'factory', 'get', 'set', 'operator', 'static', 
    'typedef', 'covariant', 'late', 'required', 'yield', 'async', 'await',
    'state', 'copyWith', 'tr', 'ref', 'context', 'super', 'this', 'build', 'initState', 'dispose', 
    'createState', 'watch', 'read', 'notifier', 'initial', 'value', 'map', 'when', 'maybeWhen', 'data', 'error', 'loading',
    'StatelessWidget', 'StatefulWidget', 'ConsumerWidget', 'ConsumerState'
]

def fix():
    for filename in FILES:
        path = os.path.join(BASE_PATH, filename)
        if not os.path.exists(path): continue
        
        print(f"Fixing {filename}...")
        with open(path, 'r', encoding='utf-8') as f:
            content = f.read()
            
        for word in BLACKLIST:
            # Only replace if Word starts with lowercase or is a specific keyword
            if word[0].islower() or word in ['class', 'abstract', 'mixin', 'enum', 'extension', 'void']:
                 # Use a regex that ensures there is a Prefix before the word
                 # Prefix must start with Uppercase
                 content = re.sub(r'(?<!\w)[A-Z][a-zA-Z0-9_]*' + word + r'(?!\w)', word, content)
            
        with open(path, 'w', encoding='utf-8') as f:
            f.write(content)
    print("Done.")

if __name__ == "__main__":
    fix()
