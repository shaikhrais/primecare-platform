"""Transaction-bound metadata store: pinned TLS connection, SELECT compiler, scoped table locks.

No workflow tracking writes, operational SQLite fallback, DDL or business data interface.
"""
import json,os,re,ssl
from pathlib import Path
from urllib.parse import urlsplit,unquote
import sys
sys.path.insert(0,str(Path(__file__).resolve().parents[1]/'workflow-verification'))
from production_store import ProductionWorkflowStore,Result,quote
from production_reader import Connection as Reader,GovernanceReadError
PIN=Path(__file__).with_name('production-pin.json')
ALLOWED={'screen_components','screen_required_elements','language_resources','language_resource_values','primecare_ui_component_registry'}
class MetadataStore:
    _value=ProductionWorkflowStore._value
    def __init__(self,slot,expected):
        self.pin=json.loads(PIN.read_text())
        if self.pin.get(slot)!=expected or not set(expected['tables'])<=ALLOWED or any(expected.get(k) is not False for k in ['schemaChanges','businessDataWrites','roleGrants','runtimeActivation']) or os.environ.get(expected['optInVariable'])!='1':raise GovernanceReadError('Exact metadata write scope required')
        if os.environ.get('GOVERNANCE_ALLOW_SQLITE_FIXTURES')=='1':raise GovernanceReadError('Production metadata cannot use SQLite fixtures')
        production,legacy=os.environ.get('PRODUCTION_DATABASE_URL'),os.environ.get('GOVERNANCE_DATABASE_URL')
        # Keep the legacy conflict guard without accepting it as a connection source.
        if legacy and production and legacy!=production:raise GovernanceReadError('Conflicting governance database configuration')
        url=urlsplit(production or '')
        if url.scheme not in ('postgres','postgresql') or url.hostname!='pooled.db.prisma.io' or url.path!='/postgres':raise GovernanceReadError('Pinned production metadata target required')
        ca=ssl.get_default_verify_paths().cafile
        if not ca or not Path(ca).is_file():raise GovernanceReadError('System CA bundle required')
        import psycopg
        self.db=psycopg.connect(host=url.hostname,port=url.port or 5432,dbname='postgres',user=unquote(url.username or ''),password=unquote(url.password or ''),sslmode='verify-full',sslrootcert=ca,connect_timeout=10,prepare_threshold=None)
        try:
            self.db.execute("SET LOCAL lock_timeout='10s'");self.db.execute("SET LOCAL statement_timeout='120s'")
            rows=self.db.execute('SELECT manifest_sha256,manifest FROM '+self.table('source_manifest')).fetchall()
            if len(rows)!=1 or rows[0][0]!=self.pin['manifestSha256']:raise GovernanceReadError('Pinned metadata manifest mismatch')
            self.manifest=rows[0][1];self.tables={t['name']:t for t in self.manifest['tables']}
            self.db.execute('LOCK TABLE '+','.join(self.table(t) for t in sorted(expected['tables']))+' IN SHARE ROW EXCLUSIVE MODE')
            self.reader=Reader.__new__(Reader);self.reader.pin=self.pin;self.reader.tables={k.lower():v for k,v in self.tables.items()}
        except Exception:
            self.db.rollback();self.db.close();raise
    def table(self,name):return quote(self.pin['schema'])+'.'+quote('govt_'+name)
    def execute(self,sql,parameters=()):
        if not sql.lstrip().startswith('SELECT '):raise GovernanceReadError('Metadata read interface is SELECT only')
        compiled,args=self.reader.compile(sql,parameters);ordered=[]
        def bind(match):ordered.append(args[int(match[1])-1]);return '%s'
        return Result(self.db.execute(re.sub(r'\$(\d+)',bind,compiled),ordered).fetchall())
    def __enter__(self):return self
    def __exit__(self,exc_type,*_):
        try:self.db.rollback() if exc_type else self.db.commit()
        finally:self.db.close()
