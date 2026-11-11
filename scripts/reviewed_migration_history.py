"""Compose exact source receipts when later reviewed migrations touch a library."""
import hashlib
import importlib.util
import json
from pathlib import Path

ROOT=Path(__file__).resolve().parents[1]

def before_native_compile_repairs(source,path):
    manifest=ROOT/'scripts/native-generated-compile-repairs.json'
    if not manifest.exists():return source
    row=next((r for r in json.loads(manifest.read_text()) if r['path']==path),None)
    if row is None or hashlib.sha256(source.encode()).hexdigest()!=row['updated_sha256']:return source
    for edit in reversed(row['edits']):
        begin=edit['begin']
        if source[begin:begin+len(edit['new'])]!=edit['new']:raise AssertionError('Native compile output drift: '+path)
        source=source[:begin]+edit['old']+source[begin+len(edit['new']):]
    if hashlib.sha256(source.encode()).hexdigest()!=row['sha256']:raise AssertionError('Native compile input drift: '+path)
    return source

def before_controller_ref_aliases(source,path):
    source=before_native_compile_repairs(source,path)
    manifest=ROOT/'scripts/controller-ref-alias-manifest.json'
    if not manifest.exists():return source
    row=next((r for r in json.loads(manifest.read_text()) if r['path']==path),None)
    if row is None or hashlib.sha256(source.encode()).hexdigest()!=row['updated_sha256']:
        return source
    edits=[];delta=0
    for edit in row['edits']:
        begin=edit['begin']+delta
        if source[begin:begin+len(edit['new'])]!=edit['new']:raise AssertionError('Controller reference output drift: '+path)
        edits.append((begin,begin+len(edit['new']),edit['old']));delta+=len(edit['new'])-(edit['end']-edit['begin'])
    for a,b,value in reversed(edits):source=source[:a]+value+source[b:]
    if hashlib.sha256(source.encode()).hexdigest()!=row['sha256']:raise AssertionError('Controller reference input drift: '+path)
    return source

def before_remaining_material_controls(source,path):
    source=before_controller_ref_aliases(source,path)
    manifest=ROOT/'scripts/remaining-material-controls-manifest.json'
    if not manifest.exists():return source
    row=next((r for r in json.loads(manifest.read_text()) if r['path']==path),None)
    if row is None or hashlib.sha256(source.encode()).hexdigest()!=row['updated_sha256']:
        return source
    edits=[];delta=0
    for edit in row['edits']:
        begin=edit['begin']+delta
        if source[begin:begin+len(edit['new'])]!=edit['new']:raise AssertionError('Remaining controls output drift: '+path)
        edits.append((begin,begin+len(edit['new']),edit['old']));delta+=len(edit['new'])-(edit['end']-edit['begin'])
    for a,b,value in reversed(edits):source=source[:a]+value+source[b:]
    if hashlib.sha256(source.encode()).hexdigest()!=row['sha256']:raise AssertionError('Remaining controls input drift: '+path)
    return source

def before_remaining_palette(source,path):
    source=before_remaining_material_controls(source,path)
    manifest=ROOT/'scripts/remaining-theme-palette-manifest.json'
    if not manifest.exists():return source
    row=next((r for r in json.loads(manifest.read_text()) if r['path']==path),None)
    if row is None or hashlib.sha256(source.encode()).hexdigest()!=row['updated_sha256']:
        return source
    edits=[];delta=0
    for edit in row['edits']:
        begin=edit['begin']+delta
        if source[begin:begin+len(edit['new'])]!=edit['new']:raise AssertionError('Remaining palette output drift: '+path)
        edits.append((begin,begin+len(edit['new']),edit['old']));delta+=len(edit['new'])-(edit['end']-edit['begin'])
    for a,b,value in reversed(edits):source=source[:a]+value+source[b:]
    if hashlib.sha256(source.encode()).hexdigest()!=row['sha256']:raise AssertionError('Remaining palette input drift: '+path)
    return source

def before_shared_app_bars(source,path):
    source=before_remaining_palette(source,path)
    app_bar_script=ROOT/'scripts/migrate-shared-app-bars.py'
    if not app_bar_script.exists():return source
    spec=importlib.util.spec_from_file_location('shared_app_bar_history',app_bar_script)
    migration=importlib.util.module_from_spec(spec);spec.loader.exec_module(migration)
    reversed_source,count=migration.reverse_source(path,source)
    return reversed_source if count else source

def before_shared_cards(source,path):
    source=before_shared_app_bars(source,path)
    card_script=ROOT/'scripts/migrate-shared-cards.py'
    if not card_script.exists():return source
    spec=importlib.util.spec_from_file_location('shared_card_history',card_script)
    migration=importlib.util.module_from_spec(spec);spec.loader.exec_module(migration)
    reversed_source,count=migration.reverse_source(path,source)
    return reversed_source if count else source

def before_shared_snack_bars(source,path):
    source=before_shared_cards(source,path)
    snack_script=ROOT/'scripts/migrate-shared-snack-bars.py'
    if not snack_script.exists():return source
    spec=importlib.util.spec_from_file_location('shared_snack_bar_history',snack_script)
    migration=importlib.util.module_from_spec(spec);spec.loader.exec_module(migration)
    reversed_source,count=migration.reverse_source(path,source)
    return reversed_source if count else source


def reverse_manifest(source,path,filename):
    source=before_shared_snack_bars(source,path)
    manifest=ROOT/'scripts'/filename
    if not manifest.exists():return source
    row=next((r for r in json.loads(manifest.read_text()) if r['path']==path),None)
    if row is None:return source
    if hashlib.sha256(source.encode()).hexdigest()==row['sha256']:
        return source  # Already at this exact verified input revision.
    edits=[];delta=0
    for edit in row['edits']:
        begin=edit['begin']+delta
        if source[begin:begin+len(edit['new'])]!=edit['new']:
            raise AssertionError('Reviewed migration output drift: '+path)
        edits.append((begin,begin+len(edit['new']),edit['old']))
        delta+=len(edit['new'])-(edit['end']-edit['begin'])
    for a,b,value in reversed(edits):source=source[:a]+value+source[b:]
    if hashlib.sha256(source.encode()).hexdigest()!=row['sha256']:
        raise AssertionError('Reviewed migration input drift: '+path)
    return source


def before_circular_progress(source,path):
    return reverse_manifest(source,path,'shared-circular-progress-manifest.json')


def before_governance_palette(source,path):
    return reverse_manifest(source,path,'governance-widgets-palette-manifest.json')


def before_shared_text_fields(source,path):
    source=reverse_manifest(source,path,'presentation-palette-manifest.json')
    source=before_governance_palette(source,path)
    manifest_path=ROOT/'scripts/shared-text-fields-manifest.json'
    script_path=ROOT/'scripts/migrate-shared-text-fields.py'
    if not manifest_path.exists() or not script_path.exists():return source
    row=json.loads(manifest_path.read_text()).get(path)
    if row is None:return source
    spec=importlib.util.spec_from_file_location('shared_text_field_history',script_path)
    migration=importlib.util.module_from_spec(spec);spec.loader.exec_module(migration)
    original,count=migration.reverse_source(path,source,row[1])
    if count!=row[1] or hashlib.sha256(original.encode()).hexdigest()!=row[0]:
        raise AssertionError('Shared text field output drift: '+path)
    return original


def before_shared_scaffolds(source,path):
    source=before_shared_snack_bars(source,path)
    manifest_path=ROOT/'scripts/shared-scaffold-constructors-manifest.json'
    script_path=ROOT/'scripts/migrate-shared-scaffolds.py'
    if not manifest_path.exists() or not script_path.exists():return source
    row=json.loads(manifest_path.read_text()).get(path)
    if row is None:return source
    spec=importlib.util.spec_from_file_location('shared_scaffold_history',script_path)
    migration=importlib.util.module_from_spec(spec);spec.loader.exec_module(migration)
    original,count=migration.reverse_source(path,source,row[1])
    if count!=row[1] or hashlib.sha256(original.encode()).hexdigest()!=row[0]:
        raise AssertionError('Shared scaffold output drift: '+path)
    return original


def before_control_extensions(source,path):
    source=before_shared_snack_bars(source,path)
    source=reverse_manifest(source,path,'branding-settings-palette-manifest.json')
    source=reverse_manifest(source,path,'shared-metric-contrast-manifest.json')
    source=before_shared_text_fields(source,path)
    source=before_shared_scaffolds(source,path)
    source=before_circular_progress(source,path)
    return reverse_manifest(source,path,'shared-control-extensions-manifest.json')
