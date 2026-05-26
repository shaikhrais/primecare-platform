import os
import json
import sqlite3
import math
from datetime import datetime
from pathlib import Path
from collections import Counter
from PIL import Image

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
DB_PATH = os.path.abspath(os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db"))
REPORT_DIR = os.path.abspath(os.path.join(PROJECT_ROOT, "tools", "governance", "reports"))
Path(REPORT_DIR).mkdir(parents=True, exist_ok=True)

def now():
    return datetime.utcnow().isoformat()

def analyze_image_with_pil(img_path):
    """
    Analyzes an image file using Pillow to check for size, size-checks, 
    blankness, and visual complexity/variance.
    Returns: (size_bytes, width, height, std_dev, blank_detected, blank_white_ratio, visual_score)
    """
    size_bytes = os.path.getsize(img_path)
    
    # 1. Size Check
    if size_bytes < 20 * 1024: # 20KB minimum
        return size_bytes, 0, 0, 0.0, True, 1.0, 0, "size_too_small"

    try:
        with Image.open(img_path) as img:
            width, height = img.size
            
            # Convert to grayscale for easy brightness analysis
            img_gray = img.convert('L')
            pixels = list(img_gray.getdata())
            total_pixels = len(pixels)
            
            if total_pixels == 0:
                return size_bytes, width, height, 0.0, True, 1.0, 0, "zero_pixels"

            # 2. Calculate Standard Deviation (Pixel Variance)
            mean = sum(pixels) / total_pixels
            variance = sum((p - mean) ** 2 for p in pixels) / total_pixels
            std_dev = math.sqrt(variance)
            
            # 3. Detect dominant uniform color (blankness/white ratio)
            counter = Counter(pixels)
            most_common_color, most_common_count = counter.most_common(1)[0]
            blank_white_ratio = most_common_count / total_pixels

            # 4. Standard rules for blankness
            # Standard deviation < 3.0 or dominant color occupies > 90%
            blank_detected = False
            failure_reason = None
            
            if std_dev < 3.0:
                blank_detected = True
                failure_reason = "image_completely_uniform"
            elif blank_white_ratio > 0.90:
                blank_detected = True
                failure_reason = "dominant_color_exceeds_90_percent"

            # 5. Calculate visual score (0-100) based on std_dev and variance
            visual_score = max(0, min(100, int(std_dev * 2.2)))
            
            # Penalty for blankness
            if blank_detected:
                visual_score = min(visual_score, 10)

            return size_bytes, width, height, std_dev, blank_detected, blank_white_ratio, visual_score, failure_reason
            
    except Exception as e:
        return size_bytes, 0, 0, 0.0, True, 1.0, 0, f"pil_error: {str(e)}"

def main():
    import sys
    role_filter = sys.argv[1] if len(sys.argv) > 1 else None

    print("==============================================================")
    # Visual Proof Verification Suite using PIL
    print("PRIMECARE CYPRESS GOVERNANCE: VISUAL PROOF VALIDATOR")
    if role_filter:
        print(f"Filtering by role: {role_filter}")
    print("==============================================================")

    if not os.path.exists(DB_PATH):
        print(f"Error: Database not found at {DB_PATH}")
        return

    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    cur = conn.cursor()

    if role_filter:
        screens = cur.execute("""
            SELECT id, screen_code, screen_name, route_path, screenshot_path, allowed_roles_text, app_id
            FROM screens
            WHERE screenshot_path IS NOT NULL AND screenshot_path != ''
              AND allowed_roles_text LIKE ?;
        """, (f"%{role_filter}%",)).fetchall()
    else:
        screens = cur.execute("""
            SELECT id, screen_code, screen_name, route_path, screenshot_path, allowed_roles_text, app_id
            FROM screens
            WHERE screenshot_path IS NOT NULL AND screenshot_path != '';
        """).fetchall()

    if not screens:
        print("No screenshots registered for validation inside screens table.")
        conn.close()
        return

    print(f"Loaded {len(screens)} screens with screenshot paths to validate...")
    
    validation_records = []
    any_failed = False
    run_now = now()

    # Create directory for reports if it doesn't exist
    Path(REPORT_DIR).mkdir(parents=True, exist_ok=True)

    for s in screens:
        scr_id = s["id"]
        name = s["screen_name"]
        code = s["screen_code"]
        route = s["route_path"]
        relative_path = s["screenshot_path"]
        app_id = s["app_id"]

        physical_path = os.path.abspath(os.path.join(PROJECT_ROOT, relative_path))
        print(f"\nAnalyzing Screen: {name} ({code})")
        print(f"  Screenshot Path: {relative_path}")

        file_exists = os.path.exists(physical_path)
        
        if not file_exists:
            print(f"  [ERROR] File does not exist at: {physical_path}")
            
            # Update screen registry with failure
            cur.execute("""
                UPDATE screens
                SET screenshot_file_exists = 0,
                    screenshot_file_size_bytes = 0,
                    screenshot_blank_detected = 1,
                    screenshot_visual_score = 0,
                    screenshot_validation_status = 'failed',
                    visual_proof_verified = 0
                WHERE id = ?;
            """, (scr_id,))
            
            # Create failure task in implementation_tasks
            cur.execute("""
                INSERT INTO implementation_tasks (app_id, task_type, related_screen_id, task_title, task_description, status, created_at)
                VALUES (?, 'visual_proof_failure', ?, ?, ?, 'pending', ?);
            """, (
                app_id,
                scr_id,
                f"Fix E2E Visual Proof: {name}",
                f"Screenshot file does not exist at: {relative_path}. Visual validation failed.",
                run_now
            ))
            
            validation_records.append({
                "screen_id": scr_id,
                "screen_name": name,
                "screenshot_path": relative_path,
                "status": "failed",
                "reason": "file_not_found"
            })
            any_failed = True
            continue

        # File exists, analyze using Pillow
        size_bytes, w, h, std_dev, blank, ratio, score, reason = analyze_image_with_pil(physical_path)
        
        passed = (not blank) and (size_bytes >= 20 * 1024) and (score >= 60)
        status_str = "passed" if passed else "failed"

        print(f"  Dimensions: {w}x{h} px | Size: {size_bytes / 1024:.2f} KB")
        print(f"  Pixel Standard Deviation: {std_dev:.2f} (Variance: {std_dev**2:.2f})")
        print(f"  Dominant Color Ratio: {ratio * 100:.1f}%")
        print(f"  Visual Score: {score}/100")
        print(f"  Validation Status: {status_str.upper()}")

        if not passed:
            print(f"  [ERROR] Failure Reason: {reason or 'visual_score_below_60'}")
            any_failed = True
            
            # Create failure task in implementation_tasks
            cur.execute("""
                INSERT INTO implementation_tasks (app_id, task_type, related_screen_id, task_title, task_description, status, created_at)
                VALUES (?, 'visual_proof_failure', ?, ?, ?, 'pending', ?);
            """, (
                app_id,
                scr_id,
                f"Fix E2E Visual Proof: {name}",
                f"Screenshot failed visual check: {reason or 'visual_score_below_60'}. Score: {score}/100. Size: {size_bytes/1024:.1f}KB.",
                run_now
            ))

        # Update screens table E2E visual telemetry
        cur.execute("""
            UPDATE screens
            SET screenshot_file_exists = 1,
                screenshot_file_size_bytes = ?,
                screenshot_blank_detected = ?,
                screenshot_visual_score = ?,
                screenshot_validation_status = ?,
                visual_proof_verified = ?
            WHERE id = ?;
        """, (size_bytes, 1 if blank else 0, score, status_str, 1 if passed else 0, scr_id))

        validation_records.append({
            "screen_id": scr_id,
            "screen_name": name,
            "route_path": route,
            "screenshot_path": relative_path,
            "status": status_str,
            "dimensions": f"{w}x{h}",
            "size_kb": round(size_bytes / 1024, 2),
            "std_dev": round(std_dev, 2),
            "dominant_color_ratio": round(ratio, 4),
            "visual_score": score,
            "failure_reason": reason
        })

    # Save details report
    report_path = os.path.join(REPORT_DIR, "visual_proof_validation.json")
    with open(report_path, "w", encoding="utf-8") as f:
        json.dump(validation_records, f, indent=2)

    # 7. Update governance_functions and kpi_results status
    overall_status = "failed" if any_failed else "passed"
    
    # Check if a function run context exists for ID 22
    fn_row = cur.execute("SELECT id FROM governance_functions WHERE id = 22;").fetchone()
    if fn_row:
        cur.execute("""
            UPDATE governance_functions
            SET last_run_status = ?,
                last_run_at = ?
            WHERE id = 22;
        """, (overall_status, run_now))
        
        cur.execute("""
            INSERT INTO governance_function_runs
            (function_id, run_status, command_run, started_at, completed_at, output_log, error_log)
            VALUES (22, ?, 'python tools/governance/validate_screenshots.py', ?, ?, ?, ?);
        """, (
            overall_status, 
            run_now, 
            run_now,
            f"Visual proof validation sweep completed. Verified {len(screens)} screenshots. Status: {overall_status.upper()}.",
            f"Failed screenshots detected." if any_failed else None
        ))

    # Record E2E visual proof quality KPI result
    cur.execute("DELETE FROM kpi_results WHERE kpi_code = 'visual_proof_validation';")
    cur.execute("""
        INSERT INTO kpi_results
        (kpi_code, kpi_name, kpi_value, kpi_status, proof_json, proof_log_path, measured_at)
        VALUES
        ('visual_proof_validation', 'Cypress Visual Proofs Validation Sweep', ?, ?, ?, ?, CURRENT_TIMESTAMP);
    """, (
        overall_status,
        overall_status,
        json.dumps({
            "total_screenshots_validated": len(screens),
            "passed_count": sum(1 for r in validation_records if r["status"] == "passed"),
            "failed_count": sum(1 for r in validation_records if r["status"] == "failed"),
            "measured_at": run_now
        }),
        "tools/governance/reports/visual_proof_validation.json"
    ))

    conn.commit()
    conn.close()

    print(f"\n==============================================================")
    print(f"Sweep Completed: {overall_status.upper()}")
    print(f"Total: {len(screens)} | Passed: {sum(1 for r in validation_records if r['status'] == 'passed')} | Failed: {sum(1 for r in validation_records if r['status'] == 'failed')}")
    print(f"Report saved to: tools/governance/reports/visual_proof_validation.json")
    print(f"==============================================================")

    if any_failed:
        sys.exit(1)
    else:
        sys.exit(0)

if __name__ == '__main__':
    import sys
    main()
