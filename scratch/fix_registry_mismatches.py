import os

PROJECT_ROOT = r"c:\Users\Admin2\Documents\GitHub\primecare-platform"
REGISTRY_PATH = os.path.join(PROJECT_ROOT, "packages", "flutter_core", "lib", "registry", "platform_screen_registry.dart")

def main():
    content = open(REGISTRY_PATH, encoding='utf-8').read()
    
    replacements = {
        "'PATIENT_DASHBOARD': ScreenMetadata(\n      id: 'PATIENT_DASHBOARD',\n      featureName: 'Patient Dashboard',\n      title: 'Patient Control Center',\n      routePath: '/roles/patient/dashboard',":
        "'PATIENT_DASHBOARD': ScreenMetadata(\n      id: 'PATIENT_DASHBOARD',\n      featureName: 'Patient Dashboard',\n      title: 'Patient Control Center',\n      routePath: '/offices/client/roles/client/dashboard',",
        
        "'CUSTOMERSUPPORT_DASHBOARD': ScreenMetadata(\n      id: 'CUSTOMERSUPPORT_DASHBOARD',\n      featureName: 'Customer Support Dashboard',\n      title: 'Customer Support Control Center',\n      routePath: '/roles/customer_support/dashboard',":
        "'CUSTOMERSUPPORT_DASHBOARD': ScreenMetadata(\n      id: 'CUSTOMERSUPPORT_DASHBOARD',\n      featureName: 'Customer Support Dashboard',\n      title: 'Customer Support Control Center',\n      routePath: '/offices/support/roles/customer_support/dashboard',",
        
        "'FAMILYMEMBER_DASHBOARD': ScreenMetadata(\n      id: 'FAMILYMEMBER_DASHBOARD',\n      featureName: 'Family Member Dashboard',\n      title: 'Family Member Control Center',\n      routePath: '/roles/family_member/dashboard',":
        "'FAMILYMEMBER_DASHBOARD': ScreenMetadata(\n      id: 'FAMILYMEMBER_DASHBOARD',\n      featureName: 'Family Member Dashboard',\n      title: 'Family Member Control Center',\n      routePath: '/offices/client/roles/family_member/dashboard',",
        
        "'GUEST_DASHBOARD': ScreenMetadata(\n      id: 'GUEST_DASHBOARD',\n      featureName: 'Guest Dashboard',\n      title: 'Guest Control Center',\n      routePath: '/roles/guest/dashboard',":
        "'GUEST_DASHBOARD': ScreenMetadata(\n      id: 'GUEST_DASHBOARD',\n      featureName: 'Guest Dashboard',\n      title: 'Guest Control Center',\n      routePath: '/offices/system/roles/guest/dashboard',",
        
        "'PORTAL_DASHBOARD': ScreenMetadata(\n      id: 'PORTAL_DASHBOARD',\n      featureName: 'Portal Dashboard',\n      title: 'Portal Control Center',\n      routePath: '/roles/portal/dashboard',":
        "'PORTAL_DASHBOARD': ScreenMetadata(\n      id: 'PORTAL_DASHBOARD',\n      featureName: 'Portal Dashboard',\n      title: 'Portal Control Center',\n      routePath: '/offices/client/roles/client/dashboard',",
    }
    
    modified = content
    for old, new in replacements.items():
        if old in content:
            modified = modified.replace(old, new)
            print(f"Replaced routePath for a screen key.")
        else:
            # Let's try with carriage returns as well just in case (Windows style)
            old_win = old.replace('\n', '\r\n')
            new_win = new.replace('\n', '\r\n')
            if old_win in content:
                modified = modified.replace(old_win, new_win)
                print(f"Replaced routePath (Windows encoding) for a screen key.")
            else:
                print(f"Warning: could not find key block in platform_screen_registry.dart!")
                
    with open(REGISTRY_PATH, "w", encoding="utf-8") as f:
        f.write(modified)
        
    print("Done fixing platform_screen_registry.dart mismatches.")

if __name__ == '__main__':
    main()
