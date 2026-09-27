import os
import sys

# Add current folder to path to import reconcile_db
sys.path.append(os.path.dirname(os.path.abspath(__file__)))
import reconcile_db

if __name__ == "__main__":
    reconcile_db.reconcile()
