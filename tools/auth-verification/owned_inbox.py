"""Read only newly received mail in the configured owned auth QA inbox."""
import os,json,urllib.request,urllib.error,urllib.parse,hashlib,time,re,base64
from email import policy
from email.parser import BytesParser
RECIPIENT='auth-test@15minutes-email.com'
def candidate_codes(data):
 texts=[data.decode('utf8','replace')]
 try:
  value=json.loads(data)
  if isinstance(value,dict) and isinstance(value.get('rawBase64'),str):texts.append(base64.b64decode(value['rawBase64'],validate=True).decode('utf8','replace'))
 except (ValueError,TypeError):pass
 for text in list(texts):
  try:
   message=BytesParser(policy=policy.default).parsebytes(text.encode())
   for part in message.walk():
    payload=part.get_payload(decode=True)
    if isinstance(payload,bytes):texts.append(payload.decode('utf8','replace'))
  except Exception:pass
 return set(re.findall(r'(?<![A-F0-9])[A-F0-9]{12}(?![A-F0-9])',' '.join(texts).upper()))
class OwnedInbox:
 def __init__(self):
  token=os.environ.get('CLOUDFLARE_API_TOKEN');account=os.environ.get('CLOUDFLARE_ACCOUNT_ID')
  if not token or not account:raise RuntimeError('Cloudflare QA inbox credentials required')
  self.token=token;self.base='https://api.cloudflare.com/client/v4/accounts/'+account;self.key=self.digest=None;self.received=False
  settings=self.read_json('/workers/scripts/primecare-email-inbox/settings');bindings=settings.get('bindings',[])
  namespace=next(b['namespace_id'] for b in bindings if b.get('name')=='INBOX' and b.get('type')=='kv_namespace')
  allowed=next(b.get('text','') for b in bindings if b.get('name')=='INBOX_ADDRESSES' and b.get('type')=='plain_text')
  if RECIPIENT not in [x.strip().lower() for x in allowed.split(',')]:raise RuntimeError('Owned synthetic mailbox not configured')
  status,source=self.call('/workers/scripts/primecare-email-inbox/content/v2');source=source.decode('utf8','replace');compact=''.join(source.split())
  if status!=200 or 'inbox/${recipient}/${receivedAt}/${crypto.randomUUID()}' not in source or any(x in compact for x in ['.forward(','.reply(','fetch(']):raise RuntimeError('Receiving Worker source changed; review required')
  self.api='/storage/kv/namespaces/'+namespace;self.prefix='inbox/'+RECIPIENT+'/';self.baseline=self.keys()
 def call(self,path,method='GET'):
  request=urllib.request.Request(self.base+path,method=method,headers={'Authorization':'Bearer '+self.token})
  try:
   with urllib.request.urlopen(request,timeout=25) as r:return r.status,r.read()
  except urllib.error.HTTPError as e:return e.code,e.read()
 def read_json(self,path):
  status,data=self.call(path);result=json.loads(data)
  if status!=200 or not result.get('success'):raise RuntimeError('Owned inbox API unavailable: '+str(status))
  return result['result']
 def keys(self):
  found=set();cursor=None
  for _ in range(10):
   query={'prefix':self.prefix,'limit':1000}
   if cursor:query['cursor']=cursor
   status,data=self.call(self.api+'/keys?'+urllib.parse.urlencode(query));result=json.loads(data)
   if status!=200 or not result.get('success'):raise RuntimeError('Owned inbox key read unavailable')
   found.update(row['name'] for row in result['result']);cursor=(result.get('result_info') or {}).get('cursor')
   if not cursor:return found
  raise RuntimeError('Owned inbox exceeds bounded pagination')
 def path(self,key):
  if not key.startswith(self.prefix) or key in self.baseline:raise RuntimeError('Only new owned messages may be read or cleaned')
  return self.api+'/values/'+urllib.parse.quote(key,safe='')
 def wait_code(self,db,user_id):
  for _ in range(24):
   for key in sorted(self.keys()-self.baseline):
    status,data=self.call(self.path(key))
    if status==404:continue
    if status!=200:raise RuntimeError('Owned message read unavailable')
    for code in candidate_codes(data):
     digest=hashlib.sha256((RECIPIENT+':'+code).encode()).hexdigest();match=db.execute('SELECT user_id FROM auth_password_resets WHERE token_hash=%s AND user_id::text=%s AND expires_at>NOW()',(digest,user_id)).fetchone();db.commit()
     if match:self.key=key;self.digest=hashlib.sha256(data).hexdigest();self.received=True;return code
   time.sleep(5)
  raise RuntimeError('Correlated recovery email not received within 120 seconds')
 def cleanup(self):
  if self.key is None:return 'No matched message; existing inbox preserved'
  status,data=self.call(self.path(self.key))
  if status!=200 or hashlib.sha256(data).hexdigest()!=self.digest:raise RuntimeError('Owned test message changed; preserve')
  status,_=self.call(self.path(self.key),'DELETE')
  if status not in [200,204]:raise RuntimeError('Owned matched-message cleanup failed')
  return 'Only the database-correlated, hash-matched synthetic message removed'
