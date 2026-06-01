import os
import sys
import subprocess
import time

PROJECT_ROOT = r"C:\Users\Admin2\Documents\GitHub\primecare-platform"

CLINICAL_ROLES = [
    ("chiropractor", "role_chiropractor_all_screens.cy.js"),
    ("physio", "role_physio_all_screens.cy.js"),
    ("rmt", "role_rmt_all_screens.cy.js"),
    ("social_worker", "role_social_worker_all_screens.cy.js"),
    ("clinical_director", "role_clinical_director_all_screens.cy.js"),
    ("intake", "role_intake_all_screens.cy.js"),
    ("rn", "role_rn_all_screens.cy.js"),
    ("psw", "role_psw_all_screens.cy.js"),
    ("rpn", "role_rpn_all_screens.cy.js"),
    ("lpn", "role_lpn_all_screens.cy.js"),
    ("np", "role_np_all_screens.cy.js"),
    ("hsw", "role_hsw_all_screens.cy.js"),
    ("pediatric", "role_pediatric_all_screens.cy.js"),
    ("physician", "role_physician_all_screens.cy.js"),
]

def main():
    timestamp = time.strftime("%Y-%m-%d_%H-%M-%S")
    total = len(CLINICAL_ROLES)
    results = []
    print(f"\n==========================================================")
    print(f"STARTING ALL CLINICAL ROLES E2E SWEEP ({total} Specs Total)")
    print(f"Screenshots folder: cypress/screenshots/{timestamp}/")
    print(f"==========================================================\n")

    for idx, (role, spec_file) in enumerate(CLINICAL_ROLES, 1):
        spec_path = f"cypress/e2e/04_roles/{spec_file}"
        
        # Calculate progress bar using standard characters
        filled_length = int(10 * idx // total)
        bar = "#" * filled_length + "-" * (10 - filled_length)
        
        print(f"[{idx}/{total}] [{bar}] - Running Cypress spec for clinical role: {role.upper()}...")
        print(f"Spec file: {spec_path}\n")
        
        start_time = time.time()
        
        # Set environment variables for this process
        proc_env = os.environ.copy()
        proc_env["CYPRESS_BASE_URL"] = os.environ.get("CYPRESS_BASE_URL", "https://primecare-clinic.pages.dev")
        
        # Stream the Cypress output directly
        # Run Cypress spec using robust subprocess.run
        screenshots_folder = f"cypress/screenshots/{timestamp}/{role}"
        print(f"   Running Cypress E2E sweep...")
        sys.stdout.flush()
        
        res = subprocess.run(
            f"cypress run --browser chrome --spec {spec_path} --config screenshotsFolder={screenshots_folder}",
            capture_output=True,
            text=True,
            errors="ignore",
            shell=True,
            cwd=PROJECT_ROOT,
            env=proc_env
        )
        
        # Parse and print key progress lines from captured output
        for line in res.stdout.splitlines():
            clean_line = line.strip()
            if not clean_line:
                continue
            # Strip non-ascii chars to prevent encoding errors
            clean_line = clean_line.encode('ascii', 'ignore').decode('ascii')
            if "PROGRESS:" in clean_line or "failing" in clean_line or "passing" in clean_line or "CypressError" in clean_line or "All specs passed" in clean_line:
                print(f"   {clean_line}")
                sys.stdout.flush()
                
        duration = int(time.time() - start_time)
        status = "PASSED" if res.returncode == 0 else "FAILED"
        
        results.append((role, status, duration))
        
        if status == "PASSED":
            print(f"\n[OK] [{idx}/{total}] - {role.upper()} E2E sweep passed successfully in {duration}s!\n")
        else:
            print(f"\n[FAIL] [{idx}/{total}] - {role.upper()} E2E sweep FAILED in {duration}s!\n")

    print(f"==========================================================")
    print(f"E2E SWEEP SUMMARY TABLE")
    print(f"==========================================================")
    print(f"{'Role Code':<25} | {'Status':<10} | {'Duration':<8}")
    print(f"-" * 50)
    
    passed_count = 0
    for role, status, duration in results:
        status_label = "PASSED" if status == "PASSED" else "FAILED"
        if status == "PASSED":
            passed_count += 1
        print(f"{role:<25} | {status_label:<10} | {duration}s")
        
    print(f"\nOverall Sweep Result: {passed_count}/{total} clinical roles passed!")
    print(f"==========================================================\n")
    
    if passed_count < total:
        sys.exit(1)
    sys.exit(0)

if __name__ == '__main__':
    main()
