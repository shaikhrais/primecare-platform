# Project scanner utility
import os
def scan_project(root_dir):
    print(f"Scanning files in {root_dir}")
    return [os.path.join(r, f) for r, d, fs in os.walk(root_dir) if 'node_modules' not in r]
