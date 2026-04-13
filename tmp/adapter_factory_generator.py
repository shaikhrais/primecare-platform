import os
import sys
import re
from pathlib import Path

def to_camel_case(snake_str):
    components = snake_str.replace('-', '_').split('_')
    return components[0] + ''.join(x.title() for x in components[1:])

def to_pascal_case(snake_str):
    components = snake_str.replace('-', '_').split('_')
    return ''.join(x.title() for x in components)

def generate_adapters_for_chunk(chunk_index):
    base_dir = r"c:\Users\Admin2\Documents\GitHub\primecare-platform"
    patterns = ["*_screen.dart", "*_dashboard*.dart", "*_view.dart", "*_page.dart", "*_widget.dart", "*_component.dart", "*.tsx", "*_form.dart", "*_layout.dart", "*_shell.dart", "page.tsx", "layout.tsx"]
    all_screens = []

    for p in patterns:
        all_screens.extend(Path(base_dir).rglob(p))

    valid_screens = []
    for s in all_screens:
        path_str = str(s).lower()
        if ".dart_tool" not in path_str and "build" not in path_str and "node_modules" not in path_str and "archive" not in path_str and "tmp" not in path_str:
            valid_screens.append(s)

    valid_screens = list(set([str(s.resolve()) for s in valid_screens]))
    valid_screens.sort()

    start_idx = (chunk_index - 1) * 100
    end_idx = chunk_index * 100
    chunk = valid_screens[start_idx:end_idx]

    generated_count = 0
    flutter_providers = []
    react_hooks = []

    for s_path_str in chunk:
        s_path = Path(s_path_str)
        basename = s_path.stem
        is_dart = s_path.suffix == ".dart"
        
        # Clean basename for class names
        clean_name = basename.replace('.screen', '').replace('.page', '').replace('.component', '')
        pascal_name = to_pascal_case(clean_name)
        camel_name = to_camel_case(clean_name)
        
        if is_dart:
            adapter_path = s_path.parent / f"{clean_name}_adapter.dart"
            if not adapter_path.exists():
                content = f"""import 'package:flutter_riverpod/flutter_riverpod.dart';
// Prisma Load Adapter

class {pascal_name}ViewModel {{
  final bool isLoading;
  final dynamic data;
  {pascal_name}ViewModel({{this.isLoading = false, this.data}});
}}

class {pascal_name}Adapter extends StateNotifier<{pascal_name}ViewModel> {{
  {pascal_name}Adapter() : super({pascal_name}ViewModel());
  
  Future<void> loadData() async {{
     // TODO: Prisma API binding
     state = {pascal_name}ViewModel(isLoading: true, data: state.data);
     // Simulate fetch
     state = {pascal_name}ViewModel(isLoading: false, data: {{}});
  }}
}}

final {camel_name}AdapterProvider = StateNotifierProvider<{pascal_name}Adapter, {pascal_name}ViewModel>((ref) {{
  return {pascal_name}Adapter();
}});
"""
                with open(adapter_path, 'w', encoding='utf-8') as f:
                    f.write(content)
                generated_count += 1
                flutter_providers.append((adapter_path, f"{camel_name}AdapterProvider"))
        else:
            # TSX/React Route
            adapter_path = s_path.parent / f"use{pascal_name}Adapter.ts"
            if not adapter_path.exists():
                content = f"""// Prisma Load Adapter React Hook
import {{ useState, useCallback }} from 'react';

export const use{pascal_name}Adapter = () => {{
    const [isLoading, setIsLoading] = useState(false);
    const [data, setData] = useState<any>(null);

    const loadData = useCallback(async () => {{
        setIsLoading(true);
        // TODO: Prisma DB endpoint fetch
        setData({{}});
        setIsLoading(false);
    }}, []);

    return {{ isLoading, data, loadData }};
}};
"""
                with open(adapter_path, 'w', encoding='utf-8') as f:
                    f.write(content)
                generated_count += 1
                react_hooks.append((adapter_path, f"use{pascal_name}Adapter"))

    print(f"[{chunk_index}00s] Successfully generated {generated_count} adapter instances.")

if __name__ == "__main__":
    c_idx = int(sys.argv[1])
    generate_adapters_for_chunk(c_idx)
