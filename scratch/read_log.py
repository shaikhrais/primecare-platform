import os
import sys

sys.stdout.reconfigure(encoding='utf-8')

log_path = r"C:\Users\Admin2\.gemini\antigravity-ide\brain\26b1218b-e518-4477-8a4e-2789a840acc1\.system_generated\tasks\task-10335.log"
if os.path.exists(log_path):
    with open(log_path, 'r', encoding='utf-8', errors='ignore') as f:
        content = f.read()
    
    lines = content.splitlines()
    error_blocks = []
    current_block = []
    capture = False
    
    for line in lines:
        if "Processing: " in line:
            if current_block:
                error_blocks.append("\n".join(current_block))
                current_block = []
            capture = True
            current_block.append(line)
        elif capture:
            current_block.append(line)
            
    if current_block:
        error_blocks.append("\n".join(current_block))
        
    for block in error_blocks:
        if "primecare_clinic" in block:
            block_lines = block.splitlines()
            print("="*60)
            print(f"App: {block_lines[0]}")
            print("="*60)
            error_details = []
            for line in block_lines:
                if "error" in line.lower() or "failure" in line.lower() or "failed" in line.lower() or "exception" in line.lower() or ".dart" in line:
                    error_details.append(line)
            for err in error_details[:50]:
                print(err.encode('ascii', errors='ignore').decode('ascii'))
            if not error_details:
                print("No specific error lines found. Last 40 lines of block:")
                for line in block_lines[-40:]:
                    print(line.encode('ascii', errors='ignore').decode('ascii'))
else:
    print(f"Log path does not exist: {log_path}")
