"""Migrate exact legacy state templates; preserve nonmatching custom models."""
from pathlib import Path
import re

PATTERN = re.compile(r'^class (\w+) \{\s*final bool isLoading;\s*final String\? errorMessage;\s*final Map<String, dynamic> data;\s*const \1\(\{\s*this.isLoading = false,\s*this.errorMessage,\s*this.data = const \{\},\s*\}\);\s*\1 copyWith\(\{\s*bool\? isLoading,\s*String\? errorMessage,\s*Map<String, dynamic>\? data,\s*\}\) \{\s*return \1\(\s*isLoading: isLoading \?\? this.isLoading,\s*errorMessage: errorMessage \?\? this.errorMessage,\s*data: data \?\? this.data,\s*\);\s*\}\s*\}\s*$')

def convert(source):
    match = PATTERN.fullmatch(source)
    if not match: return None
    name = match[1]
    return f"""import 'package:primecare_models/primecare_models.dart';

class {name} extends BaseScreenState<{name}> {{
  const {name}({{
    super.isLoading = false,
    super.errorMessage,
    super.data = const {{}},
  }});

  @override
  {name} rebuild({{
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }}) => {name}(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}}
"""

if __name__ == '__main__':
    import argparse
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--apply', action='store_true')
    args=parser.parse_args()
    root=Path(__file__).resolve().parents[1]
    count=0
    for folder in ['apps', 'packages']:
        for p in sorted((root/folder).rglob('*_model.dart')):
            converted=convert(p.read_text())
            if converted is not None:
                print(p.relative_to(root));count+=1
                if args.apply:p.write_text(converted)
    print(f'{count} exact templates '+('converted' if args.apply else 'eligible'))
