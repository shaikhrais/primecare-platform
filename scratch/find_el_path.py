import os
import glob

# Try common pub cache locations on Windows
pub_cache_dirs = [
    os.path.expanduser("~/.pub-cache"),
    os.path.join(os.environ.get("LOCALAPPDATA", ""), "Pub/Cache"),
]

found = False
for cache_dir in pub_cache_dirs:
    if os.path.exists(cache_dir):
        pattern = os.path.join(cache_dir, "hosted/pub.dev/easy_localization-*/lib/src/localization.dart")
        files = glob.glob(pattern, recursive=True)
        if files:
            print(f"Found localization.dart at: {files[0]}")
            with open(files[0], "r", encoding="utf-8") as f:
                lines = f.readlines()
                # Print class definition and methods
                in_class = False
                for line in lines:
                    if "class Localization" in line:
                        in_class = True
                    if in_class:
                        # Print methods/properties
                        if line.strip().startswith("}"):
                            # End of class or block, but let's just print first 100 lines of class
                            pass
                        print(line, end="")
            found = True
            break

if not found:
    print("Could not find localization.dart in pub cache.")
