#!/usr/bin/env python3
"""Migrate default indeterminate spinners to the themed shared loading indicator.

Only empty constructors with unrestricted shared UI and Material imports qualify.
Const parents and surrounding layout are preserved.
Other signatures remain errors in the boundary gate. Dry run is the default.
"""
import argparse
import importlib.util
import json
import re
from pathlib import Path
spec = importlib.util.spec_from_file_location('buttons', Path(__file__).with_name('migrate-shared-buttons.py'))
b = importlib.util.module_from_spec(spec)
spec.loader.exec_module(b)

def migrate(source):
    code = b.text.boundary.executable_code(source)
    if not any(code[m.start():].startswith('import') for m in b.SHARED.finditer(source)):
        return source, 0
    if not any(code[m.start():].startswith('import') for m in b.text.MATERIAL.finditer(source)):
        return source, 0
    if re.search(r'\bpart\b|\b(?:class|typedef|mixin|enum|extension)\s+(?:CircularProgressIndicator|PrimeLoadingIndicator)\b', code):
        return source, 0
    if re.search(r'\b(?:Widget|dynamic|Object|Function)\s+(?:CircularProgressIndicator|PrimeLoadingIndicator)\s*\(|\b(?:CircularProgressIndicator|PrimeLoadingIndicator)\s*=', code):
        return source, 0
    for match in re.finditer(r'\bCircularProgressIndicator\b', code):
        if not re.match(r'\s*\(', code[match.end():]):
            return source, 0
    edits = []
    for match in re.finditer(r'(?<![\w.])CircularProgressIndicator\s*\(\s*\)', code):
        if code[:match.start()].rstrip().endswith('.'):
            continue
        if '//' in source[match.start():match.end()] or '/*' in source[match.start():match.end()]:
            continue
        edits.append((match.start(), match.end()))
    for start, end in reversed(edits):
        source = source[:start] + 'PrimeLoadingIndicator()' + source[end:]
    return source, len(edits)

def main():
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('--root',type=Path,default=Path(__file__).resolve().parents[1]);p.add_argument('--apply',action='store_true');a=p.parse_args();root=a.root.resolve();files=[];calls=0
    for path in sorted((root/'apps').glob('*/lib/**/*.dart')):
        if path.is_symlink() or not path.resolve().is_relative_to(root): continue
        updated,count=migrate(path.read_text())
        if count:
            if a.apply:path.write_text(updated)
            calls+=count;files.append(path.relative_to(root).as_posix())
    print(json.dumps({'applied':a.apply,'calls':calls,'files':files},indent=2))
if __name__=='__main__':main()
