#!/usr/bin/env python3
"""Batch the legacy generated template's known palette into inherited theme roles.

Only buildScreen bodies with an existing context.theme binding qualify. Unknown
colors/contexts, const declarations, aliases and non-template sources stay unchanged.
Dry run by default; --offset/--limit select deterministic commit-sized parts.
"""
import argparse
import importlib.util
import json
import re
from pathlib import Path

spec = importlib.util.spec_from_file_location('boundary', Path(__file__).with_name('check-shared-ui-boundary.py'))
boundary = importlib.util.module_from_spec(spec)
spec.loader.exec_module(boundary)
COLOR = re.compile(r'\b(?:Color\s*\(\s*0xFF([0-9A-Fa-f]{6})\s*\)|Colors\s*\.\s*(white|black))')
CONST_CALL = re.compile(r'\bconst\s+(?:\w+\s*\.\s*)?\w+(?:\s*<[^;{}()]*>)?(?:\s*\.\s*\w+)?\s*\(|\bconst\s*[\[{]')
# Roles come from the existing generated template's use, never a nearest-color match.
RULES = {
 ('Scaffold', 'backgroundColor', 'F0F9FF'): 'background',
 ('AppBar', 'backgroundColor', 'white'): 'surface',
 ('BoxDecoration', 'color', 'white'): 'surface',
 ('Border.all', 'color', 'E2E8F0'): 'outline',
}
for constructor in ('TextStyle',):
 for color in ('0F172A', '334155', '0C4A6E'):
  RULES[(constructor, 'color', color)] = 'onSurface'
 for color in ('475569', '64748B'):
  RULES[(constructor, 'color', color)] = 'onSurfaceVariant'
for constructor in ('BoxDecoration', 'Border.all', 'TextStyle', 'Icon', 'ElevatedButton.styleFrom'):
 RULES[(constructor, 'color' if constructor != 'ElevatedButton.styleFrom' else 'backgroundColor', '0284C7')] = 'primary'
for constructor in ('BoxDecoration', 'TextStyle'):
 RULES[(constructor, 'color', '10B981')] = 'success'


def frames(code):
 stack, result = [], []
 pairs = {')': '(', ']': '[', '}': '{'}
 for pos, char in enumerate(code):
  if char in '([{':
   name = re.search(r'(\w+(?:\s*\.\s*\w+)?)\s*$', code[max(0,pos-200):pos]) if char == '(' else None
   frame = [pos, None, re.sub(r'\s+', '', name[1]) if name else '', stack[-1] if stack else None]
   stack.append(frame)
   result.append(frame)
  elif char in ')]}':
   if not stack or code[stack[-1][0]] != pairs[char]:
    return []
   stack.pop()[1] = pos
 return result if not stack else []


def migrate(source):
 if '// Generated directly from SQLite Database' not in source:
  return source, 0
 code = boundary.executable_code(source)
 method = re.search(r'\bWidget\s+buildScreen\s*\(BuildContext\s+context,\s*WidgetRef\s+ref\)\s*{', code)
 if not method:
  return source, 0
 all_frames = frames(code)
 body = next((f for f in all_frames if f[0] == method.end()-1), None)
 if not body:
  return source, 0
 body_code = code[body[0]+1:body[1]]
 if not re.match(r'\s*final\s+theme\s*=\s*context\s*\.\s*theme\s*;', body_code):
  return source, 0
 if len(re.findall(r'\btheme\s*=', body_code)) != 1:
  return source, 0
 if re.search(r'\bconst\s+\w+(?:\s+\w+)?\s*=|\b(?:var|final)\s+(?:Color|Colors)\b|\b(?:class|typedef)\s+(?:Color|Colors)\b', code):
  return source, 0
 consts = [(m.start(), m.start()+len('const'), m.end()-1) for m in CONST_CALL.finditer(code)]
 by_open = {f[0]:f for f in all_frames}
 edits, removed, count = [], set(), 0
 for match in COLOR.finditer(code, body[0]+1, body[1]):
  parents = [f for f in all_frames if f[0] < match.start() < f[1]]
  parent = max(parents, key=lambda f:f[0]) if parents else None
  if not parent:
   continue
  # Color itself is not included: match starts before its opening paren.
  prefix = code[parent[0]+1:match.start()]
  named = re.search(r'\b(\w+)\s*:\s*(?:const\s*)?$', prefix)
  value = match[1].upper() if match[1] else match[2]
  role = RULES.get((parent[2], named[1], value)) if named else None
  if not role and parent[2] == 'TextStyle' and named and named[1] == 'color' and value == 'white' and any(f[2] == 'ElevatedButton' and re.search(r'backgroundColor\s*:\s*(?:const\s+)?Color\s*\(\s*0xFF0284C7\s*\)', code[f[0]:f[1]]) for f in parents):
   role = 'onPrimary'
  if not role:
   continue
  edits.append((match.start(), match.end(), 'theme.colors.'+role))
  count += 1
  for start, end, opening in consts:
   frame = by_open.get(opening)
   if frame and body[0] < start <= match.start() and frame[1] >= match.end()-1:
    removed.add((start,end,''))
 for start,end,replacement in sorted(edits+list(removed), reverse=True):
  source = source[:start]+replacement+source[end:]
 return source, count


def main():
 parser = argparse.ArgumentParser(description=__doc__)
 parser.add_argument('--root', type=Path, default=Path(__file__).resolve().parents[1])
 parser.add_argument('--offset', type=int, default=0)
 parser.add_argument('--limit', type=int, default=100)
 parser.add_argument('--apply', action='store_true')
 args = parser.parse_args()
 if args.offset < 0 or args.limit < 1:
  parser.error('offset must be nonnegative and limit positive')
 root = args.root.resolve()
 base = root/'packages/primecare_ui/lib/src/features/generated_screens'
 files, calls = [], 0
 for path in sorted(base.glob('*.dart'))[args.offset:args.offset+args.limit]:
  if path.is_symlink() or not path.resolve().is_relative_to(root):
   continue
  updated,count = migrate(path.read_text(encoding='utf-8'))
  if count:
   if args.apply:
    path.write_text(updated, encoding='utf-8')
   calls += count
   files.append(path.relative_to(root).as_posix())
 print(json.dumps({'applied':args.apply,'offset':args.offset,'limit':args.limit,'colors':calls,'files':files},indent=2))


if __name__ == '__main__':
 main()
