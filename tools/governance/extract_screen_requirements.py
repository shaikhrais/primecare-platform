import os
import re
import json
import time
import sqlite3
import urllib.request
import urllib.error
import argparse

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")
DESCRIPTIONS_DIR = os.path.join(PROJECT_ROOT, "tools", "governance", "screen_descriptions")

def load_openai_key():
    """Tries to find OPENAI_API_KEY in env or in root .env file."""
    api_key = os.environ.get("OPENAI_API_KEY")
    if api_key:
        return api_key.strip()
    
    # Try reading root .env file
    env_path = os.path.join(PROJECT_ROOT, ".env")
    if os.path.exists(env_path):
        try:
            with open(env_path, "r", encoding="utf-8") as f:
                for line in f:
                    line = line.strip()
                    if line.startswith("OPENAI_API_KEY="):
                        val = line.split("=", 1)[1]
                        # Remove quotes if present
                        if val.startswith('"') and val.endswith('"'):
                            val = val[1:-1]
                        elif val.startswith("'") and val.endswith("'"):
                            val = val[1:-1]
                        return val.strip()
        except Exception:
            pass
    return None

def fetch_requirements_json(api_key, screen_code, description_content):
    """Sends the requirements description to ChatGPT to extract structured requirements in JSON format."""
    url = "https://api.openai.com/v1/chat/completions"
    headers = {
        "Authorization": f"Bearer {api_key}",
        "Content-Type": "application/json"
    }
    
    prompt = f"""
    Analyze the following screen requirements description and extract the structured technical requirements in JSON format.
    
    Screen Code: {screen_code}
    Description:
    {description_content}
    
    You must output a single, valid JSON object containing exactly the following keys:
    1. "required_components": [List of widget class names or visual components required on this screen, e.g. ["GovMetricCard", "GovTelemetryChart"]]
    2. "required_buttons": [List of button labels required on this screen, e.g. ["Check In", "Emergency Alert"]]
    3. "required_functions": [List of action/handler function names required, e.g. ["toggleCheckIn", "triggerEmergencyAlert"]]
    4. "required_apis": [List of API endpoint paths required, e.g. ["/v1/clinical/shift/checkin"]]
    5. "data_cy_required": [List of data-cy semantic keys required, e.g. ["pswdashboard-btn-checkin", "pswdashboard-btn-emergency"]]
    6. "required_responsive": [List of platforms required, e.g. ["mobile", "tablet", "desktop"]]
    7. "requirements_summary": [A concise 1-2 sentence summary of what this screen requires]
    
    Do not add any explanation or markdown formatting outside the JSON object. Output raw JSON only.
    """
    
    data = {
        "model": "gpt-4o-mini",
        "messages": [
            {
                "role": "system", 
                "content": "You are a professional software architect. Output only raw, valid JSON."
            },
            {
                "role": "user", 
                "content": prompt
            }
        ],
        "response_format": {"type": "json_object"},
        "temperature": 0.2
    }
    
    retries = 3
    delay = 2
    
    for attempt in range(retries):
        req = urllib.request.Request(
            url, 
            data=json.dumps(data).encode("utf-8"), 
            headers=headers, 
            method="POST"
        )
        try:
            with urllib.request.urlopen(req, timeout=35) as response:
                res_json = json.loads(response.read().decode("utf-8"))
                content = res_json["choices"][0]["message"]["content"].strip()
                return json.loads(content)
        except urllib.error.HTTPError as e:
            if e.code == 429:
                print(f"  [Rate Limit Exceeded (429)] Retrying in {delay} seconds (Attempt {attempt+1}/{retries})...")
                time.sleep(delay)
                delay *= 2
                continue
            else:
                print(f"  [OpenAI API Error] HTTP Status: {e.code}")
                return None
        except Exception as e:
            print(f"  [Error] Connection failed: {e}")
            return None
    return None

def generate_local_fallback_requirements(description_content):
    """Fallback parser that parses sections using regex to output standard JSON requirements."""
    # Find components
    components = re.findall(r"-\s+\*?\*?([a-zA-Z0-9_]{3,})\*?\*?", description_content)
    # Find data-cy keys
    data_cy = re.findall(r"['\"`](data-cy-[a-zA-Z0-9_-]+)['\"`]", description_content)
    if not data_cy:
        data_cy = re.findall(r"['\"`]([a-zA-Z0-9_-]+-(?:btn|screen|title|content|loading))['\"`]", description_content)
        
    components = sorted(list(set(components)))
    data_cy = sorted(list(set(data_cy)))
    
    return {
        "required_components": components if components else ["GovMetricCard"],
        "required_buttons": ["Submit", "Refresh"],
        "required_functions": ["onRefresh", "onSubmit"],
        "required_apis": [],
        "data_cy_required": data_cy if data_cy else ["screen-root", "page-title"],
        "required_responsive": ["mobile", "tablet", "desktop"],
        "requirements_summary": "Requirements extracted via local text parsing fallback."
    }

def main():
    parser = argparse.ArgumentParser(description="PrimeCare Screen Requirement Extractor Utility")
    parser.add_argument("--limit", type=int, help="Limit the number of screens processed")
    parser.add_argument("--offline", action="store_true", help="Force running in offline simulation mode")
    args = parser.parse_args()

    print("==============================================================")
    print("PRIMECARE SCREEN REQUIREMENT EXTRACTOR: GPT & OFFLINE PARSER")
    print("==============================================================")
    
    if not os.path.exists(DB_PATH):
        print(f"Error: Governance database not found at {DB_PATH}")
        return
        
    api_key = load_openai_key() if not args.offline else None
    if api_key:
        print("[Mode] Active OpenAI ChatGPT API integration enabled (gpt-4o-mini).")
    else:
        print("[Mode] Running in OFFLINE SIMULATION mode (Local regex analysis).")
        
    if not os.path.exists(DESCRIPTIONS_DIR):
        print(f"Error: Screen descriptions directory not found at {DESCRIPTIONS_DIR}")
        return

    # Find all unprocessed files (not starting with '-')
    files = []
    for f in os.listdir(DESCRIPTIONS_DIR):
        if f.endswith(".txt") and not f.startswith("-"):
            files.append(f)
            
    print(f"Found {len(files)} unprocessed screen requirement description files.")
    
    if not files:
        print("No unprocessed screens found. System is fully aligned!")
        return

    conn = sqlite3.connect(DB_PATH)
    cur = conn.cursor()
    
    processed_count = 0
    success_count = 0
    
    for idx, filename in enumerate(files, 1):
        if args.limit and processed_count >= args.limit:
            print(f"\nReached execution limit of {args.limit} screens.")
            break
            
        screen_code = filename[:-4]  # strip '.txt'
        file_path = os.path.join(DESCRIPTIONS_DIR, filename)
        
        # Verify screen exists in SQLite
        db_screen = cur.execute("SELECT id FROM screens WHERE screen_code = ?", (screen_code,)).fetchone()
        if not db_screen:
            # Skip if screen not registered
            continue
            
        screen_id = db_screen[0]
        print(f"[{idx}/{len(files)}] Extracting requirements for '{screen_code}'...")
        processed_count += 1
        
        try:
            with open(file_path, "r", encoding="utf-8", errors="ignore") as f:
                description_content = f.read()
        except Exception as e:
            print(f"  Failed to read file {file_path}: {e}")
            continue
            
        # Get requirements
        reqs = None
        is_gpt = False
        if api_key:
            reqs = fetch_requirements_json(api_key, screen_code, description_content)
            if reqs:
                is_gpt = True
                time.sleep(0.5)  # Rate limit safety delay
                
        if not reqs:
            reqs = generate_local_fallback_requirements(description_content)
            
        # Update SQLite requirements columns
        try:
            summary = reqs.get("requirements_summary", "Requirements extracted successfully.")
            if isinstance(summary, list):
                summary = " ".join(str(s) for s in summary)
            elif not isinstance(summary, str):
                summary = str(summary)

            cur.execute("""
                UPDATE screens
                SET required_components_json = ?,
                    required_buttons_json = ?,
                    required_functions_json = ?,
                    required_apis_json = ?,
                    data_cy_required_json = ?,
                    required_responsive_json = ?,
                    code_gap_summary = ?,
                    required_component_count = ?,
                    component_governance_status = 'aligned'
                WHERE id = ?;
            """, (
                json.dumps(reqs.get("required_components", [])),
                json.dumps(reqs.get("required_buttons", [])),
                json.dumps(reqs.get("required_functions", [])),
                json.dumps(reqs.get("required_apis", [])),
                json.dumps(reqs.get("data_cy_required", [])),
                json.dumps(reqs.get("required_responsive", [])),
                summary,
                len(reqs.get("required_components", [])),
                screen_id
            ))
            
            # Commit immediately to release database locks and persist progress
            conn.commit()
            
            # Rename file to mark as processed by adding '-' prefix
            new_filename = f"-{filename}"
            new_file_path = os.path.join(DESCRIPTIONS_DIR, new_filename)
            os.replace(file_path, new_file_path)
            
            status_tag = "gpt" if is_gpt else "local"
            success_count += 1
            print(f"  Requirements updated in DB & renamed to: {new_filename} ({status_tag})")
        except Exception as e:
            print(f"  Failed to process screen '{screen_code}': {e}")
            
    conn.close()
    
    print("\n==============================================================")
    print(f"[SUCCESS] Completed requirements extraction run!")
    print(f"Total candidate files: {len(files)}")
    print(f"Screens processed: {processed_count}")
    print(f"Requirements successfully committed & marked: {success_count}")
    print("==============================================================")

if __name__ == "__main__":
    main()
