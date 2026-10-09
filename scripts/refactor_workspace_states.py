"""Migrate exact workspace state templates; preserve custom copy behavior."""
import re
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
FIELDS={'isLoading':'bool','error':'String?','title':'String','logs':'List<String>','hasData':'bool'}
COMMON='''class NAME {
  final bool isLoading;
  final String? error;
  final String title;
  final List<String> logs;
  final bool hasData;
  const NAME({required this.isLoading, this.error, required this.title, required this.logs, required this.hasData,});
  NAME copyWith({bool? isLoading, String? error, String? title, List<String>? logs, bool? hasData,}) {
    return NAME(isLoading: isLoading ?? this.isLoading, error: error ?? this.error, title: title ?? this.title, logs: logs ?? this.logs, hasData: hasData ?? this.hasData,);
  }
}'''
def compact(s):return re.sub(r'\s+','',s)
def states(source):
    for m in re.finditer(r'class (\w+State) \{',source):
        end=source.find('// --- Controller',m.end())
        if end<0:continue
        block=source[m.start():end].rstrip()
        if 'final List<String> logs;' in block and 'final bool hasData;' in block:
            yield m[1],m.start(),m.start()+len(block),block

def convert_block(name,block):
    common=compact(block.replace(name,'NAME'))==compact(COMMON)
    if not common:
        assert 'bool clearError = false' in block or 'final bool isShiftActive;' in block,'Unknown custom workspace state'
    s=block.replace('class '+name+' {','class '+name+' extends BaseWorkspaceState<'+name+'> {',1)
    for field,typ in FIELDS.items():
        s=re.sub(r'  final '+re.escape(typ)+r' '+field+r';\n','',s,count=1)
        s=s.replace('this.'+field, 'super.'+field,1)
    if common:
        start=s.index('  '+name+' copyWith(')
        s=s[:start]+'}'
    else:
        s=s.replace('  '+name+' copyWith(', '  @override\n  '+name+' copyWith(',1)
    factory=name if common else 'copyWith'
    rebuild='''
  @override
  NAME rebuild({required bool isLoading, required String? error,
    required String title, required List<String> logs, required bool hasData}) =>
      FACTORY(isLoading: isLoading, error: error, title: title, logs: logs, hasData: hasData);
'''.replace('NAME',name).replace('FACTORY',factory)
    return s[:-1]+rebuild+'}',common

def convert(source):
    matches=list(states(source));details=[]
    for name,start,end,block in reversed(matches):
        new,common=convert_block(name,block)
        source=source[:start]+new+source[end:]
        details.append({'class':name,'customCopyWith':not common})
    if matches:
        source="import 'package:primecare_models/primecare_models.dart';\n"+source
    return source,list(reversed(details))
