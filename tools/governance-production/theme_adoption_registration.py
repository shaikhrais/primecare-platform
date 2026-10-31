"""Exact, additive theme metadata registration on an existing authorized host.

No new screens, routes, role grants, APIs, business data or runtime activation.
"""
import datetime
import hashlib
import json
import os
from pathlib import Path
import sys

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / 'tools/workflow-verification'))
from production_store import ProductionWorkflowStore, quote
from production_reader import GovernanceReadError, connect

FILE = Path(__file__).with_name('theme-adoption-contract.json')
TABLES = {'screen_components': 'id', 'screen_required_elements': 'id',
          'language_resources': 'resource_id', 'language_resource_values': 'translation_id'}


def expected_scope():
    c = json.loads(FILE.read_text())
    return dict(optInVariable='GOVERNANCE_THEME_ADOPTION_WRITES', tables=list(TABLES),
                contractSha256=hashlib.sha256(FILE.read_bytes()).hexdigest(),
                screenCode=c['registrationTarget']['screenCode'], route=c['registrationTarget']['route'],
                resourceNamespace='themeWorkspace.', schemaChanges=False, businessDataWrites=False,
                roleGrants=False, runtimeActivation=False)


class ThemeStore(ProductionWorkflowStore):
    def __init__(self):
        super().__init__()
        try:
            if self.pin.get('themeAdoptionWriter') != expected_scope() or os.environ.get('GOVERNANCE_THEME_ADOPTION_WRITES') != '1':
                raise GovernanceReadError('Exact theme metadata scope required')
            self.db.execute('LOCK TABLE ' + ','.join(self.table(t) for t in TABLES) + ' IN SHARE ROW EXCLUSIVE MODE')
            for table in TABLES:
                meta = self.tables.get(table)
                if not meta or any(len(c['storage_types']) > 1 for c in meta['columns']):
                    raise GovernanceReadError('Missing or mixed theme metadata schema')
                actual = dict(self.db.execute('SELECT column_name,data_type FROM information_schema.columns WHERE table_schema=%s AND table_name=%s', (self.pin['schema'], 'govt_' + table)).fetchall())
                expected = {'_primecare_import_row': 'bigint', **{c['name']: {'integer': 'bigint', 'real': 'double precision', 'text': 'text', 'blob': 'bytea'}.get(c['storage_types'][0] if c['storage_types'] else None, 'jsonb') for c in meta['columns']}}
                if actual != expected:
                    raise GovernanceReadError('Theme metadata physical schema mismatch')
        except Exception:
            self.db.rollback()
            self.db.close()
            raise

    def ensure(self, table, key, values):
        if table not in TABLES:
            raise GovernanceReadError('Unscoped theme metadata write')
        c = json.loads(FILE.read_text())
        if table == 'language_resources' and key.get('resource_key') not in c['resources']:
            raise GovernanceReadError('Unrelated theme resource')
        if table == 'language_resource_values':
            resource = self.execute('SELECT resource_key FROM language_resources WHERE resource_id=?', (key.get('resource_id'),)).fetchall()
            language = self.execute('SELECT language_code,enabled FROM languages WHERE language_id=?', (key.get('language_id'),)).fetchall()
            if len(resource) != 1 or resource[0][0] not in c['resources'] or len(language) != 1 or language[0][0] not in ['en', 'fr', 'es'] or language[0][1] != 1:
                raise GovernanceReadError('Unrelated theme translation')
            if values != dict(translated_text=c['resources'][resource[0][0]][language[0][0]], reviewed=0, approved=0, version='theme-workspace-v1'):
                raise GovernanceReadError('Unexpected theme translation payload')
        if table in ['screen_components', 'screen_required_elements']:
            field = 'component_code' if table == 'screen_components' else 'element_key'
            if key.get(field) not in {'themeWorkspace.' + x['testId'] for x in c['controls']}:
                raise GovernanceReadError('Unrelated theme control')
            host = self.execute('SELECT screen_code,route_path,active FROM screens WHERE id=?', (key.get('screen_id'),)).fetchall()
            if host != [(c['registrationTarget']['screenCode'], c['registrationTarget']['route'], 1)]:
                raise GovernanceReadError('Exact active theme host required')
        fields = list(values)
        pk = TABLES[table]
        rows = self.execute('SELECT ' + pk + ',' + ','.join(fields) + ' FROM ' + table + ' WHERE ' + ' AND '.join(k + '=?' for k in key), tuple(key.values())).fetchall()
        if rows:
            if len(rows) != 1 or tuple(rows[0][1:]) != tuple(values.values()):
                raise GovernanceReadError('Existing theme metadata differs; preserve it')
            return rows[0][0]
        values = {**key, **values}
        columns = {col['name'] for col in self.tables[table]['columns']}
        if not set(values) <= columns:
            raise GovernanceReadError('Unknown theme metadata fields')
        values[pk] = self.execute('SELECT COALESCE(MAX(' + pk + '),0)+1 FROM ' + table).fetchone()[0]
        if 'created_at' in columns:
            values.setdefault('created_at', datetime.datetime.now(datetime.timezone.utc).isoformat())
        ordinal = self.db.execute('SELECT COALESCE(MAX(_primecare_import_row),-1)+1 FROM ' + self.table(table)).fetchone()[0]
        keys = list(values)
        self.db.execute('INSERT INTO ' + self.table(table) + ' (_primecare_import_row,' + ','.join(map(quote, keys)) + ') VALUES (' + ','.join(['%s'] * (len(keys) + 1)) + ')', [ordinal, *[self._value(table, k, values[k]) for k in keys]])
        return values[pk]


def register(db, catalog=None):
    c = catalog if catalog is not None else json.loads(FILE.read_text())
    if c != json.loads(FILE.read_text()):
        raise GovernanceReadError('Only the pinned theme contract is accepted')
    if db.pin.get('themeAdoptionWriter') != expected_scope() or os.environ.get('GOVERNANCE_THEME_ADOPTION_WRITES') != '1':
        raise GovernanceReadError('Exact theme metadata scope required')
    target = c['registrationTarget']
    hosts = db.execute('SELECT id,route_path,actual_file_path,active FROM screens WHERE screen_code=?', (target['screenCode'],)).fetchall()
    if len(hosts) != 1 or hosts[0][1:] != (target['route'], target['sourceFile'], 1):
        raise GovernanceReadError('Existing registered host identity differs')
    sid = hosts[0][0]
    if not db.execute('SELECT role_id FROM role_screen_permissions WHERE screen_id=? AND can_view=1', (sid,)).fetchall():
        raise GovernanceReadError('Existing host view permissions required')
    for code in c['requiredExistingComponents']:
        if db.execute('SELECT active FROM primecare_ui_component_registry WHERE component_code=?', (code,)).fetchall() != [(1,)]:
            raise GovernanceReadError('Existing active theme component required')
    languages = dict(db.execute("SELECT language_code,language_id FROM languages WHERE language_code IN ('en','fr','es') AND enabled=1"))
    if set(languages) != {'en', 'fr', 'es'}:
        raise GovernanceReadError('Existing theme languages required')
    resource_ids = {}
    for key, text in c['resources'].items():
        rid = db.ensure('language_resources', {'resource_key': key}, dict(resource_group='themeWorkspace', description='Shared workspace layout label', context='theme_workspace', active=1))
        resource_ids[key] = rid
        for locale, language in languages.items():
            old = db.execute('SELECT translated_text,reviewed,approved FROM language_resource_values WHERE resource_id=? AND language_id=?', (rid, language)).fetchall()
            if old:
                # Never overwrite reviewed flags, versions or reviewed text.
                if len(old) != 1 or old[0][0] != text[locale]:
                    raise GovernanceReadError('Existing theme translation differs; preserve it')
            else:
                db.ensure('language_resource_values', dict(resource_id=rid, language_id=language), dict(translated_text=text[locale], reviewed=0, approved=0, version='theme-workspace-v1'))
    control_ids = {}
    for control in c['controls']:
        key = 'themeWorkspace.' + control['testId']
        label = c['resources'][control['resourceKey']]['en']
        cid = db.ensure('screen_components', dict(screen_id=sid, component_code=key), dict(component_name=label, component_type=control['componentCode'], data_cy=control['testId'], file_path=target['controlsSource'], implementation_status='registered-unimplemented'))
        db.ensure('screen_required_elements', dict(screen_id=sid, element_key=key), dict(element_type=control['componentCode'], label=label, test_id=control['testId'], required=0))
        control_ids[control['testId']] = cid
    return dict(screenId=sid, screenCode=target['screenCode'], controls=control_ids, resourceIds=resource_ids, translationCount=len(resource_ids) * 3,
                roleGrants=0, schemaChanges=False, runtimeActivated=False, reviewApproved=False)


def verify_independently(receipt):
    c = json.loads(FILE.read_text())
    with connect() as reader:
        for key, rid in receipt['resourceIds'].items():
            if reader.execute('SELECT resource_key,active FROM language_resources WHERE resource_id=?', (rid,)).fetchall() != [(key, 1)]:
                raise GovernanceReadError('Theme resource readback failed')
            rows = reader.execute('SELECT l.language_code,v.translated_text FROM language_resource_values v JOIN languages l ON l.language_id=v.language_id WHERE v.resource_id=?', (rid,)).fetchall()
            if dict(rows) != {lang: c['resources'][key][lang] for lang in ['en', 'fr', 'es']} or len(rows) != 3:
                raise GovernanceReadError('Theme translation readback failed')
        for control in c['controls']:
            expected = [(receipt['controls'][control['testId']], control['componentCode'], 'registered-unimplemented')]
            actual = reader.execute('SELECT id,component_type,implementation_status FROM screen_components WHERE screen_id=? AND data_cy=?', (receipt['screenId'], control['testId'])).fetchall()
            if actual != expected:
                raise GovernanceReadError('Theme control readback failed')
            if reader.execute('SELECT required FROM screen_required_elements WHERE screen_id=? AND test_id=?', (receipt['screenId'], control['testId'])).fetchall() != [(0,)]:
                raise GovernanceReadError('Theme optional element readback failed')


def main():
    if sys.argv[1:] not in [['--dry-run'], ['--apply']]:
        raise SystemExit('Explicit --dry-run or --apply required')
    with ThemeStore() as db:
        result = register(db)
        if register(db) != result:
            raise GovernanceReadError('Theme registration is not idempotent')
        if sys.argv[1] == '--dry-run':
            db.db.rollback()
    result['committed'] = sys.argv[1] == '--apply'
    if result['committed']:
        verify_independently(result)
        result['independentReadback'] = True
    print('THEME_METADATA_REGISTRATION ' + json.dumps(result, sort_keys=True))


if __name__ == '__main__':
    main()
