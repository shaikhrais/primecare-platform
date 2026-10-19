"""Convert exact empty DTO templates without inventing fields or readiness."""
import re
from pathlib import Path
PATTERN=re.compile(r'class (\w+) \{\s*const \1\(\);\s*factory \1.fromJson\(Map<String, dynamic> json\) \{\s*return const \1\(\);\s*\}\s*Map<String, dynamic> toJson\(\) => \{\};\s*\}')
def convert(source):
    match=PATTERN.search(source)
    if not match:return None
    name=match[1]
    body=f'''class {name} extends BaseEmptyModel {{
  const {name}();

  factory {name}.fromJson(Map<String, dynamic> json) {{
    return const {name}();
  }}
}}'''
    return "import 'package:primecare_models/primecare_models.dart';\n\n"+source[:match.start()]+body+source[match.end():]
if __name__=='__main__':
    import argparse
    parser=argparse.ArgumentParser(description=__doc__);parser.add_argument('--apply',action='store_true');args=parser.parse_args()
    root=Path(__file__).resolve().parents[1];count=0
    for folder in ['apps','packages']:
        for p in sorted((root/folder).rglob('*_model.dart')):
            converted=convert(p.read_text())
            if converted is not None:
                count+=1
                if args.apply:p.write_text(converted)
    print(f'{count} empty templates '+('converted' if args.apply else 'eligible'))
