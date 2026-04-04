import os
import re

base_dir = r"c:\Users\Admin2\Documents\GitHub\primecare-platform\apps\primecare_v4\lib"
router_path = os.path.join(base_dir, "routes", "app_router.dart")

with open(router_path, "r", encoding='utf-8') as f:
    original = f.read()

# We want to replace all occurrences of:
#       ]
#       ),
# 
#       ShellRoute(
#         builder: (context, state, child) => MasterLayout(shellType: ...),
#         routes: [
# 
# With nothing! Meaning they all merge into the FIRST ShellRoute array.

# Let's use regex to find the inter-ShellRoute boundaries and delete them.
# The boundary looks generally like:
#         ]
#       ),
#       
#       ShellRoute(
#         builder: (context, state, child) => MasterLayout(shellType: AppShellType.something, child: child),
#         routes: [

pattern = r"\s*\]\s*\),\s*ShellRoute\(\s*builder:\s*\(context,\s*state,\s*child\)\s*=>\s*MasterLayout\(shellType:\s*AppShellType\.[a-z]+,\s*child:\s*child\),\s*routes:\s*\["

merged_content = re.sub(pattern, "", original)

# Now, the very first ShellRoute still has:
#       ShellRoute(
#         builder: (context, state, child) => MasterLayout(shellType: AppShellType.none, child: child),
#         routes: [
# Let's change it so it dynamically resolves the shell type from authState!

first_shell_pattern = r"ShellRoute\(\s*builder:\s*\(context,\s*state,\s*child\)\s*=>\s*MasterLayout\(shellType:\s*AppShellType\.none,\s*child:\s*child\),"

new_builder = """ShellRoute(
        builder: (context, state, child) {
          final role = authState.role ?? '';
          AppShellType type = AppShellType.none;
          if (role == 'ceo' || role.endsWith('manager') || role == 'scrum_master') {
            type = AppShellType.admin;
          } else if (role == 'client' || role == 'family_member') {
            type = AppShellType.client;
          } else if (role.isNotEmpty) {
            type = AppShellType.provider;
          }
          return MasterLayout(shellType: type, child: child);
        },"""

merged_content = re.sub(first_shell_pattern, new_builder, merged_content)

with open(router_path, "w", encoding='utf-8') as f:
    f.write(merged_content)

print("Flattened ShellRoutes into ONE dynamic layout.")
