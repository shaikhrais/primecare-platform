import os
import subprocess

PROJECT_ROOT = r"c:\Users\Admin2\Documents\GitHub\primecare-platform"

def get_untracked_dirs():
    # Run git clean -nd to find directories that would be removed (i.e. untracked ones)
    result = subprocess.run(
        ["git", "clean", "-nd"],
        cwd=PROJECT_ROOT,
        capture_output=True,
        text=True,
        shell=True
    )
    dirs = []
    for line in result.stdout.splitlines():
        if line.startswith("Would remove "):
            path = line[len("Would remove "):].strip()
            # We only want directories, not Kotlin build artifacts
            if path.endswith("/") and not ".kotlin" in path and not ".idea" in path:
                dirs.append(os.path.join(PROJECT_ROOT, path.replace("/", os.sep)))
    return dirs

def main():
    untracked_dirs = get_untracked_dirs()
    print(f"Found {len(untracked_dirs)} untracked directories:")
    
    keep_count = 0
    for d in untracked_dirs:
        # Find the deepest leaf subdirectory to place .gitkeep
        leaf_dirs = []
        for root, subdirs, files in os.walk(d):
            if not subdirs and not files:
                leaf_dirs.append(root)
        
        # If no leaf empty subdirs found (because it has subdirs), just use the base dir
        if not leaf_dirs:
            leaf_dirs = [d]
            
        for ldir in leaf_dirs:
            keep_path = os.path.normpath(os.path.join(ldir, ".gitkeep"))
            print(f"  Creating: {keep_path}")
            with open(keep_path, "w") as f:
                f.write("# Keep empty directory tracked in Git\n")
            keep_count += 1
            
    print(f"Created {keep_count} .gitkeep files.")

if __name__ == "__main__":
    main()
