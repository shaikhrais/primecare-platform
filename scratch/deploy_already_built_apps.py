import os
import subprocess
import re
import datetime

apps = [
    "primecare_auth",
    "primecare_governance",
    "primecare_client",
    "primecare_clinic",
    "primecare_corporate",
    "primecare_franchise",
    "primecare_marketing",
    "primecare_support",
    "primecare_business_development",
    "primecare_enterprise_blueprint"
]

root_dir = os.getcwd()
results = []

print("=========================================================")
print("DEPLOYING PRE-BUILT APPLICATIONS TO CLOUDFLARE PAGES")
print("=========================================================")

for app in apps:
    project_name = app.replace('_', '-')
    app_path = os.path.join(root_dir, "apps", app)
    build_path = os.path.join(app_path, "build", "web")
    
    print(f"\nProcessing: {app} -> {project_name}")
    
    if not os.path.exists(build_path):
        print(f"Build directory not found: {build_path}")
        results.append({
            "AppName": app,
            "ProjectName": project_name,
            "Status": "Failed",
            "Details": "Build dir not found",
            "URL": "N/A"
        })
        continue

    # Step 1: Generate AssetManifest.json
    print("Step 1: Generating AssetManifest.json...")
    assets_path = os.path.join(build_path, "assets")
    if os.path.exists(assets_path):
        manifest_script = os.path.join(root_dir, "scripts", "generate_asset_manifest.py")
        subprocess.run(["python", manifest_script, assets_path], check=True)
    else:
        print(f"No assets directory found at {assets_path}")
        
    # Step 2: Remove flutter_service_worker.js
    print("Step 2: Disabling service worker cache...")
    sw_file = os.path.join(build_path, "flutter_service_worker.js")
    if os.path.exists(sw_file):
        os.remove(sw_file)
        print("Service worker deleted.")
    else:
        print("Service worker not found/already deleted.")
        
    # Step 3: Deploy to Cloudflare Pages
    print("Step 3: Deploying to Cloudflare Pages...")
    # Run wrangler command from the app's directory
    try:
        # Use shell=True for windows since wrangler is usually a cmd/ps1 wrapper
        # Set encoding="utf-8" and errors="ignore" to avoid charmap codec exceptions on Windows
        result = subprocess.run(
            f"wrangler pages deploy build/web --project-name {project_name} --commit-dirty=true",
            shell=True,
            cwd=app_path,
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT,
            encoding="utf-8",
            errors="ignore"
        )
        deploy_output = result.stdout
        # print deployment output to stdout safely by encoding/decoding or removing non-ascii characters
        safe_output = deploy_output.encode('ascii', 'ignore').decode('ascii')
        print(safe_output)
        
        url = "N/A"
        # Search for page.dev url in the output
        urls = re.findall(r'https://[a-zA-Z0-9.-]+\.pages\.dev', deploy_output)
        if urls:
            url = urls[0].strip('/')
            # Normalize to clean alias if needed
            if f".{project_name}.pages.dev" in url:
                url = f"https://{project_name}.pages.dev"
                
        if "Success" in deploy_output or "Deployment complete" in deploy_output:
            print(f"Successfully deployed to {url}")
            results.append({
                "AppName": app,
                "ProjectName": project_name,
                "Status": "Deployed",
                "Details": "Success",
                "URL": url
            })
        else:
            print("Deployment failed!")
            results.append({
                "AppName": app,
                "ProjectName": project_name,
                "Status": "Failed",
                "Details": "wrangler deploy failed",
                "URL": "N/A"
            })
    except Exception as e:
        print(f"Error during deploy command: {e}")
        results.append({
            "AppName": app,
            "ProjectName": project_name,
            "Status": "Failed",
            "Details": str(e),
            "URL": "N/A"
        })

print("\n=========================================================")
print("DEPLOYMENT CYCLE SUMMARY")
print("=========================================================")
for r in results:
    print(f"{r['AppName']:<35} | {r['Status']:<10} | {r['URL']}")

# Save Markdown report
report_path = os.path.join(root_dir, "artifacts", "cloudflare_deployment_report.md")
md_lines = [
    "# PrimeCare Cloudflare Deployment Report",
    "",
    "This report summarizes the automated deployment of the pre-built PrimeCare Flutter Web applications.",
    "",
    "## Deployment Status Table",
    "",
    "| Application Name | Cloudflare Project | Status | Details | Live URL |",
    "|---|---|---|---|---|"
]

for res in results:
    line = f"| **{res['AppName']}** | `{res['ProjectName']}` | **{res['Status']}** | {res['Details']} | [{res['URL']}]({res['URL']}) |"
    md_lines.append(line)

md_lines.append("")
md_lines.append(f"*Report generated on {datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')}*")

with open(report_path, "w", encoding="utf-8") as f:
    f.write("\n".join(md_lines))

print(f"\nSaved deployment report to {report_path}")
