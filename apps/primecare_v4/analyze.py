import re
from collections import Counter

with open("analyze_output.txt", "r", encoding="utf-16le", errors="ignore") as f:
    lines = f.readlines()

errors = []
for line in lines:
    if " error - " in line:
        parts = line.split(" - ")
        if len(parts) >= 3:
            # typical format:   error - The getter 'textPrimary' isn't defined for the type '_PrimeCareColors' - lib\offices\...
            err_msg = parts[1].strip()
            errors.append(err_msg)

counter = Counter(errors)
with open("summary.txt", "w", encoding="utf-8") as out:
    for err, count in counter.most_common(50):
        out.write(f"{count}: {err}\n")
