import os
import json
import subprocess
import re

def main():
    # 1. Load the intents from the index
    index_path = '.agents/ui_intents.json'
    if not os.path.exists(index_path):
        print(f"❌ Index not found at {index_path}")
        return

    with open(index_path, 'r') as f:
        intents = json.load(f)

    placeholders = [i for i in intents if i['status'] == 'PLACEHOLDER']
    print(f"🚀 Found {len(placeholders)} placeholders to implement.")

    # 2. Iterate and Scaffold
    # We will group items into "Features" to avoid folder explosion if they share a domain
    # For now, we follow the user request "quick" and use the intent ID as the feature name
    
    count = 0
    for intent in placeholders:
        intent_id = intent['id']
        print(f"🏗️  Scaffolding {intent_id}...")
        
        # Run the Dart scaffolding script
        # Note: We use --non-interactive or similar if supported, 
        # but our help check showed it just takes the name as an argument.
        try:
            subprocess.run(['dart', 'scripts/scaffold_primecare_feature.dart', intent_id], 
                           check=True, capture_output=True)
            count += 1
            if count % 10 == 0:
                print(f"✅ Processed {count}/{len(placeholders)}...")
        except subprocess.CalledProcessError as e:
            print(f"⚠️  Failed to scaffold {intent_id}: {e}")

    print(f"✨ Successfully scaffolded {count} features.")

if __name__ == "__main__":
    main()
