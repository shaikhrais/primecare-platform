"""Generate one exact additive callback storage baseline; no live writes."""
import hashlib,json,sys
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2]
SOURCE='packages/database/migrations/20261027_communication_callback_requests.sql'
BUNDLE='packages/database/migrations/20261027_communication_callback_storage.sql'
FILE='tools/governance-production/callback-storage-registration.json'
PREREQUISITES=['20261023_communication_voice_tasks.sql','20261023_communication_voice_confirmations.sql','20261023_communication_voice_otp.sql']
def generated():
 raw=(ROOT/SOURCE).read_text()
 if raw.count('CREATE TABLE communication_callback_requests (')!=1 or raw.count('CREATE INDEX communication_callback_requests_pending')!=1:raise ValueError('Exact callback source required')
 sql='-- Generated additive callback storage baseline. Do not edit.\n'+raw.replace('CREATE TABLE communication_callback_requests (','CREATE TABLE IF NOT EXISTS public.communication_callback_requests (').replace('REFERENCES communication_voice_tasks(id)','REFERENCES public.communication_voice_tasks(id)').replace('CREATE INDEX communication_callback_requests_pending','CREATE INDEX IF NOT EXISTS communication_callback_requests_pending').replace('ON communication_callback_requests(','ON public.communication_callback_requests(')
 def col(name,dtype='text',primary=0,foreign=0,default=None):return dict(column_name=name,data_type=dtype,is_nullable=0,is_primary=primary,is_foreign=foreign,default_value=default,foreign_table_name='communication_voice_tasks' if foreign else None,foreign_column_name='id' if foreign else None)
 columns=[col('intent_id',primary=1,foreign=1),col('tenant_id'),col('user_id'),col('contact_version','bigint'),col('reason'),col('window_starts_at','timestamp with time zone'),col('window_ends_at','timestamp with time zone'),col('status',default="'requested'::text"),col('created_at','timestamp with time zone',default='clock_timestamp()')]
 d=dict(version=1,baseline='communication-callback-storage-v1',sourceApiId=710,taskApiId=16534,taskId='reception.callback.request',migrationPath=BUNDLE,migrationSha256=hashlib.sha256(sql.encode()).hexdigest(),sourcePath=SOURCE,sourceSha256=hashlib.sha256(raw.encode()).hexdigest(),prerequisiteSources={name:hashlib.sha256((ROOT/'packages/database/migrations'/name).read_bytes()).hexdigest() for name in PREREQUISITES},tables={'communication_callback_requests':columns},scope='One empty owner-private table for approved callback requests. No grants, caller records, task execution, public host, provider traffic or activation.')
 return sql,json.dumps(d,indent=2)+'\n'
if __name__=='__main__':
 if sys.argv[1:] not in [[],['--check']]:raise SystemExit('Only --check supported')
 for path,value in zip([BUNDLE,FILE],generated()):
  if sys.argv[1:]:
   if (ROOT/path).read_text()!=value:raise ValueError('Generated callback design differs')
  else:(ROOT/path).write_text(value)
 print('CALLBACK_STORAGE_GENERATED one exact table; no live writes')
