"""Pinned PostgreSQL governance reader. No silent SQLite or write fallback."""
import json, os, pathlib, sqlite3, subprocess
import sqlglot
from sqlglot import exp
from sqlglot.tokens import TokenType

ROOT=pathlib.Path(__file__).resolve().parent
class GovernanceReadError(RuntimeError): pass
class GovernanceRow:
    def __init__(self,names,values):self.names=names;self.values=values
    def keys(self):return self.names
    def __len__(self):return len(self.values)
    def __iter__(self):return iter(self.values)
    def __getitem__(self,key):
        return self.values[key] if isinstance(key,(int,slice)) else self.values[next(i for i,n in enumerate(self.names) if n.lower()==key.lower())]
class Cursor:
    def __init__(self,connection):self.connection=connection;self.description=[];self.values=[];self.position=0
    def execute(self,sql,parameters=()):
        self.names,self.values=self.connection.query(sql,parameters);self.position=0;self.description=[(n,None,None,None,None,None,None) for n in self.names];return self
    def fetchone(self):
        if self.position>=len(self.values):return None
        row=self.values[self.position];self.position+=1
        if self.connection.row_factory is None:return tuple(row)
        if self.connection.row_factory is sqlite3.Row:return GovernanceRow(self.names,row)
        return self.connection.row_factory(self,tuple(row))
    def fetchall(self):return list(self)
    def fetchmany(self,size=1):
        result=[]
        for _ in range(size):
            r=self.fetchone()
            if r is None:break
            result.append(r)
        return result
    def __iter__(self):return self
    def __next__(self):
        r=self.fetchone()
        if r is None:raise StopIteration
        return r
    def close(self):pass
class Connection:
    def __init__(self,*,_test_fixture=None):
        self.row_factory=None;command=['node',str(ROOT/'read-bridge.mjs')];environment=os.environ.copy()
        if _test_fixture:
            command+=['--fixture',str(_test_fixture)];environment.update(GOVERNANCE_ALLOW_TEST_FIXTURE='1',NODE_ENV='test')
        self.process=subprocess.Popen(command,stdin=subprocess.PIPE,stdout=subprocess.PIPE,stderr=subprocess.DEVNULL,text=True,encoding='utf8',env=environment)
        ready=self._receive()
        if not ready.get('ready'):
            self.close();raise GovernanceReadError('Production governance connection failed: '+str(ready.get('phase'))+' / '+str(ready.get('code')))
        self.pin=ready['pin'];self.manifest=ready['manifest'];self.tables={t['name'].lower():t for t in self.manifest['tables']};self.metadata=sqlite3.connect(':memory:')
        # Source schema only: no source rows or old governance file are loaded.
        for kind in ['table','index','view','trigger']:
            for typ,name,table,ddl in self.manifest.get('sqlite_objects',[]):
                if typ==kind and ddl and not name.startswith('sqlite_'):self.metadata.execute(ddl)
    def _receive(self):
        line=self.process.stdout.readline()
        if not line:raise GovernanceReadError('Governance reader protocol closed without a result')
        return json.loads(line)
    def _relation(self,name,alias):
        key=name.lower()
        if key.startswith('govt_') and key not in self.tables:key=key[5:]
        if key not in self.tables:raise GovernanceReadError('Unregistered governance relation: '+name)
        t=self.tables[key];columns=[]
        for c in t['columns']:
            ident=exp.column(c['name'],quoted=True)
            if not c['storage_types']:
                declared=c['declared_type'].upper();typ='BIGINT' if 'INT' in declared else 'DOUBLE PRECISION' if any(k in declared for k in ('REAL','FLOA','DOUB')) else 'TEXT'
                # The import encoded these columns as all-NULL JSONB. Never discard an unexpected payload.
                col=ident.sql(dialect='postgres')
                expression=sqlglot.parse_one("CASE WHEN "+col+" IS NULL OR "+col+" ->> 't' = 'null' THEN CAST(NULL AS "+typ+") ELSE CAST(1 / (LENGTH("+col+"::text) - LENGTH("+col+"::text)) AS "+typ+") END",read='postgres')
                ident=expression
            elif len(c['storage_types'])!=1:raise GovernanceReadError('Mixed storage requires an explicit column migration')
            columns.append(exp.alias_(ident,c['name'],quoted=True))
        physical='govt_'+t['name'] if not t['name'].startswith('govt_') else t['name']
        select=exp.select(*columns).from_(exp.Table(this=exp.to_identifier(physical,quoted=True),db=exp.to_identifier(self.pin['schema'],quoted=True)))
        return exp.Subquery(this=select,alias=exp.TableAlias(this=exp.to_identifier(alias,quoted=True)))
    def compile(self,sql,parameters=()):
        tokens=sqlglot.tokenize(sql,read='sqlite');positions=[t for t in tokens if t.token_type==TokenType.PLACEHOLDER and t.text=='?']
        for i,t in reversed(list(enumerate(positions))):sql=sql[:t.start]+':govt_p'+str(i)+sql[t.end+1:]
        tree=sqlglot.parse(sql,read='sqlite')
        if len(tree)!=1 or not isinstance(tree[0],(exp.Select,exp.Union,exp.Intersect,exp.Except)):raise GovernanceReadError('Read-only production governance connection: writer migration required')
        tree=tree[0]
        if any(tree.find_all(exp.Insert,exp.Update,exp.Delete,exp.Create,exp.Drop,exp.Alter,exp.Into,exp.Lock)):raise GovernanceReadError('Governance mutations are not enabled')
        bindings=[]
        for p in tree.find_all(exp.Placeholder):
            name=p.this
            if not name or not name.startswith('govt_p'):raise GovernanceReadError('Only positional query parameters are supported')
            index=int(name[6:]);p.replace(exp.Parameter(this=exp.Literal.number(index+1)))
        if len(positions)!=len(parameters):raise GovernanceReadError('Query parameter count mismatch')
        ctes={c.alias_or_name.lower() for c in tree.find_all(exp.CTE)}
        for table in list(tree.find_all(exp.Table)):
            if table.name.lower() in ctes:continue
            if table.db or table.catalog:raise GovernanceReadError('Cross-schema governance query refused')
            table.replace(self._relation(table.name,table.alias_or_name))
        for a in tree.find_all(exp.Alias):
            if isinstance(a.args.get('alias'),exp.Identifier):a.args['alias'].set('quoted',True)
        return tree.sql(dialect='postgres',unsupported_level=sqlglot.ErrorLevel.RAISE),list(parameters)
    def query(self,sql,parameters=()):
        s=sql.strip()
        parsed=sqlglot.parse_one(sql,read='sqlite')
        schema_only=isinstance(parsed,exp.Select) and {t.name.lower() for t in parsed.find_all(exp.Table)}=={'sqlite_master'}
        if s.upper().startswith('PRAGMA') or schema_only:
            if s.upper().startswith('PRAGMA') and (any(x in s for x in ['=']) or s.split('(')[0].strip().lower().split()[-1] not in ['table_info','table_xinfo','foreign_key_list','index_info','index_list']):raise GovernanceReadError('Unsupported production schema inspection')
            if not s.upper().startswith(('SELECT','PRAGMA')) or ';' in s.rstrip(';'):raise GovernanceReadError('Only read-only source schema inspection is supported')
            cursor=self.metadata.execute(sql,parameters);return [c[0] for c in cursor.description or []],[list(r) for r in cursor.fetchall()]
        compiled,args=self.compile(sql,parameters)
        self.process.stdin.write(json.dumps({'op':'query','sql':compiled,'parameters':args})+'\n');self.process.stdin.flush();result=self._receive()
        if not result.get('ok'):raise GovernanceReadError('Production governance query failed: '+str(result.get('code')))
        names=[f['name'] for f in result['fields']];rows=[]
        for row in result['rows']:
            rows.append([int(v) if v is not None and f['type']==20 else bytes(v['data']) if v is not None and f['type']==17 else v for f,v in zip(result['fields'],row)])
        return names,rows
    def execute(self,sql,parameters=()):return self.cursor().execute(sql,parameters)
    def cursor(self):return Cursor(self)
    def close(self):
        if getattr(self,'process',None):
            if self.process.poll() is None:
                try:self.process.stdin.write('{"op":"close"}\n');self.process.stdin.flush();self.process.communicate(timeout=10)
                except (BrokenPipeError,subprocess.TimeoutExpired):self.process.kill();self.process.wait()
            self.process=None
        if getattr(self,'metadata',None):self.metadata.close()
    def __enter__(self):return self
    def __exit__(self,*args):self.close()
def connect(*, _test_fixture=None):return Connection(_test_fixture=_test_fixture)
