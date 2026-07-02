import os
import sqlite3
import re

PROJECT_ROOT = r"C:\Users\Admin2\Documents\GitHub\primecare-platform"
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")
OUTPUT_PATH = os.path.join(PROJECT_ROOT, "packages", "primecare_ui", "lib", "src", "api", "generated", "api_clients.dart")

def clean_camel_case(name):
    # Clean non-alphanumeric chars
    name = re.sub(r'[^a-zA-Z0-9_]', '', name)
    return "".join(p.capitalize() for p in name.split('_') if p)

def get_function_name(api_code):
    api_code_clean = re.sub(r'[^a-zA-Z0-9_]', '_', api_code)
    parts = api_code_clean.split('_')
    method_suffix = parts[-1].lower()
    name_parts = parts[:-1]
    
    if method_suffix not in ['get', 'post', 'patch', 'put', 'delete']:
        name_parts.append(method_suffix)
        method_suffix = 'post'
        
    camel_name = "".join(p.capitalize() for p in name_parts if p)
    
    if method_suffix == 'get':
        return f"load{camel_name}"
    elif method_suffix == 'post':
        if 'login' in api_code.lower():
            return "login"
        if 'register' in api_code.lower():
            return "register"
        return f"create{camel_name}"
    elif method_suffix in ['patch', 'put']:
        return f"update{camel_name}"
    elif method_suffix == 'delete':
        return f"delete{camel_name}"
    return api_code

def main():
    print("==============================================================")
    print("GENERATING TYPE-SAFE API CLIENT CODE FROM DB")
    print("==============================================================")

    if not os.path.exists(DB_PATH):
        print(f"Error: Database not found at {DB_PATH}")
        return

    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    c = conn.cursor()

    c.execute("SELECT * FROM api_registry ORDER BY id ASC")
    apis = c.fetchall()
    print(f"Loaded {len(apis)} APIs from registry.")

    methods_str = []
    
    for api in apis:
        api_code = api["api_code"]
        api_name = api["api_name"]
        method = api["method"].upper()
        path = api["endpoint_path"]
        status = api["status"]
        
        func_name = get_function_name(api_code)
        
        # Check if path contains :id or {id}
        has_id = ":id" in path or "{id}" in path
        
        # Determine signature and dio call path
        call_path = path.replace(":id", "$id").replace("{id}", "$id")
        
        # Build function body
        if method == "GET":
            sig = f"Future<ApiResponse> {func_name}() async"
            body = f"return ref.read(apiClientProvider).get('{call_path}');"
        elif method in ["POST", "PUT", "PATCH"]:
            if has_id:
                sig = f"Future<ApiResponse> {func_name}(String id, dynamic data) async"
                body = f"return ref.read(apiClientProvider).{method.lower()}('{call_path}', body: data);"
            else:
                sig = f"Future<ApiResponse> {func_name}(dynamic data) async"
                body = f"return ref.read(apiClientProvider).{method.lower()}('{call_path}', body: data);"
        elif method == "DELETE":
            if has_id:
                sig = f"Future<ApiResponse> {func_name}(String id) async"
                body = f"return ref.read(apiClientProvider).delete('{call_path}');"
            else:
                sig = f"Future<ApiResponse> {func_name}() async"
                body = f"return ref.read(apiClientProvider).delete('{call_path}');"
        else:
            # Fallback
            sig = f"Future<ApiResponse> {func_name}() async"
            body = f"return ref.read(apiClientProvider).get('{call_path}');"

        methods_str.append(f"""  /// {api_name}
  /// Method: {method} | Path: {path} | Status: {status}
  {sig} {{
    {body}
  }}""")

    methods_code = "\n\n".join(methods_str)

    dart_code = f"""// Governance - Category: adapter | Purpose: Generated type-safe API client wrappers connected to the central API Registry.
// THIS FILE IS GENERATED. DO NOT EDIT DIRECTLY.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/flutter_core.dart';

class GeneratedApiClient {{
  final Ref ref;

  GeneratedApiClient(this.ref);

{methods_code}
}}

/// Provider to access the GeneratedApiClient instance
final generatedApiClientProvider = Provider<GeneratedApiClient>((ref) {{
  return GeneratedApiClient(ref);
}});
"""

    os.makedirs(os.path.dirname(OUTPUT_PATH), exist_ok=True)
    with open(OUTPUT_PATH, "w", encoding="utf-8") as f:
        f.write(dart_code.strip() + "\n")

    conn.close()
    print("API CLIENTS GENERATION COMPLETE!")
    print(f"Generated API client functions inside: {OUTPUT_PATH}")
    print("==============================================================")

if __name__ == "__main__":
    main()
