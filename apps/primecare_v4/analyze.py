import re
from collections import Counter

with open("analyze_output.txt", "r", encoding="utf-8", errors="ignore") as f:
    lines = f.readlines()

errors = []
for line in lines:
    if " error - " in line:
        parts = line.split(" - ")
        if len(parts) >= 2:
            errors.append(parts[1].strip())

counter = Counter(errors)
for err, count in counter.most_common(20):
    print(f"{count}: {err}")
