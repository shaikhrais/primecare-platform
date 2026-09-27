import os
import json
import sys

def main():
    if len(sys.argv) < 2:
        print("Usage: python generate_asset_manifest.py <assets_dir>")
        sys.exit(1)
        
    assets_dir = sys.argv[1]
    if not os.path.exists(assets_dir):
        print(f"Error: Directory {assets_dir} does not exist.")
        sys.exit(1)
        
    manifest = {}
    
    # Walk through the assets directory recursively
    for root, _, files in os.walk(assets_dir):
        for file in files:
            # Skip manifest files themselves
            if file in ['AssetManifest.json', 'AssetManifest.bin', 'AssetManifest.bin.json', 'FontManifest.json']:
                continue
                
            full_path = os.path.join(root, file)
            # Get relative path from assets_dir
            rel_path = os.path.relpath(full_path, assets_dir)
            # Normalize path separators to forward slashes for web compatibility
            web_path = rel_path.replace('\\', '/')
            
            # Add to manifest
            manifest[web_path] = [web_path]
            
    manifest_path = os.path.join(assets_dir, 'AssetManifest.json')
    with open(manifest_path, 'w', encoding='utf-8') as f:
        json.dump(manifest, f, indent=2)
        
    print(f"Successfully generated AssetManifest.json with {len(manifest)} assets at {manifest_path}")

if __name__ == '__main__':
    main()
