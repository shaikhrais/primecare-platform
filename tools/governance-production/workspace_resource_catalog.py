"""Read-only parity for the exact existing workspace resource catalog."""
import hashlib,json
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2]

def verify(db):
    scope=db.pin.get('workspaceResourceWriter',{})
    path=ROOT/'packages/primecare_ui/lib/src/localization/screens/workspace.json'
    if scope.get('catalogPath')!=str(path.relative_to(ROOT)) or hashlib.sha256(path.read_bytes()).hexdigest()!=scope.get('catalogSha256'):
        raise RuntimeError('Workspace resource source differs from pinned registration input')
    expected=json.loads(path.read_text())['locales']
    rows=db.execute("SELECT r.resource_key,l.language_code,v.translated_text,v.reviewed,v.approved FROM language_resources r JOIN language_resource_values v USING(resource_id) JOIN languages l USING(language_id) WHERE r.resource_key LIKE ?",('screenText.workspace.%',)).fetchall()
    actual={locale:{} for locale in ['en','fr','es']}
    for key,locale,value,reviewed,approved in rows:
        if locale not in actual:raise RuntimeError('Unexpected workspace resource language')
        name=key.removeprefix('screenText.workspace.')
        if name in actual[locale]:raise RuntimeError('Duplicate workspace translation identity')
        actual[locale][name]=value
    if actual!=expected:raise RuntimeError('Workspace source labels differ from pinned production registrations; reconcile before building')
    return {'source_parity':True,'registered_values':len(rows),'reviewed_values':sum(r[3]==1 for r in rows),'approved_values':sum(r[4]==1 for r in rows),'independent_review':'not inferred from parity'}
