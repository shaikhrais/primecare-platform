"""Aggregate-only table report. Does not read a database or authorize cleanup."""
import json,pathlib,sys,collections

def render(data):
 tables=data['tables'];source=[t for t in tables if t['sourceName']];counts=collections.Counter(t['assessment']['action'] for t in tables)
 n=lambda v:'—' if v is None else f'{v:,}'
 rows=sum(t['rows'] or 0 for t in source)
 lines=['# Production governance table audit','',f"Source commit: `{data['sourceCommit']}`. PostgreSQL snapshot: `{data['snapshot']['snapshot']}`. Audited at: {data['snapshot']['audited_at']}.",'',f"**{len(tables)} actual tables; {rows:,} source rows; {sum(t['rows'] or 0 for t in tables if not t['sourceName']):,} import-manifest rows.**",'', f"Executed table checks complete: {data['complete']}. Explicitly unsupported checks below remain unresolved.",'', 'This is a read-only audit. No records were deleted, changed or approved for deletion. Counts and content fingerprints are from production, not the removed SQLite file.','', '## How to interpret the findings','', '- Exact duplicates compare every source column and exclude only the technical import ordinal.', '- Non-key payload repetition omits source primary keys; repeated history, version or matrix records may be intentional. It is not a safe deletion count.', '- Retirement markers are explicit retired/obsolete/deprecated/superseded/deleted/archived values. Inactive is reported separately and is not treated as obsolete.', '- Declared-key checks use source metadata. Unsupported affinity, collation, expression and partial-index semantics remain unresolved.', '- Static mentions are evidence for review, not proof of runtime use or disuse. No-reference tables are not automatically obsolete.', '- All deletions remain blocked pending record identity/replacement review, undeclared JSON/external references, ownership and evidence-retention requirements.','', '## Retention assessment','', '| Assessment | Tables |','|---|---:|']
 lines += [f'| {k} | {v} |' for k,v in sorted(counts.items())]
 lines+=['','Candidate counts overlap and are not deletion totals.','',f"Exact duplicate excess rows: {sum((t.get('exactDuplicates') or {}).get('extraRows',0) for t in source):,}. Non-key payload excess: {sum((t.get('nonKeyPayloadDuplicates') or {}).get('extraRows',0) for t in source):,}. Explicit retirement markers: {sum(t['explicitRetiredRows'] or 0 for t in source):,}. Inactive records: {sum(t['inactiveRows'] or 0 for t in source):,}.",'', '## Largest source tables','', '| Table | Rows | Share of source rows | Storage bytes |','|---|---:|---:|---:|']
 lines += [f"| {t['table']} | {n(t['rows'])} | {(t['rows'] or 0)/max(rows,1):.1%} | {n(t['storageBytes'])} |" for t in sorted(source,key=lambda t:t['rows'] or 0,reverse=True)[:20]]
 if data.get('apiGrantIdentityReview'):lines+=['','## Permission identity findings','', 'Identity mismatches are retained as evidence; this audit does not enable, reassign or remove grants.','', '```json',json.dumps(data['apiGrantIdentityReview'],indent=2),'```']
 if data.get('businessProcesses'):lines+=['','## Business-process denominator','', 'Supporting definitions/guides are not additional business processes. This audit does not verify any business journey.','', '```json',json.dumps(data['businessProcesses'],indent=2),'```']
 lines+=['','## Import inventory drift','', '```json',json.dumps(data['inventoryDrift'],indent=2),'```','', '## Every table','', '| Table | Rows | Import row delta | Exact excess | Non-key payload excess | Retired markers | Inactive | FK orphan checks | Assessment |','|---|---:|---:|---:|---:|---:|---:|---|---|']
 for t in tables:
  fk=f"{sum(f.get('orphanRows') or 0 for f in t['foreignKeys']):,} violations; {sum('notChecked' in f for f in t['foreignKeys'])} unresolved"
  lines.append(f"| {t['table']} | {n(t['rows'])} | {n(None if t['sourceImportRows'] is None or t['rows'] is None else t['rows']-t['sourceImportRows'])} | {n((t.get('exactDuplicates') or {}).get('extraRows'))} | {n((t.get('nonKeyPayloadDuplicates') or {}).get('extraRows'))} | {n(t['explicitRetiredRows'])} | {n(t['inactiveRows'])} | {fk} | {t['assessment']['action']} |")
 lines+=['','## Table-by-table evidence and unresolved decisions','']
 for t in tables:
  lines += [f"### {t['table']}",'',t['schemaInferredPurpose'],'',f"Assessment: **{t['assessment']['action']}**. "+' '.join(t['assessment']['reasons']),f"Tags: {', '.join(t['assessment']['tags']) or 'none detected'}. Content SHA256: `{t['contentSha256']}`.",f"Static references: {t['references']['files']} files / {t['references']['mentions']} mentions; potential SQL reader files {t['references']['sqlReadFiles']}; potential writer files {t['references']['sqlWriteFiles']}."]
  for r in t['references']['activeReaderReferences'] or t['references']['references']:lines.append(f"- `{r['path']}:{r['line']}` ({r['kind']}).")
  keyGaps=[k for k in t['uniqueKeys'] if k.get('extraRows',0)>0 or k.get('notChecked')]
  fkGaps=[f for f in t['foreignKeys'] if f.get('orphanRows',0) or f.get('notChecked')]
  if keyGaps:lines+=['','Declared-key findings: `'+json.dumps(keyGaps,separators=(',',':'))+'`.']
  if fkGaps:lines+=['','Declared-reference findings: `'+json.dumps(fkGaps,separators=(',',':'))+'`.']
  if t['retiredIncomingReferences']:lines+=['','References to explicitly retired records: `'+json.dumps(t['retiredIncomingReferences'],separators=(',',':'))+'`.']
  if t['unexpectedNullCodecRows']:lines+=['',f"Unexpected import null-codec rows: {n(t['unexpectedNullCodecRows'])}."]
  if t['checkErrors']:lines+=['','Unfinished checks: `'+json.dumps(t['checkErrors'],separators=(',',':'))+'`.']
  if t.get('datePrefixes'):lines+=['','Observed date prefixes (not retention eligibility): `'+json.dumps(t['datePrefixes'],separators=(',',':'))+'`.']
  lines+=['','Cleanup decision: retain pending identity/replacement review, undeclared-reference analysis, owner/retention requirements and evidence holds.','']
 lines+=['## Scope and validity','']+['- '+s for s in data['limitations']]
 lines+=['',f"Source scan: {data['sourceIndexSummary']['scannedFiles']} text files; {len(data['sourceIndexSummary']['skippedFiles'])} oversized/unreadable files skipped. Full details are in the JSON report.",'']
 return '\n'.join(lines)
if __name__=='__main__':
 data=json.loads(pathlib.Path(sys.argv[1]).read_text());pathlib.Path(sys.argv[2]).write_text(render(data))
