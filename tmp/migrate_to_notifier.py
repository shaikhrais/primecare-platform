import os
import re
from pathlib import Path

def migrate_to_notifier():
    base_dir = r"c:\Users\Admin2\Documents\GitHub\primecare-platform"
    # only flutter_core and factory_system/primecare_ui have adapters
    dart_paths = list(Path(base_dir).rglob("*_adapter.dart"))
    
    count = 0
    for dp in dart_paths:
        with open(dp, 'r', encoding='utf-8') as f:
            content = f.read()

        changed = False

        # 1. Replace StateNotifierProvider with NotifierProvider
        if 'StateNotifierProvider<' in content:
            content = content.replace('StateNotifierProvider<', 'NotifierProvider<')
            # The provider function signature is slightly different if using lambdas, but () { return Foo(); } works for NotifierProvider too in latest riverpod.
            # Wait, NotifierProvider takes a constructor reference like Foo.new or a lambda `() => Foo()`.
            # Generated was: StateNotifierProvider<A, B>((ref) {\n  return A();\n});
            # We change `(ref) {` to `() {`
            content = re.sub(r'NotifierProvider<([\w]+),\s*([\w]+)>\(\(ref\)\s*\{', r'NotifierProvider<\1, \2>(() {', content)
            changed = True

        # 2. Replace StateNotifier with Notifier and constructor with build() method
        # Match: class Foo extends StateNotifier<Bar> {\n  Foo() : super(Bar());
        match = re.search(r'class\s+(\w+)\s+extends\s+StateNotifier<(\w+)>\s*\{\s*\1\(\)\s*:\s*super\((.*?)\);\s*', content, re.MULTILINE | re.DOTALL)
        if match:
            class_name = match.group(1)
            view_model = match.group(2)
            init_val = match.group(3)
            
            replacement = f"class {class_name} extends Notifier<{view_model}> {{\n  @override\n  {view_model} build() {{\n    return {init_val};\n  }}\n  "
            
            content = content[:match.start()] + replacement + content[match.end():]
            changed = True

        if changed:
            with open(dp, 'w', encoding='utf-8') as f:
                f.write(content)
            count += 1
            
    print(f"Migrated {count} adapters to standard Notifier pattern.")

if __name__ == "__main__":
    migrate_to_notifier()
