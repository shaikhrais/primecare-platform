"""Repair missing workspace resources and malformed legacy serialized label values."""
import json
from pathlib import Path
import runpy

ROOT = Path(__file__).resolve().parents[1]
flatten = runpy.run_path(str(ROOT / 'scripts/audit-ui-localization.py'))['flatten']
workspace = json.loads((ROOT / 'packages/primecare_ui/lib/src/localization/screens/workspace.json').read_text())['locales']


def set_path(document, path, value):
    parts = path.split('.')
    for part in parts[:-1]:
        document = document.setdefault(part, {})
    document[parts[-1]] = value


def repair(directory):
    documents = {language: json.loads((directory / f'{language}.json').read_text()) for language in ('en', 'fr', 'es')}
    malformed = {key: value for key, value in flatten(documents['en']).items() if value.startswith('@{')}
    for key, value in malformed.items():
        if value == '@{title=Value; subtitle=Title}':
            labels = ('Value', 'Valeur', 'Valor')
        elif value == '@{value=; subtitle=Client Kpi Section}':
            labels = ('Client indicators', 'Indicateurs du client', 'Indicadores del cliente')
        elif value == '@{value=; subtitle=Family Kpi Section}':
            labels = ('Family indicators', 'Indicateurs de la famille', 'Indicadores de la familia')
        elif value == '@{value=; subtitle=Guest Kpi Section}':
            labels = ('Guest indicators', 'Indicateurs de l’invité', 'Indicadores del invitado')
        else:
            raise ValueError(f'Unreviewed malformed label: {key}')
        for language, text in zip(('en', 'fr', 'es'), labels):
            set_path(documents[language], key, text)
    for language, document in documents.items():
        document['workspace'] = workspace[language]
    english = flatten(documents['en'])
    for language in ('fr', 'es'):
        target = flatten(documents[language])
        missing = english.keys() - target.keys()
        if missing:
            raise ValueError(f'{directory}/{language}: unresolved keys {sorted(missing)}')
    for language, document in documents.items():
        (directory / f'{language}.json').write_text(json.dumps(document, ensure_ascii=False, indent=4) + '\n')
    return len(malformed)


if __name__ == '__main__':
    paths = list((ROOT / 'apps').glob('*/assets/translations/en.json'))
    paths += [ROOT / 'packages/flutter_core/assets/translations/en.json']
    for path in paths:
        print(path.parent.relative_to(ROOT), 'malformed labels repaired:', repair(path.parent), 'workspace keys:', 35)
