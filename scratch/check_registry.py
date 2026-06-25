import re

with open("packages/flutter_core/lib/registry/platform_screen_registry.dart", "r", encoding="utf-8") as f:
    content = f.read()

# Let's find each ScreenMetadata definition and extract its id and routePath
pattern = r"'(.*?)'\s*:\s*ScreenMetadata\((.*?)\)"
matches = re.finditer(r"'([A-Z_0-9]+)'\s*:\s*ScreenMetadata\((.*?)\),", content, re.DOTALL)

screen_routes = {}
for m in matches:
    key = m.group(1)
    body = m.group(2)
    # find routePath in body
    rp_match = re.search(r"routePath\s*:\s*'(.*?)'", body)
    if rp_match:
        screen_routes[key] = rp_match.group(1)
    else:
        # Check if it uses a constant
        rp_const_match = re.search(r"routePath\s*:\s*([A-Za-z0-9\.]+)", body)
        if rp_const_match:
            screen_routes[key] = rp_const_match.group(1)

# print routePaths for our target keys
keys_to_check = [
    'PHYSICIAN_DASHBOARD', 'CNS_DASHBOARD', 'PEDIATRIC_DASHBOARD', 'GUEST_DASHBOARD',
    'TERRITORYSALESMANAGER_DASHBOARD', 'HSW_DASHBOARD', 'RNFIELDSUPERVISOR_DASHBOARD',
    'NP_DASHBOARD', 'LPN_DASHBOARD', 'SCREEN_CUSTOMER_SUPPORT_DASHBOARD', 'QASPECIALIST_DASHBOARD',
    'FAMILYMEMBER_DASHBOARD', 'PATIENT_DASHBOARD'
]

for k in keys_to_check:
    print(f"{k:<35} : {screen_routes.get(k, 'Not Found')}")
