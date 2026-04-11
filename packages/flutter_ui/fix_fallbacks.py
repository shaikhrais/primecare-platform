import re
import glob

files = glob.glob('lib/src/screens/**/*.dart', recursive=True)
count = 0

for f in files:
    with open(f, 'r', encoding='utf-8') as file:
        content = file.read()
    
    # We want to match .tr(fallback: '...') and .tr(fallback: "...")
    # It might span multiple lines
    new_content = re.sub(r"\.tr\(\s*fallback:\s*(['\"].*?['\"])\s*\)", '.tr()', content, flags=re.DOTALL)
    
    if new_content != content:
        with open(f, 'w', encoding='utf-8') as file:
            file.write(new_content)
        print(f"Fixed {f}")
        count += 1

print(f"Total files fixed: {count}")
