import os
import shutil

PROJECT_ROOT = r"c:\Users\Admin2\Documents\GitHub\primecare-platform"
GOV_WEB_DIR = os.path.join(PROJECT_ROOT, "apps", "primecare_governance", "web")

def fix():
    index_path = os.path.join(GOV_WEB_DIR, "index.html")
    dash_path = os.path.join(GOV_WEB_DIR, "dashboard.html")
    
    # 1. Copy current index.html (the HTML dashboard) to dashboard.html
    if os.path.exists(index_path):
        shutil.copy2(index_path, dash_path)
        print(f"Copied HTML dashboard to {dash_path}")
    
    # 2. Define standard Flutter Web index.html content
    flutter_index_html = """<!DOCTYPE html>
<html>
<head>
  <base href="/">

  <meta charset="UTF-8">
  <meta content="IE=Edge" http-equiv="X-UA-Compatible">
  <meta name="description" content="PrimeCare Visual Governance and Compliance platform.">

  <!-- iOS meta tags & icons -->
  <meta name="mobile-web-app-capable" content="yes">
  <meta name="apple-mobile-web-app-status-bar-style" content="black">
  <meta name="apple-mobile-web-app-title" content="primecare_governance">
  <link rel="apple-touch-icon" href="icons/Icon-192.png">

  <!-- Favicon -->
  <link rel="icon" type="image/png" href="favicon.png"/>

  <title>PrimeCare Governance</title>
  <link rel="manifest" href="manifest.json">
</head>
<body>
  <script src="flutter_bootstrap.js" async></script>
</body>
</html>
"""
    
    # 3. Write standard Flutter Web index.html
    with open(index_path, "w", encoding="utf-8") as f:
        f.write(flutter_index_html)
    print(f"Restored standard Flutter Web index.html at {index_path}")

if __name__ == "__main__":
    fix()
