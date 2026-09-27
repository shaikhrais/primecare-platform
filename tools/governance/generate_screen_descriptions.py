import os
import re
import sys
import json
import time
import sqlite3
import urllib.request
import urllib.error
import argparse

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")
OUTPUT_DIR = os.path.join(PROJECT_ROOT, "tools", "governance", "screen_descriptions")

# Make sure output directory exists
os.makedirs(OUTPUT_DIR, exist_ok=True)

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

def fetch_openai_description(api_key, screen_name, screen_code, route_path, role_name, code_content):
    """Sends screen details to ChatGPT to generate a professional functional description with retry backoff."""
    url = "https://api.openai.com/v1/chat/completions"
    headers = {
        "Authorization": f"Bearer {api_key}",
        "Content-Type": "application/json"
    }
    
    # Clean the source code to avoid excessive token sizes
    cleaned_code = code_content
    # Strip comments if it's exceptionally long to save tokens
    if len(cleaned_code) > 15000:
        cleaned_code = re.sub(r'//.*', '', cleaned_code)
        cleaned_code = re.sub(r'/\*.*?\*/', '', cleaned_code, flags=re.DOTALL)
        cleaned_code = cleaned_code[:12000]

    # Exactly matching user template prompt format
    prompt = f"""
    List of work {role_name} must to and what are the red flag of operation how effectively we work and what we need on dashboard od {role_name}. and ask yo get results in plan text no format to save tokens
    
    Screen Name: {screen_name}
    Screen Code: {screen_code}
    Route Path: {route_path}
    
    Here is the screen source code:
    {cleaned_code}
    """
    
    data = {
        "model": "gpt-4o-mini",
        "messages": [
            {
                "role": "system", 
                "content": "You are a professional software architect. Output only plain text with no formatting or markdown syntax whatsoever."
            },
            {
                "role": "user", 
                "content": prompt
            }
        ],
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
                return res_json["choices"][0]["message"]["content"].strip()
        except urllib.error.HTTPError as e:
            if e.code == 429:
                print(f"  [Rate Limit Exceeded (429)] Retrying in {delay} seconds (Attempt {attempt+1}/{retries})...")
                time.sleep(delay)
                delay *= 2
                continue
            else:
                print(f"  [OpenAI API Error] HTTP Status: {e.code}")
                try:
                    err_body = e.read().decode("utf-8")
                    print(f"  Details: {err_body}")
                except Exception:
                    pass
                return None
        except Exception as e:
            print(f"  [Error] Connection failed: {e}")
            return None
    return None

def generate_local_fallback_description(screen_name, screen_code, route_path, code_content):
    """Fallback generator that extracts key components using regex and outputs structured requirements."""
    widgets = re.findall(r"class\s+([a-zA-Z0-9_]+)\s+extends\s+", code_content)
    providers = re.findall(r"(?:ref\.(?:watch|read|listen)\()?([a-zA-Z0-9_]+Provider)\b", code_content)
    data_cy_keys = re.findall(r"['\"](data-cy-[a-zA-Z0-9_-]+)['\"]", code_content)
    if not data_cy_keys:
        data_cy_keys = re.findall(r"Key\(['\"]([a-zA-Z0-9_-]+)['\"]\)", code_content)
    
    layout_features = []
    if "ResponsiveSplitDashboard" in code_content:
        layout_features.append("ResponsiveSplitDashboard (tabbed sidebar split layout)")
    if "AuraHUD" in code_content:
        layout_features.append("AuraHUD (telemetry overlay indicator)")
    if "TabBar" in code_content or "TabController" in code_content:
        layout_features.append("Tabbed Navigation Workspace")
    if "Slider" in code_content:
        layout_features.append("Dynamic Adjuster Slider")
    if "ListView" in code_content:
        layout_features.append("Scrollable List View")
    
    widgets = sorted(list(set(widgets)))
    providers = sorted(list(set(providers)))
    data_cy_keys = sorted(list(set(data_cy_keys)))
    
    description = f"""# {screen_name} - Functional Requirements & Specifications
*(Generated via Local Parsing Simulation)*

## 1. Overview & Purpose
This screen represents the `{screen_name}` workspace, accessible via the route `{route_path}`. It serves as a specialized role-based dashboard/view within the PrimeCare platform ecosystem.

## 2. Core UI Layout & Key Elements
- **Logical Route**: `{route_path}`
- **Registered Code Class**: `{widgets[0] if widgets else (screen_code.replace('_', ' ').title().replace(' ', '') + 'Screen')}`
- **Primary Layout Features**:
{chr(10).join([f"  - {f}" for f in layout_features]) if layout_features else "  - Standard scaffold-based layout."}

## 3. Data Integration & State Flow
- **Active State Providers**:
{chr(10).join([f"  - `{p}`" for p in providers]) if providers else "  - None detected or standard controller-state bound."}
- **Telemetry Guardrails**: Aura HUD is registered to monitor dynamic state updates and latency.

## 4. User Interactions & Dynamic Behaviors
- **Available Interactive Elements (data-cy)**:
{chr(10).join([f"  - `{k}`" for k in data_cy_keys]) if data_cy_keys else "  - Standard action fields."}
- **Interactive Handlers**: Handles user input updates, button interactions, and navigation routes.
"""
    return description.strip()

def main():
    parser = argparse.ArgumentParser(description="PrimeCare Screen Description Generator Utility")
    parser.add_argument("--screen", help="Process only a single screen code")
    parser.add_argument("--role", help="Process only screens belonging to a specific role code (e.g. psw)")
    parser.add_argument("--limit", type=int, help="Limit the number of screens processed")
    parser.add_argument("--force", action="store_true", help="Force regenerate descriptions even if files exist")
    parser.add_argument("--offline", action="store_true", help="Force running in offline simulation mode")
    args = parser.parse_args()

    print("==============================================================")
    print("PRIMECARE SCREEN REQUIREMENT GENERATOR: GPT & OFFLINE PARSER")
    print("==============================================================")
    
    if not os.path.exists(DB_PATH):
        print(f"Error: Governance database not found at {DB_PATH}")
        return
        
    api_key = load_openai_key() if not args.offline else None
    if api_key:
        print("[Mode] Active OpenAI ChatGPT API integration enabled (gpt-4o-mini).")
    else:
        print("[Mode] Running in OFFLINE SIMULATION mode (Local regex analysis).")
        
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    cur = conn.cursor()
    
    # Formulate selection query with left join to get role details
    query = """
    SELECT s.id, s.screen_code, s.screen_name, s.route_path, s.actual_file_path, s.expected_file_path, r.role_name 
    FROM screens s
    LEFT JOIN roles r ON s.role_id = r.id
    """

    conditions = []
    params = []
    
    if args.screen:
        conditions.append("screen_code = ?")
        params.append(args.screen)
        
    if args.role:
        # Resolve screen IDs associated with role directly from the screens table
        role_screens = cur.execute("""
            SELECT id FROM screens
            WHERE role_id = (SELECT id FROM roles WHERE role_code = ?)
        """, (args.role,)).fetchall()
        screen_ids = [rs["id"] for rs in role_screens]

        if screen_ids:
            placeholders = ",".join("?" for _ in screen_ids)
            conditions.append(f"id IN ({placeholders})")
            params.extend(screen_ids)
        else:
            print(f"No screens found associated with role: {args.role}")
            conn.close()
            return
            
    if conditions:
        query += " WHERE " + " AND ".join(conditions)
        
    screens = cur.execute(query, params).fetchall()
    print(f"Loaded {len(screens)} candidate screens from SQLite.")
    
    processed_count = 0
    success_count = 0
    
    for idx, s in enumerate(screens, 1):
        if args.limit and processed_count >= args.limit:
            print(f"\nReached execution limit of {args.limit} screens.")
            break
            
        screen_id = s["id"]
        screen_code = s["screen_code"]
        screen_name = s["screen_name"]
        route_path = s["route_path"]
        
        txt_filename = f"{screen_code}_description.txt"
        txt_path = os.path.join(OUTPUT_DIR, txt_filename)
        
        # Check if output already exists (Incremental update check)
        if os.path.exists(txt_path) and not args.force:
            # We already have a description on disk
            # Check if database has it too
            db_entry = cur.execute("SELECT component_behavior_text FROM screens WHERE id = ?", (screen_id,)).fetchone()
            if db_entry and db_entry["component_behavior_text"]:
                continue
                
        # Determine source file
        source_path = None
        for path_field in ["actual_file_path", "expected_file_path"]:
            if s[path_field]:
                potential_path = os.path.join(PROJECT_ROOT, s[path_field])
                if os.path.exists(potential_path):
                    source_path = potential_path
                    break
        
        # Fallback path search
        if not source_path:
            fallback_filename = f"{screen_code}_screen.dart"
            screens_root = os.path.join(PROJECT_ROOT, "packages", "primecare_ui", "lib", "src", "screens")
            for root, _, files in os.walk(screens_root):
                if fallback_filename in files:
                    source_path = os.path.join(root, fallback_filename)
                    break
                    
        if not source_path:
            # Skip missing screen source files
            continue
            
        print(f"[{idx}/{len(screens)}] Generating for '{screen_code}'...")
        processed_count += 1
        
        try:
            with open(source_path, "r", encoding="utf-8", errors="ignore") as f:
                code_content = f.read()
        except Exception as e:
            print(f"  Failed to read file {source_path}: {e}")
            continue
            
        # Get description
        description = None
        is_gpt_result = False
        role_name = s["role_name"] or "User"
        if api_key:
            description = fetch_openai_description(
                api_key, 
                screen_name, 
                screen_code, 
                route_path, 
                role_name,
                code_content
            )

            if description:
                is_gpt_result = True
                # Delay to prevent hitting OpenAI RPM limits
                time.sleep(0.5)
            
        if not description:
            # Fallback to local parsing
            description = generate_local_fallback_description(
                screen_name, 
                screen_code, 
                route_path, 
                code_content
            )
            
        # Write to txt file
        try:
            with open(txt_path, "w", encoding="utf-8") as f:
                f.write(description)
        except Exception as e:
            print(f"  Failed to write description file: {e}")
            continue
            
        # Update SQLite database
        try:
            status_text = "generated_gpt" if is_gpt_result else "generated_local"
            cur.execute("""
                UPDATE screens
                SET component_behavior_text = ?,
                    user_remarks = ?,
                    user_remark_status = ?
                WHERE id = ?;
            """, (description, f"Functional description generated on 2026-06-04.", status_text, screen_id))
            success_count += 1
            print(f"  Saved description successfully ({status_text}).")
        except Exception as e:
            print(f"  Database update failed for screen '{screen_code}': {e}")
            
    conn.commit()
    conn.close()
    
    print("\n==============================================================")
    print(f"[SUCCESS] Completed requirement description extraction!")
    print(f"Total candidate screens: {len(screens)}")
    print(f"Screens processed in this run: {processed_count}")
    print(f"Requirements successfully generated & saved: {success_count}")
    print("==============================================================")

if __name__ == "__main__":
    main()
