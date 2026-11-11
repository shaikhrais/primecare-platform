#!/usr/bin/env python3
"""Migrate exact generated primary actions to the themed shared PrimeButton.

Only primary-token backgrounds, radius-eight shapes and white-only text styles
qualify. Shared defaults take ownership of shape and readable foreground color.
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
STYLE = 'ElevatedButton.styleFrom(backgroundColor:theme.colors.primary,shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(8)),)'

def migrate(source):
    code = b.text.boundary.executable_code(source)
    if not any(code[m.start():].startswith('import') for m in b.SHARED.finditer(source)):
        return source, 0
    if not any(code[m.start():].startswith('import') for m in b.text.MATERIAL.finditer(source)):
        return source, 0
    if re.search(r'\bpart\b|\b(?:class|typedef|mixin|enum|extension)\s+(?:ElevatedButton|PrimeButton|PrimeText)\b', code):
        return source, 0
    if re.search(r'\b(?:Widget|dynamic|Object|Function)\s+(?:ElevatedButton|PrimeButton)\s*\(|\b(?:ElevatedButton|PrimeButton)\s*=', code):
        return source, 0
    for m in re.finditer(r'\bElevatedButton\b', code):
        if not re.match(r'\s*(?:\(|\.styleFrom\s*\()', code[m.end():]):
            return source, 0
    edits=[]
    for call in re.finditer(r'(?<![\w.])ElevatedButton\s*\(', code):
        parsed=b.arguments(code,call.end())
        if not parsed or code[:call.start()].rstrip().endswith('.'):
            continue
        parts,end=parsed
        if '/*' in source[call.start():end+1] or '//' in source[call.start():end+1]:
            continue
        named={}
        for start,stop in parts:
            if not code[start:stop].strip(): continue
            m=re.match(r'\s*(key|style|onPressed|child)\s*:',code[start:stop])
            if not m or m[1] in named: break
            named[m[1]]=(start+m.end(),stop)
        else:
            if not {'style','onPressed','child'} <= named.keys(): continue
            if re.sub(r'\s+','',code[slice(*named['style'])]) != STYLE: continue
            start,stop=named['child']
            child=re.match(r'\s*(?:const\s+)?PrimeText\s*\(',code[start:stop])
            if not child: continue
            parsed_child=b.arguments(code,start+child.end())
            if not parsed_child: continue
            cp,ce=parsed_child
            cp=[p for p in cp if source[slice(*p)].strip()]
            if len(cp)!=2 or code[ce+1:stop].strip(): continue
            if re.sub(r'\s+','',code[slice(*cp[1])]) not in ('style:constTextStyle(color:Colors.white)','style:TextStyle(color:Colors.white)'): continue
            label=source[slice(*cp[0])]
            if re.match(r'\s*\w+\s*:',code[slice(*cp[0])]): continue
            args=['label: '+label,'onPressed: '+source[slice(*named['onPressed'])]]
            if 'key' in named: args.insert(0,'key: '+source[slice(*named['key'])])
            edits.append((call.start(),end+1,'PrimeButton('+', '.join(args)+')'))
    for start,stop,replacement in reversed(edits): source=source[:start]+replacement+source[stop:]
    return source,len(edits)

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
