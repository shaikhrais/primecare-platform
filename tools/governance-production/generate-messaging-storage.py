"""Deterministic design/bundle generation from reviewed native PostgreSQL DDL."""
import hashlib,json,sys
from pathlib import Path
import sqlglot
from sqlglot import exp
ROOT=Path(__file__).resolve().parents[2]
FILES=['20261022_business_communications.sql','20261023_business_sms.sql','20261024_communication_sms_inbox.sql','20261024_communication_ai_turns.sql','20261024_communication_sms_links.sql']
BUNDLE='packages/database/migrations/20261025_communication_messaging_storage.sql'
DEFINITION='tools/governance-production/messaging-storage-registration.json'
def generated():
 tables={};relationships=[];identities={};hashes={};parts=[]
 for file in FILES:
  raw=(ROOT/'packages/database/migrations'/file).read_text();hashes[file]=hashlib.sha256(raw.encode()).hexdigest()
  parts.append('-- Reviewed source: '+file+'\n'+raw.replace('CREATE TABLE public.','CREATE TABLE IF NOT EXISTS public.').replace('CREATE UNIQUE INDEX communication_','CREATE UNIQUE INDEX IF NOT EXISTS communication_'))
  for statement in sqlglot.parse(raw,read='postgres'):
   if not isinstance(statement,exp.Create) or statement.kind not in ['TABLE','INDEX']:raise ValueError('Only reviewed CREATE TABLE/INDEX DDL is permitted')
   if statement.kind=='INDEX':continue
   schema=statement.this;name=schema.this.name
   if schema.this.db!='public' or name in tables:raise ValueError('Unique public table required')
   primary=set();foreign={}
   for item in schema.expressions:
    if isinstance(item,exp.PrimaryKey):primary.update(c.name for c in item.expressions)
    if isinstance(item,exp.ForeignKey):
     target=item.args['reference'].this
     for local,remote in zip(item.expressions,target.expressions):foreign[local.name]=(target.this.name,remote.name)
     relationships.append(dict(fromTable=name,columns=[c.name for c in item.expressions],toTable=target.this.name,targetColumns=[c.name for c in target.expressions]))
   columns=[]
   for col in schema.expressions:
    if not isinstance(col,exp.ColumnDef):continue
    constraints=[c.kind for c in col.constraints];pk=col.name in primary or any(isinstance(c,exp.PrimaryKeyColumnConstraint) for c in constraints)
    nullable=not pk and not any(isinstance(c,exp.NotNullColumnConstraint) for c in constraints)
    dtype=col.kind.sql(dialect='postgres').lower();dtype={'timestamptz':'timestamp with time zone'}.get(dtype,dtype)
    default=None
    for constraint in constraints:
     if isinstance(constraint,exp.DefaultColumnConstraint):
      value=constraint.this
      default='now()' if isinstance(value,exp.CurrentTimestamp) else value.sql(dialect='postgres').lower()
     if isinstance(constraint,exp.GeneratedAsIdentityColumnConstraint):
      if constraint.this is not True:raise ValueError('Only ALWAYS identities permitted')
      identities[name+'.'+col.name]='always';nullable=False
    fk=foreign.get(col.name)
    columns.append(dict(column_name=col.name,data_type=dtype,is_nullable=int(nullable),is_primary=int(pk),is_foreign=int(fk is not None),default_value=default,foreign_table_name=fk[0] if fk else None,foreign_column_name=fk[1] if fk else None))
   tables[name]=columns
 old=json.loads((ROOT/'tools/governance-production/communication-storage-registration.json').read_text())
 for name,columns in old['tables'].items():
  if tables.get(name)!=columns:raise ValueError('Existing communication storage metadata must be preserved')
 if len(tables)!=13:raise ValueError('Exact 13-table messaging scope required')
 bundle='-- Generated additive messaging storage bundle. Do not edit; regenerate from reviewed sources.\n\n'+'\n'.join(parts)
 definition=dict(version=1,baseline='communication-messaging-storage-v1',sourceApiId=710,migrationPath=BUNDLE,migrationSha256=hashlib.sha256(bundle.encode()).hexdigest(),sourceHashes=hashes,tables=tables,relationships=relationships,generatedIdentity=identities,scope='Empty owner-private storage only. No user/contact/tenant rows, message content, role grants, routing or messaging activation.')
 return bundle,json.dumps(definition,indent=2)+'\n'
def main():
 if sys.argv[1:] not in [[],['--check']]:raise SystemExit('Only --check is supported')
 bundle,definition=generated()
 for path,value in [(BUNDLE,bundle),(DEFINITION,definition)]:
  if sys.argv[1:]:
   if (ROOT/path).read_text()!=value:raise ValueError('Generated messaging storage differs: '+path)
  else:(ROOT/path).write_text(value)
 print('MESSAGING_STORAGE_GENERATED '+json.dumps(dict(tables=13,check=bool(sys.argv[1:]),businessDataWrites=False)))
if __name__=='__main__':main()
