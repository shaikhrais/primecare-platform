"""Static reference evidence, not proof that a table is unused or operational."""
import json,pathlib,re,subprocess,sys

def build_index(manifest,root):
 names={t['name'].lower():t['name'] for t in manifest['tables']};physical={'govt_'+n:n for n in names};lookup={**{n:n for n in names},**physical}
 result={n:{'mentions':0,'files':0,'references':[],'activeReaderReferences':[],'sqlReadFiles':0,'sqlWriteFiles':0} for n in names.values()}
 active={'scripts/db_table_counts.py','scripts/inspect_architecture_counts.py','scripts/inspect_tables_content.py','scripts/export-typescript-websites.py','scripts/export_governed_openapi.py','scripts/check-api-catalog-identity.py','scripts/audit-api-grant-integrity.py'}
 paths=subprocess.check_output(['git','ls-files','-z'],cwd=root).decode().split('\0');skipped=[];scanned=0
 for relative in paths:
  p=root/relative
  if not relative or not p.is_file() or p.suffix not in {'.py','.ts','.mjs','.js','.dart','.sql','.json','.yml','.yaml','.md'}:continue
  if relative.startswith(('tools/governance-production/audit-','tools/governance-production/test-audit','docs/audits/governance-tables/')):continue
  if p.stat().st_size>2*1024*1024:skipped.append(relative);continue
  try:text=p.read_text(encoding='utf8')
  except UnicodeError:skipped.append(relative);continue
  scanned+=1
  kind='test' if p.name.startswith('test') or '/test/' in relative or '/tests/' in relative else 'documentation' if p.suffix=='.md' else 'generated-data' if p.suffix=='.json' else 'legacy-source' if relative.startswith(('testingFramework1.0/','generated_screen_backup_before_template_reset/')) else 'source'
  found={}
  for line_number,line in enumerate(text.splitlines(),1):
   for token in re.findall(r'\b[a-zA-Z_][a-zA-Z_0-9]*\b',line):
    name=lookup.get(token.lower())
    if name:found.setdefault(names[name],[]).append(line_number)
  for name,lines in found.items():
   record=result[name];record['mentions']+=len(lines);record['files']+=1
   entry={'path':relative,'line':min(lines),'kind':kind}
   if len(record['references'])<8:record['references'].append(entry)
   if relative in active:record['activeReaderReferences'].append(entry)
   # Potential SQL references can target another database or a retired caller.
   pattern=re.escape(name)
   if re.search(r'\b(?:FROM|JOIN)\s+["`\[]?(?:govt_)?'+pattern+r'\b',text,re.I):record['sqlReadFiles']+=1
   if re.search(r'\b(?:INTO|UPDATE)\s+["`\[]?(?:govt_)?'+pattern+r'\b',text,re.I):record['sqlWriteFiles']+=1
 return {'tables':result,'scannedFiles':scanned,'skippedFiles':skipped,'limits':'Static mentions and potential SQL accesses only. Dynamic callers, generated names, alternate schemas and untracked external consumers require review. Absence is not proof of obsolescence.'}
if __name__=='__main__':print(json.dumps(build_index(json.load(sys.stdin),pathlib.Path(sys.argv[1]).resolve())))
