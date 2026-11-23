"""Parity and export of the exact pinned Theme Center option resources."""
import hashlib
import json
from pathlib import Path

ROOT=Path(__file__).resolve().parents[2]
CATALOG='tools/governance-production/theme-option-resources.json'
PREFIX='themeCenter.options.'

def load_catalog(pin):
    scope=pin.get('themeOptionResourceWriter',{})
    raw=(ROOT/CATALOG).read_bytes()
    if scope.get('catalogPath')!=CATALOG or hashlib.sha256(raw).hexdigest()!=scope.get('catalogSha256'):
        raise RuntimeError('Pinned Theme Center option catalog required')
    document=json.loads(raw)
    keys={'font.'+k for k in ['system','serif','monospace']} | {'color.'+k for k in ['primary','primaryContainer','secondary','background','surface','text','muted','border','sidebar','topbar','disabled']} | {'invalidColor','copyName','brand.slogan'}
    locales=document.get('locales',{})
    if document.get('version')!=1 or document.get('screen')!='theme_center_options' or set(locales)!={'en','fr','es'}:
        raise RuntimeError('Exact Theme Center option identities required')
    for values in locales.values():
        if set(values)!=keys or any(not isinstance(v,str) or not v.strip() or len(v)>2000 for v in values.values()) or '{name}' not in values['copyName']:
            raise RuntimeError('Invalid Theme Center option copy')
    return locales

def verify(db):
    expected=load_catalog(db.pin)
    records=db.execute('SELECT r.resource_key,r.resource_group,r.context,r.active,l.language_code,v.translated_text,v.reviewed,v.approved FROM language_resources r JOIN language_resource_values v USING(resource_id) JOIN languages l USING(language_id) WHERE r.resource_key LIKE ?', (PREFIX+'%',)).fetchall()
    actual={language:{} for language in expected}
    for key,group,context,active,language,value,reviewed,approved in records:
        short=key.removeprefix(PREFIX)
        if (group,context,active)!=('themeCenterOptions','theme_center',1) or language not in actual or short in actual[language]:
            raise RuntimeError('Unexpected or duplicate Theme Center option registration')
        actual[language][short]=value
    if actual!=expected:raise RuntimeError('Theme Center option production parity failed')
    return {'source_parity':True,'registered_resources':len(expected['en']),'registered_values':len(records),'reviewed_values':sum(row[6]==1 for row in records),'approved_values':sum(row[7]==1 for row in records),'independent_review':'not inferred from parity'}

def export_dart(db):
    verify(db)
    return render_dart(load_catalog(db.pin))

def render_dart(catalogs):
    """Format a pinned catalogue; this function makes no database parity claim."""
    lines=['// Generated from governance resources by scripts/register-theme-center-options.py.', 'const themeCenterOptions = <String, Map<String, String>>{']
    for language,values in catalogs.items():
        lines.append('  '+json.dumps(language)+': {')
        for key,value in sorted(values.items()):
            lines.append('    '+json.dumps(key)+': '+json.dumps(value,ensure_ascii=False).replace('$',r'\$')+',')
        lines.append('  },')
    return '\n'.join(lines+['};',''])
