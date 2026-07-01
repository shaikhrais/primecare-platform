import os
import json
import sqlite3
import math
from datetime import datetime
from pathlib import Path
from PIL import Image, ImageStat

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
DB_PATH = os.path.abspath(os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db"))
SCREENSHOTS_DIR = Path(PROJECT_ROOT) / "cypress" / "screenshots"

MIN_FILE_SIZE = 20_000
MIN_VISUAL_SCORE = 70

def now():
    return datetime.utcnow().isoformat()

def image_score(path):
    try:
        img = Image.open(path).convert("RGB")
        stat = ImageStat.Stat(img)
        # sum of standard deviations across color channels
        std_dev = sum(stat.stddev) / len(stat.stddev)
        variance = sum(stat.var) / len(stat.var)
        size = path.stat().st_size

        # Simple pixel scoring rules
        score = 0
        if size > MIN_FILE_SIZE:
            score += 30
        if variance > 50:
            score += 50
        if img.size[0] > 500 and img.size[1] > 300:
            score += 20

        # Dominant uniform color ratio
        # Convert to grayscale to check flat solid color distribution
        img_gray = img.convert("L")
        pixels = list(img_gray.getdata())
        total_pixels = len(pixels)
        
        # Count identical pixels
        from collections import Counter
        counter = Counter(pixels)
        most_common_color, most_common_count = counter.most_common(1)[0]
        dominant_ratio = most_common_count / total_pixels

        blank = (score < MIN_VISUAL_SCORE) or (std_dev < 3.0) or (dominant_ratio > 0.92)

        return {
            "file": str(path),
            "relative_path": str(path.relative_to(PROJECT_ROOT)).replace("\\", "/"),
            "exists": True,
            "size": size,
            "width": img.size[0],
            "height": img.size[1],
            "std_dev": std_dev,
            "variance": variance,
            "dominant_ratio": dominant_ratio,
            "visual_score": score,
            "blank": blank,
        }
    except Exception as e:
        return {
            "file": str(path),
            "relative_path": str(path.relative_to(PROJECT_ROOT)).replace("\\", "/") if PROJECT_ROOT in str(path) else str(path),
            "exists": False,
            "error": str(e),
            "visual_score": 0,
            "blank": True,
        }

def main():
    print("==============================================================")
    print("PRIMECARE ENTERPRISE GOVERNANCE: CYPRESS SCREENSHOT VALIDATOR")
    print("==============================================================")

    if not os.path.exists(DB_PATH):
        print(f"Error: Database not found at {DB_PATH}")
        raise SystemExit("Database not found.")

    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    cur = conn.cursor()

    # Find all generated screenshot files
    screenshot_files = list(SCREENSHOTS_DIR.rglob("*.png"))
    print(f"Found {len(screenshot_files)} screenshots recursively under {SCREENSHOTS_DIR}")

    results = []
    for path in screenshot_files:
        res = image_score(path)
        results.append(res)

    # Save validation details report
    reports_dir = Path(PROJECT_ROOT) / "tools" / "governance" / "reports"
    reports_dir.mkdir(parents=True, exist_ok=True)
    report_path = reports_dir / "visual_proof_validation.json"
    report_path.write_text(json.dumps(results, indent=2), encoding="utf-8")
    print(f"Detailed visual report written to {report_path.relative_to(PROJECT_ROOT)}")

    # Group and map screenshots to corresponding database rows
    failed = [r for r in results if r.get("blank")]
    run_now = now()

    # 1. Update Screens in registry based on screen code matching
    # Filenames contain the pattern: psw-{screen_code}.png
    for r in results:
        filename = Path(r["file"]).name
        # Match pattern: {role_code}-{screen_code}.png
        if "-" in filename and not filename.startswith("auth-login") and not filename.startswith("language"):
            parts = filename.split("-", 1)
            role_code = parts[0]
            screen_code_with_ext = parts[1]
            screen_code = screen_code_with_ext.rsplit(".", 1)[0]
            
            # Find screen in database
            screen_row = cur.execute("SELECT id, screen_name, app_id FROM screens WHERE screen_code = ?;", (screen_code,)).fetchone()
            if screen_row:
                scr_id = screen_row["id"]
                scr_name = screen_row["screen_name"]
                app_id = screen_row["app_id"]
                
                status_str = "failed" if r["blank"] else "passed"
                score = r["visual_score"]
                blank_flag = 1 if r["blank"] else 0
                
                # Update screens table with Cypress run telemetry!
                cur.execute("""
                    UPDATE screens
                    SET cypress_spec_path = 'cypress/e2e/role/one_role_all_screens.cy.js',
                        cypress_last_status = ?,
                        cypress_last_error = ?,
                        cypress_last_run_at = ?,
                        cypress_screenshot_path = ?,
                        cypress_video_path = 'cypress/videos/role/one_role_all_screens.mp4',
                        screenshot_file_exists = 1,
                        screenshot_file_size_bytes = ?,
                        screenshot_blank_detected = ?,
                        screenshot_visual_score = ?,
                        screenshot_validation_status = ?,
                        visual_proof_verified = ?
                    WHERE id = ?;
                """, (
                    status_str,
                    f"SCREEN REJECTED: Main content placeholder only (Score: {r['visual_score']}/100)" if r["blank"] else None,
                    run_now,
                    r["relative_path"],
                    r["size"],
                    blank_flag,
                    score,
                    status_str,
                    1 if status_str == "passed" else 0,
                    scr_id
                ))
                
                # If failed, add to implementation tasks
                if r["blank"]:
                    cur.execute("""
                        INSERT INTO implementation_tasks (app_id, task_type, related_screen_id, task_title, task_description, status, created_at)
                        VALUES (?, 'visual_proof_failure', ?, ?, ?, 'pending', ?);
                    """, (
                        app_id,
                        scr_id,
                        f"Fix E2E Visual Proof: {scr_name}",
                        f"Cypress screenshot failed Pillow visual checks (Score: {score}/100, StdDev: {r['std_dev']:.2f}, Size: {r['size']/1024:.1f}KB).",
                        run_now
                    ))
                print(f"  Mapped Screen: {scr_name} -> {'SCREEN REJECTED: Main content placeholder only' if r['blank'] else 'PASSED'} (Score: {score}/100)")

    # 2. Update Roles table E2E Auth columns based on auth-login screenshots
    # Filenames contain the pattern: auth-login-{role_code}.png
    for r in results:
        filename = Path(r["file"]).name
        if filename.startswith("auth-login-") and not filename.endswith("success.png"):
            role_code = filename.replace("auth-login-", "").replace(".png", "")
            
            # Find role in database
            role_row = cur.execute("SELECT role_code, role_name FROM roles WHERE role_code = ?;", (role_code,)).fetchone()
            if role_row:
                role_name = role_row["role_name"]
                status_str = "failed" if r["blank"] else "passed"
                
                cur.execute("""
                    UPDATE roles
                    SET auth_test_status = ?,
                        auth_last_error = ?,
                        auth_last_run_at = ?,
                        auth_screenshot_path = ?,
                        auth_video_path = 'cypress/videos/auth/auth_login.cy.js.mp4'
                    WHERE role_code = ?;
                """, (
                    status_str,
                    f"Auth login screen visually blank (StdDev: {r['std_dev']:.2f})" if r["blank"] else None,
                    run_now,
                    r["relative_path"],
                    role_code
                ))
                print(f"  Mapped Role Auth: {role_name} -> {status_str.upper()}")

    # Insert main visual proof validation sweep KPI
    cur.execute("DELETE FROM kpi_results WHERE kpi_code = 'visual_proof_validation';")
    cur.execute("""
      INSERT INTO kpi_results
      (kpi_code, kpi_name, kpi_value, kpi_status, proof_json, proof_log_path, measured_at)
      VALUES (?, ?, ?, ?, ?, ?, CURRENT_TIMESTAMP)
    """, (
        "visual_proof_validation",
        "Visual Proof Validation",
        "failed" if failed else "passed",
        "failed" if failed else "passed",
        json.dumps({"total_screenshots": len(results), "failed_screenshots": len(failed)}),
        "tools/governance/reports/visual_proof_validation.json"
    ))

    conn.commit()
    conn.close()

    if failed:
        print(f"\n[CRITICAL FAILURE] {len(failed)} rejected screenshots detected!")
        raise SystemExit(f"SCREEN REJECTED: Main content placeholder only on {len(failed)} screens.")

    print("\n[SUCCESS] All E2E screenshots successfully passed Pillow visual checks!")

if __name__ == "__main__":
    main()
