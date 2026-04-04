import os
import re

lib_dir = r"c:\Users\Admin2\Documents\GitHub\primecare-platform\apps\mobile_flutter\lib"

endpoints_map = {}
http_regex = re.compile(r"http\.(get|put)\(Uri\.parse\('https?://[^/]+(/v[0-9]+/[^']+)'\)")
http_var_regex = re.compile(r"http\.(get|put)\((?:Uri\.parse\()?['\"]https?://[^/]+(/v[0-9]+/[^'\"]*(?:\$|\\\$)[^'\"]*)['\"](?:\))?")

# Discover static exact endpoints
for root, _, files in os.walk(lib_dir):
    for file in files:
        if not file.endswith(".dart"): continue
        filepath = os.path.join(root, file)
        with open(filepath, 'r', encoding='utf-8') as f:
            content = f.read()

        matches = http_regex.findall(content)
        if matches:
            for match in matches:
                method, path = match
                parts = [p for p in path.split('/') if p and p != 'v1' and '{' not in p and '$' not in p]
                if not parts: continue
                key = parts[0] + ''.join(p.capitalize() for p in parts[1:]).replace('-', '')
                
                count = 1
                orig_key = key
                while key in endpoints_map and endpoints_map[key] != path:
                    key = f"{orig_key}{count}"
                    count += 1
                endpoints_map[key] = path

# Formulate config
api_config = """// Generated Shared ApiConfig for Mobile Architecture
class ApiConfig {
  static const Map<String, String> endpoints = {
"""
for key, path in endpoints_map.items():
    api_config += f"    '{key}': '{path}',\n"
api_config += "  };\n}\n"

with open(os.path.join(lib_dir, "core", "api_config.dart"), "w", encoding='utf-8') as f:
    f.write(api_config)

# Rewrite all strings and link system
for root, _, files in os.walk(lib_dir):
    for file in files:
        if not file.endswith(".dart"): continue
        filepath = os.path.join(root, file)
        with open(filepath, 'r', encoding='utf-8') as f:
            content = f.read()

        new_content = content
        modified = False
        
        matches = http_regex.findall(content)
        if matches:
            for match in matches:
                method, path = match
                keys = [k for k, v in endpoints_map.items() if v == path]
                if not keys: continue
                key = keys[0]
                
                if "import 'package:http" in new_content and "api_config" not in new_content:
                    import_statements = "import 'package:primecare_mobile/core/api_config.dart';\nimport 'package:primecare_mobile/core/api_client.dart';"
                    new_content = re.sub(r"(import 'package:http/http.dart'.*)", r"\1\n" + import_statements, new_content)
                
                # Replace the entire Uri.parse literal block safely with ApiConfig
                new_content = re.sub(
                    r"Uri\.parse\('https?://[^/]+" + re.escape(path) + r"'\)",
                    f"Uri.parse('${{ApiClient.baseUrl}}${{ApiConfig.endpoints['{key}']}}')",
                    new_content
                )
                modified = True
                
        if modified:
            with open(filepath, 'w', encoding='utf-8') as f:
                f.write(new_content)

print(f"Migrated {len(endpoints_map)} endpoints to ApiConfig and decoupled UI components.")
