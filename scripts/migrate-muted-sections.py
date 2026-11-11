#!/usr/bin/env python3
"""Migrate exact generated section secondary copy to existing muted shared text.

Full-file template matching preserves headings, semantics, data and const parents.
Modified layouts/signatures/imports remain unresolved. Dry run by default.
"""
import argparse
import json
import re
from pathlib import Path
TEMPLATE = "import 'package:flutter/material.dart';\n\nclass RnWorkflowTaskDetailsSection extends StatelessWidget {\n  final Map<String, dynamic> data;\n  const RnWorkflowTaskDetailsSection({super.key, required this.data});\n\n  @override\n  Widget build(BuildContext context) {\n    return Semantics(\n      label: 'rn_workflow_task_details_title',\n      container: true,\n      child: Container(\n        padding: const EdgeInsets.all(16.0),\n        child: Column(\n          crossAxisAlignment: CrossAxisAlignment.start,\n          children: const [\n            Text('Task Details Section', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),\n            SizedBox(height: 4),\n            Text('Clinical Care Operations Status.', style: TextStyle(color: Colors.grey)),\n          ],\n        ),\n      ),\n    );\n  }\n}\n"
OLD = "Text('Clinical Care Operations Status.', style: TextStyle(color: Colors.grey))"
NEW = "PrimeStatusText('Clinical Care Operations Status.', tone: PrimeStatusTone.muted)"
IMPORT = "import 'package:primecare_ui/primecare_ui.dart' show PrimeStatusText, PrimeStatusTone;\n"
pattern = re.escape(TEMPLATE)
pattern = pattern.replace('RnWorkflowTaskDetailsSection', r'(?P<owner>[A-Za-z_]\w*)', 1)
pattern = pattern.replace('RnWorkflowTaskDetailsSection', r'(?P=owner)')
LITERAL = r"'(?:\\[^$\r\n]|[^'\\$\r\n])*'"
pattern = pattern.replace(re.escape("'rn_workflow_task_details_title'"), LITERAL)
pattern = pattern.replace(re.escape("'Task Details Section'"), LITERAL)
EXACT = re.compile(pattern)


def migrate(source):
    if not EXACT.fullmatch(source):
        return source, 0
    return IMPORT + source.replace(OLD, NEW), 1


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('--root', type=Path, default=Path(__file__).resolve().parents[1])
    p.add_argument('--offset', type=int, default=0)
    p.add_argument('--limit', type=int, default=100)
    p.add_argument('--apply', action='store_true')
    a = p.parse_args()
    if a.offset < 0 or a.limit < 1:
        p.error('offset must be nonnegative and limit positive')
    root = a.root.resolve()
    base = root/'packages/primecare_ui/lib/src/screens'
    files=[]
    for path in sorted(base.rglob('*.dart'))[a.offset:a.offset+a.limit]:
        if path.is_symlink() or not path.resolve().is_relative_to(base.resolve()) or not path.resolve().is_relative_to(root):
            continue
        result, count = migrate(path.read_text())
        if count:
            if a.apply:
                path.write_text(result)
            files.append(path.relative_to(root).as_posix())
    print(json.dumps({'applied':a.apply,'labels':len(files),'files':files}))


if __name__ == '__main__':
    main()
