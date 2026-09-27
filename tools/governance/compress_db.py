import os
import zipfile

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
DB_SOURCE = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")
ZIP_DEST = os.path.join(PROJECT_ROOT, "apps", "primecare_governance", "web", "governance.db.zip")

def main():
    print("🤐 Initiating database compression...")
    print(f"  Source Database: {DB_SOURCE} ({os.path.getsize(DB_SOURCE) / 1024 / 1024:.2f} MB)")
    print(f"  Destination ZIP: {ZIP_DEST}")

    # Remove any existing governance.db file in web folder to avoid pages upload conflicts
    raw_db_in_web = os.path.join(PROJECT_ROOT, "apps", "primecare_governance", "web", "governance.db")
    if os.path.exists(raw_db_in_web):
        os.remove(raw_db_in_web)
        print("  ✓ Removed uncompressed database file from web directory.")

    # Compress governance.db into governance.db.zip
    try:
        with zipfile.ZipFile(ZIP_DEST, 'w', zipfile.ZIP_DEFLATED) as zip_file:
            zip_file.write(DB_SOURCE, arcname="governance.db")
        
        zip_size_mb = os.path.getsize(ZIP_DEST) / 1024 / 1024
        print(f"✨ Successfully compressed SQLite database!")
        print(f"  Final ZIP Size: {zip_size_mb:.2f} MB")
        
        if zip_size_mb > 25:
            print("[WARN] Compressed database still exceeds Cloudflare Pages 25MB limit!")
        else:
            print("  ✓ Zip file size is well under Cloudflare Pages 25MB limit! Ready for deployment!")

    except Exception as e:
        print(f"[ERROR] Failed to compress database: {e}")

if __name__ == '__main__':
    main()
