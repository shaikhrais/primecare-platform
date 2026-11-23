"""Compose exact source receipts when later reviewed migrations touch a library."""
import hashlib
import importlib.util
import json
from pathlib import Path

ROOT=Path(__file__).resolve().parents[1]

def before_account_typography(source,path):
    return reverse_presentation_receipt(source,path,'account-typography-replay.json')

def before_account_surface_style(source,path):
    source=before_account_typography(source,path)
    return reverse_presentation_receipt(source,path,'account-surface-style-replay.json')

def before_mobile_account_edge(source,path):
    source=before_account_surface_style(source,path)
    return reverse_presentation_receipt(source,path,'mobile-account-edge-replay.json')

def before_account_menu_boundary_repair(source,path):
    source=before_mobile_account_edge(source,path)
    return reverse_presentation_receipt(
        source,path,'account-menu-boundary-repair-replay.json'
    )

def before_account_menu_geometry(source,path):
    source=before_account_menu_boundary_repair(source,path)
    return reverse_presentation_receipt(
        source,path,'account-menu-geometry-replay.json'
    )

def before_account_menu_fuse_state(source,path):
    source=before_account_menu_geometry(source,path)
    return reverse_presentation_receipt(
        source,path,'account-menu-fuse-state-replay.json'
    )

def before_account_menu_state_capture(source,path):
    source=before_account_menu_fuse_state(source,path)
    return reverse_presentation_receipt(
        source,path,'account-menu-state-capture-replay.json'
    )

def before_sidebar_account_style_boundary(source,path):
    source=before_account_menu_state_capture(source,path)
    return reverse_presentation_receipt(
        source,path,'sidebar-account-style-boundary-replay.json'
    )

def before_sidebar_account_footer(source,path):
    source=before_sidebar_account_style_boundary(source,path)
    return reverse_presentation_receipt(
        source,path,'sidebar-account-footer-replay.json'
    )

def before_toolbar_shared_tokens(source,path):
    source=before_sidebar_account_footer(source,path)
    return reverse_presentation_receipt(
        source,path,'toolbar-shared-tokens-replay.json'
    )

def before_full_render_toolbar_actions(source,path):
    source=before_toolbar_shared_tokens(source,path)
    return reverse_presentation_receipt(
        source,path,'full-render-toolbar-actions-replay.json'
    )

def before_navigation_theme_boundary(source,path):
    source=before_full_render_toolbar_actions(source,path)
    return reverse_presentation_receipt(
        source,path,'navigation-theme-boundary-replay.json'
    )

def before_full_render_navigation_focus(source,path):
    source=before_navigation_theme_boundary(source,path)
    return reverse_presentation_receipt(
        source,path,'full-render-navigation-focus-replay.json'
    )

def before_shared_navigation_render(source,path):
    source=before_full_render_navigation_focus(source,path)
    source=reverse_presentation_receipt(source,path,'shell-utility-loading-replay.json')
    return reverse_presentation_receipt(source,path,'shared-navigation-render-replay.json')

def before_sidebar_states(source,path):
    source=before_shared_navigation_render(source,path)
    return reverse_presentation_receipt(source,path,'sidebar-states-replay.json')

def before_sidebar_slogan(source,path):
    source=before_sidebar_states(source,path)
    return reverse_presentation_receipt(source,path,'sidebar-slogan-replay.json')

def before_sidebar_render(source,path):
    source=before_sidebar_slogan(source,path)
    return reverse_presentation_receipt(source,path,'sidebar-full-render-replay.json')

def before_sidebar_default(source,path):
    source=before_sidebar_render(source,path)
    return reverse_presentation_receipt(source,path,'shell-sidebar-default-replay.json')

def before_shell_border_frame(source,path):
    source=before_sidebar_default(source,path)
    return reverse_presentation_receipt(source,path,'shell-breakpoint-border-replay.json')

def before_avatar_fallback(source,path):
    source=before_shell_border_frame(source,path)
    return reverse_presentation_receipt(source,path,'shell-avatar-fallback-replay.json')

def before_shell_metrics(source,path):
    source=before_avatar_fallback(source,path)
    return reverse_presentation_receipt(source,path,'skeleton-shell-metrics-replay.json')

def before_navbar_style(source,path):
    source=before_shell_metrics(source,path)
    source=reverse_presentation_receipt(source,path,'theme-option-label-replay.json')
    return reverse_presentation_receipt(source,path,'navbar-style-replay.json')

def before_fuse_center_match(source,path):
    source=before_navbar_style(source,path)
    return reverse_presentation_receipt(source,path,'fuse-center-match-replay.json')

def before_user_settings_isolation(source,path):
    source=before_fuse_center_match(source,path)
    return reverse_presentation_receipt(source,path,'user-settings-isolation-replay.json')

def before_complete_theme_settings(source,path):
    source=before_user_settings_isolation(source,path)
    return reverse_presentation_receipt(source,path,'theme-complete-replay.json')

def before_portal_layout(source,path):
    source=before_complete_theme_settings(source,path)
    return reverse_presentation_receipt(source,path,'portal-layout-replay.json')

def reverse_presentation_receipt(source,path,filename):
    """Replay only exact hash-pinned source changes; never bless arbitrary edits."""
    manifest=ROOT/'scripts'/filename
    if not manifest.exists():return source
    doc=json.loads(manifest.read_text())
    if doc['version']!=1:raise AssertionError('Unsupported portal replay receipt')
    rows=[row for row in doc['files'] if row['path']==path]
    if not rows:return source
    if len(rows)!=1:raise AssertionError('Duplicate portal replay receipt')
    row=rows[0]
    if hashlib.sha256(source.encode()).hexdigest()!=row['afterSha256']:return source
    edits=[];delta=0
    for edit in row['edits']:
        begin=edit['begin']+delta
        if source[begin:begin+len(edit['new'])]!=edit['new']:raise AssertionError('Portal amendment output drift: '+path)
        edits.append((begin,begin+len(edit['new']),edit['old']))
        delta+=len(edit['new'])-len(edit['old'])
    for begin,end,old in reversed(edits):source=source[:begin]+old+source[end:]
    if hashlib.sha256(source.encode()).hexdigest()!=row['beforeSha256']:raise AssertionError('Portal amendment input drift: '+path)
    return source

def before_psw_unavailable_sections(source,path):
    """Replay the exact pre-unavailable PSW palette output for historical tests only."""
    source=before_portal_layout(source,path)
    manifest=ROOT/'scripts/psw-unavailable-sections-replay.json'
    if not manifest.exists():return source
    doc=json.loads(manifest.read_text())
    if doc.get('version')!=1:raise AssertionError('Unsupported PSW replay receipt')
    rows=[row for row in doc['files'] if row['path']==path]
    if not rows:return source
    if len(rows)!=1:raise AssertionError('Duplicate PSW replay receipt')
    row=rows[0]
    if hashlib.sha256(source.encode()).hexdigest()!=row['afterSha256']:return source
    if source!=row['after'] or hashlib.sha256(row['before'].encode()).hexdigest()!=row['beforeSha256']:
        raise AssertionError('PSW unavailable replay receipt drift: '+path)
    return row['before']

def before_native_application_host(source,path):
    """Remove only the exact reviewed native-host router amendment for old replays."""
    source=before_psw_unavailable_sections(source,path)
    manifest=ROOT/'scripts/native-application-host-amendment.json'
    if not manifest.exists():return source
    row=next((r for r in json.loads(manifest.read_text())['files'] if r['path']==path),None)
    if row is None:return source
    digest=hashlib.sha256(source.encode()).hexdigest()
    if digest==row['beforeSha256']:return source
    if digest!=row['afterSha256']:
        if 'nativeTenantApplicationRoute' in source:raise AssertionError('Native host router output drift: '+path)
        return source  # An earlier replay layer; its original exact pin still applies.
    edits=[];delta=0
    for edit in row['edits']:
        begin=edit['begin']+delta
        if source[begin:begin+len(edit['new'])]!=edit['new']:raise AssertionError('Native host router edit drift: '+path)
        edits.append((begin,begin+len(edit['new']),edit['old']))
        delta+=len(edit['new'])-len(edit['old'])
    for begin,end,old in reversed(edits):source=source[:begin]+old+source[end:]
    if hashlib.sha256(source.encode()).hexdigest()!=row['beforeSha256']:raise AssertionError('Native host router input drift: '+path)
    return source

def before_native_compile_repairs(source,path):
    source=before_native_application_host(source,path)
    source=before_native_widget_repairs(source,path)
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

def before_native_widget_repairs(source,path):
    source=before_portal_layout(source,path)
    manifest=ROOT/'scripts/native-widget-repairs.json'
    if not manifest.exists():return source
    row=next((r for r in json.loads(manifest.read_text()) if r['path']==path),None)
    if row is None or hashlib.sha256(source.encode()).hexdigest()!=row['updated_sha256']:return source
    for edit in reversed(row['edits']):
        begin=edit['begin']
        if source[begin:begin+len(edit['new'])]!=edit['new']:raise AssertionError('Native widget output drift: '+path)
        source=source[:begin]+edit['old']+source[begin+len(edit['new']):]
    if hashlib.sha256(source.encode()).hexdigest()!=row['sha256']:raise AssertionError('Native widget input drift: '+path)
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


def before_theme_palette_match(source,path):
    return reverse_presentation_receipt(source,path,'theme-palette-match-replay.json')

def before_control_extensions(source,path):
    source=before_theme_palette_match(source,path)
    source=before_shared_snack_bars(source,path)
    source=reverse_manifest(source,path,'branding-settings-palette-manifest.json')
    source=reverse_manifest(source,path,'shared-metric-contrast-manifest.json')
    source=before_shared_text_fields(source,path)
    source=before_shared_scaffolds(source,path)
    source=before_circular_progress(source,path)
    return reverse_manifest(source,path,'shared-control-extensions-manifest.json')
