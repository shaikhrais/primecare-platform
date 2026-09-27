import os
import time
import subprocess

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
JOURNAL_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db-journal")
EXTRACTOR_SCRIPT = os.path.join(PROJECT_ROOT, "tools", "governance", "extract_screen_requirements.py")

def main():
    print("==============================================================")
    print("PRIMECARE OVERNIGHT ALIGNMENT ORCHESTRATOR")
    print("==============================================================")
    
    # 1. Wait for generate_screen_descriptions.py to finish (checking journal lock)
    print("Monitoring database transaction lock (.db-journal)...")
    while os.path.exists(JOURNAL_PATH):
        # Check every 60 seconds
        time.sleep(60)
        
    print("\nDatabase lock released. Generator task has completed committing!")
    
    # Give it a brief delay to ensure file handles are fully released
    time.sleep(5)
    
    # 2. Execute the extract_screen_requirements.py script
    print("Executing requirements extraction utility...")
    try:
        process = subprocess.Popen(
            ["python", EXTRACTOR_SCRIPT],
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT,
            text=True,
            encoding="utf-8"
        )
        
        # Stream logs in real-time
        for line in process.stdout:
            print(line, end="")
            
        process.wait()
        if process.returncode == 0:
            print("\nRequirements extraction completed successfully!")
        else:
            print(f"\nExtractor script exited with error code: {process.returncode}")
    except Exception as e:
        print(f"\nError running extractor script: {e}")
        
    print("\n==============================================================")
    print("OVERNIGHT ALIGNMENT ORCHESTRATION COMPLETE!")
    print("==============================================================")

if __name__ == "__main__":
    main()
