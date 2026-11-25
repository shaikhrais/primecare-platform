"""Compose exact source receipts when later reviewed migrations touch a library."""
import hashlib
import importlib.util
import json
from pathlib import Path

ROOT=Path(__file__).resolve().parents[1]

def before_mobile_drawer_shadow(source, path):
    source = reverse_presentation_receipt(source, path, 'wide-drawer-account-menu-replay.json')
    source = reverse_presentation_receipt(source, path, 'mobile-drawer-frame-replay.json')
    return reverse_presentation_receipt(source, path, 'mobile-drawer-shadow-replay.json')

def before_mobile_drawer_coverage(source, path):
    source = before_mobile_drawer_shadow(source, path)
    return reverse_presentation_receipt(source, path, 'mobile-drawer-coverage-replay.json')

def before_account_menu_hover_surface(source, path):
    source = before_mobile_drawer_coverage(source, path)
    return reverse_presentation_receipt(source, path, 'account-menu-hover-surface-replay.json')

def before_horizontal_account_geometry(source, path):
    source = before_account_menu_hover_surface(source, path)
    return reverse_presentation_receipt(source, path, 'horizontal-account-geometry-replay.json')

def before_right_sidebar_toggle(source, path):
    source = before_horizontal_account_geometry(source, path)
    return reverse_presentation_receipt(source, path, 'right-sidebar-toggle-replay.json')

def before_shell_chrome(source, path):
    source = before_right_sidebar_toggle(source, path)
    return reverse_presentation_receipt(source, path, 'shell-chrome-replay.json')

def before_account_menu_shadow(source, path):
    source = before_shell_chrome(source, path)
    return reverse_presentation_receipt(source, path, 'account-menu-shadow-replay.json')

def before_account_menu_label_foreground(source, path):
    source = before_account_menu_shadow(source, path)
    return reverse_presentation_receipt(source, path, 'account-menu-label-foreground-replay.json')

def before_account_menu_hover(source, path):
    source = before_account_menu_label_foreground(source, path)
    return reverse_presentation_receipt(source, path, 'account-menu-hover-replay.json')

def before_account_shell_edge(source, path):
    source = before_account_menu_hover(source, path)
    return reverse_presentation_receipt(source, path, 'account-shell-edge-replay.json')

def before_account_trigger_focus_style(source, path):
    source = before_account_shell_edge(source, path)
    return reverse_presentation_receipt(source, path, 'account-trigger-focus-style-replay.json')

def before_compact_shell_geometry(source,path):
    source = before_account_trigger_focus_style(source, path)
    return reverse_presentation_receipt(source,path,'compact-shell-geometry-replay.json')

def before_folded_tabbed_account(source,path):
    source=before_compact_shell_geometry(source,path)
    return reverse_presentation_receipt(source,path,'folded-tabbed-account-replay.json')

def before_neutral_account_capture(source,path):
    source=before_account_menu_hover(source,path)
    return reverse_presentation_receipt(source,path,'neutral-account-capture-replay.json')

def before_account_focus_outline(source,path):
    source=before_folded_tabbed_account(source,path)
    return reverse_presentation_receipt(source,path,'account-focus-outline-replay.json')

def before_unobscured_account_capture(source,path):
    source=before_neutral_account_capture(source,path)
    source=before_account_focus_outline(source,path)
    return reverse_presentation_receipt(source,path,'unobscured-account-capture-replay.json')

def before_account_keyboard(source,path):
    source=before_unobscured_account_capture(source,path)
    return reverse_presentation_receipt(source,path,'account-keyboard-replay.json')

def before_shell_overlay_style(source,path):
    source=before_account_keyboard(source,path)
    return reverse_presentation_receipt(source,path,'shell-overlay-style-replay.json')

def before_account_typography(source,path):
    source=before_shell_overlay_style(source,path)
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

# Reviewed physical relocations retain historical paths in immutable migration receipts.
# Resolve only the exact compatibility shim to its canonical implementation, reversing
# only the import spelling/terminal newline changed during that relocation. All
# subsequent historical digest and round-trip assertions still run unchanged.
_REVIEWED_RELOCATIONS = {
    'advanced_theme/advanced_theme_controller.dart': ('primecare_theme', '', (), False),
    'advanced_theme/advanced_theme_import.dart': ('primecare_theme', '', (), False),
    'advanced_theme/prime_advanced_theme_editor.dart': ('primecare_theme', '', (("../theme/theme_color_codec.dart", "package:flutter_core/theme/theme_color_codec.dart"),), False),
    'theme/portal_section_theme.dart': ('primecare_theme', '', (), False),
    'config/data_source_mode.dart': ('primecare_runtime_config', '', (), False),
    'config/feature_flags.dart': ('primecare_runtime_config', '', (), False),
    'flags/feature_flags.dart': ('primecare_runtime_config', '', (), False),
    'stubs/url_strategy.dart': ('primecare_url_strategy', '', (), False),
    'stubs/url_strategy_stub.dart': ('primecare_url_strategy', '', (), False),
    'stubs/url_strategy_web.dart': ('primecare_url_strategy', '', (), False),
    'network/api_error.dart': ('primecare_api_errors', '', (), False),
    'src/security/device_fingerprint.dart': ('primecare_security_models', '', (), False),
    'src/security/security_event.dart': ('primecare_security_models', '', (), False),
    'src/security/secure_storage_manager.dart': ('primecare_auth_storage', '', (), False),
    'src/utils/auth_storage_stub.dart': ('primecare_auth_storage', '', (), False),
    'src/utils/auth_storage_web.dart': ('primecare_auth_storage', '', (), False),
    'src/utils/auth_storage.dart': ('primecare_auth_storage', '', (), False),
    'src/security/session_watchdog.dart': ('primecare_session_watchdog', '', (("package:primecare_logging/primecare_logging.dart", "../utils/prime_logger.dart"),), False),
    'database/education_database.dart': ('primecare_clinical_education', '', (), False),
    'database/education_database_native.dart': ('primecare_clinical_education', '', (), False),
    'database/education_database_web.dart': ('primecare_clinical_education', '', (), False),
    'providers/clinical_education_provider.dart': ('primecare_clinical_education', '', (("package:primecare_models/src/models/clinical_article.dart", "../models/clinical_article.dart"), ("../database/education_database.dart", "package:flutter_core/database/education_database.dart"),), False),
    'widgets/clinical_article_detail_dialog.dart': ('primecare_clinical_education', '', (("package:primecare_models/src/models/clinical_article.dart", "../models/clinical_article.dart"),), False),
    'widgets/clinical_term_highlighter.dart': ('primecare_clinical_education', '', (), False),
    'database/native_database.dart': ('primecare_local_database', '', (), False),
    'database/native_database_impl.dart': ('primecare_local_database', '', (), False),
    'database/web_database.dart': ('primecare_local_database', '', (), False),
    'database/database.dart': ('primecare_local_database', '', (), False),
    'communications/communication_browser_media_stub.dart': ('primecare_communication_media', '', (("package:primecare_communication_controllers/communications/communication_media.dart", "communication_media.dart"),), False),
    'communications/communication_browser_media_web.dart': ('primecare_communication_media', '', (("package:primecare_communications_transport/communications/communication_core.dart", "communication_core.dart"), ("package:primecare_communication_controllers/communications/communication_media.dart", "communication_media.dart"),), False),
    'communications/communication_browser_media.dart': ('primecare_communication_media', '', (), False),
    'communications/communication_call_controller.dart': ('primecare_communication_controllers', '', (), False),
    'communications/communication_command_controller.dart': ('primecare_communication_controllers', '', (("package:primecare_communications_transport/communications/communication_core.dart", "communication_core.dart"),), False),
    'communications/communication_mail_controller.dart': ('primecare_communication_controllers', '', (), False),
    'communications/communication_media.dart': ('primecare_communication_controllers', '', (("package:primecare_communications_transport/communications/communication_core.dart", "communication_core.dart"),), False),
    'communications/communication_workspace_catalog.dart': ('primecare_communication_controllers', '', (), False),
    'communications/communication_workspace_controller.dart': ('primecare_communication_controllers', '', (("package:primecare_communications_transport/communications/communication_core.dart", "communication_core.dart"),), False),
    'communications/voice_contact_controller.dart': ('primecare_communication_controllers', '', (("package:primecare_communications_transport/communications/communication_core.dart", "communication_core.dart"),), False),
    'communications/registered_communication_bindings.dart': ('primecare_communications_transport', '', (), False),
    'communications/registered_voice_contact_bindings.dart': ('primecare_communications_transport', '', (), False),
    'dashboard_pages/dashboard_read_session.dart': ('primecare_dashboard_pages', '', (("package:primecare_preferences/preference_sync/preference_protocol.dart", "../preference_sync/preference_protocol.dart"),), False),
    'dashboard_pages/prime_dashboard_page.dart': ('primecare_dashboard_pages', '', (), False),
    'dashboard_pages/dashboard_page_model.dart': ('primecare_dashboard_pages', '', (("package:primecare_preferences/preference_sync/preference_protocol.dart", "../preference_sync/preference_protocol.dart"),), False),
    'dashboard_pages/prime_record_page.dart': ('primecare_dashboard_pages', '', (), False),
    'dashboard_pages/record_page_model.dart': ('primecare_dashboard_pages', '', (("package:primecare_preferences/preference_sync/preference_protocol.dart", "../preference_sync/preference_protocol.dart"),), False),
    'providers/persistence_providers.dart': ('primecare_preferences', '', (), False),
    'providers/zoom_provider.dart': ('primecare_preferences', '', (), False),
    'registry/widgets/responsive_split_dashboard.dart': ('primecare_dashboard_native', '', (("package:primecare_layout/config/screen_breakpoints.dart", "../../config/screen_breakpoints.dart"), ("package:primecare_layout/registry/widgets/responsive_grid.dart", "responsive_grid.dart"), ("package:primecare_theme/theme/theme_contrast.dart", "../../theme/theme_contrast.dart"),), False),
    'registry/widgets/responsive_grid.dart': ('primecare_layout', '', (), False),
    'config/screen_breakpoints.dart': ('primecare_layout', '', (), False),
    'config/adaptive_scaling_config.dart': ('primecare_layout', '', (), False),
    'src/utils/prime_logger.dart': ('primecare_logging', '', (), False),
    'network/error_mapper.dart': ('primecare_api_errors', '', (), False),
    'src/network/connectivity_provider.dart': ('primecare_network_status', '', (), False),
    'src/resilience/system_recovery_mode.dart': ('primecare_recovery_ui', '', (("package:primecare_theme/theme/theme_contrast.dart", "package:flutter_core/theme/theme_contrast.dart"),), False),
    'src/localization/localization_scaffold.dart': ('primecare_localization', '', (("package:primecare_theme/theme/prime_semantic_palette.dart", "package:flutter_core/theme/prime_semantic_palette.dart"),), False),
    'src/resilience/restart_wrapper.dart': ('primecare_resilience', '', (), False),
    'src/resilience/provider_ttl.dart': ('primecare_resilience', '', (), False),
    'src/resilience/resilience_service.dart': ('primecare_resilience', '', (), False),
    'src/resilience/system_recovery_manager.dart': ('primecare_resilience', '', (), False),
    'config/resilience_config.dart': ('primecare_resilience', '', (), False),
    'communications/communication_core.dart': ('primecare_communications_transport', '', (), False),
    'communications/dio_communication_transport.dart': ('primecare_communications_transport', '', (), False),
    'communication_modules/registered_module_transport.dart': ('primecare_communication_modules', '', (("package:primecare_communications_transport/communications/dio_communication_transport.dart", "../communications/dio_communication_transport.dart"), ("package:primecare_preferences/preference_sync/preference_protocol.dart", "../preference_sync/preference_protocol.dart"), ("package:primecare_work_contracts/work_modules/work_module_model.dart", "../work_modules/work_module_model.dart"),), False),
    'communication_modules/communication_module_port.dart': ('primecare_communication_modules', '', (("package:primecare_communications_transport/communications/communication_core.dart", "../communications/communication_core.dart"), ("package:primecare_preferences/preference_sync/preference_protocol.dart", "../preference_sync/preference_protocol.dart"), ("package:primecare_work_contracts/work_modules/work_module_model.dart", "../work_modules/work_module_model.dart"), ("package:primecare_work_contracts/work_modules/work_module_session.dart", "../work_modules/work_module_session.dart"),), False),
    'work_modules/prime_work_module.dart': ('primecare_work_modules', '', (("package:primecare_data_controls/primecare_data_controls.dart", "../data_controls.dart"), ("package:primecare_component_factory/component_catalogue/prime_component_catalogue.dart", "../component_catalogue/prime_component_catalogue.dart"),), False),
    'work_modules/tenant_task_transport.dart': ('primecare_task_port', '', (("package:primecare_preferences/preference_sync/preference_protocol.dart", "../preference_sync/preference_protocol.dart"), ("package:primecare_work_contracts/work_modules/work_module_model.dart", "work_module_model.dart"),), False),
    'work_modules/tenant_task_module_port.dart': ('primecare_task_port', '', (("package:primecare_preferences/preference_sync/preference_protocol.dart", "../preference_sync/preference_protocol.dart"), ("package:primecare_work_contracts/work_modules/work_module_model.dart", "work_module_model.dart"), ("package:primecare_work_contracts/work_modules/work_module_session.dart", "work_module_session.dart"),), False),
    'application_modules/application_profile_port.dart': ('primecare_profile', '', (("package:primecare_preferences/preference_sync/preference_protocol.dart", "../preference_sync/preference_protocol.dart"), ("package:primecare_work_contracts/work_modules/work_module_model.dart", "../work_modules/work_module_model.dart"), ("package:primecare_work_contracts/work_modules/work_module_session.dart", "../work_modules/work_module_session.dart"),), False),
    'work_modules/work_module_model.dart': ('primecare_work_contracts', '', (("package:primecare_preferences/preference_sync/preference_protocol.dart", "../preference_sync/preference_protocol.dart"),), False),
    'work_modules/work_module_session.dart': ('primecare_work_contracts', '', (("package:primecare_preferences/preference_sync/preference_protocol.dart", "../preference_sync/preference_protocol.dart"),), False),
    'application_modules/application_shortcut_editor.dart': ('primecare_application_shortcuts', '', (("package:primecare_preferences/preference_sync/preference_sync_client.dart", "../preference_sync/preference_sync_client.dart"), ("package:primecare_work_contracts/work_modules/work_module_model.dart", "../work_modules/work_module_model.dart"),), False),
    'application_modules/application_settings_port.dart': ('primecare_application_shortcuts', '', (("package:primecare_preferences/preference_sync/preference_sync_client.dart", "../preference_sync/preference_sync_client.dart"), ("package:primecare_preferences/preference_sync/preference_adapters.dart", "../preference_sync/preference_adapters.dart"), ("package:primecare_work_contracts/work_modules/work_module_model.dart", "../work_modules/work_module_model.dart"), ("package:primecare_work_contracts/work_modules/work_module_session.dart", "../work_modules/work_module_session.dart"),), False),
    'application_modules/prime_application_shortcuts.dart': ('primecare_application_shortcuts', '', (("package:primecare_shell_utilities/shell_utilities/prime_shell_utilities.dart", "../shell_utilities/prime_shell_utilities.dart"), ("package:primecare_component_factory/component_catalogue/prime_component_catalogue.dart", "../component_catalogue/prime_component_catalogue.dart"),), False),
    'shell_utilities/prime_shell_utilities.dart': ('primecare_shell_utilities', '', (), False),
    'shell_utilities/shell_utilities_model.dart': ('primecare_shell_utilities', '', (), False),
    'shell_utilities/shell_utilities_controller.dart': ('primecare_shell_utilities', '', (("package:primecare_preferences/preference_sync/preference_sync_client.dart", "../preference_sync/preference_sync_client.dart"),), False),
    'page/prime_page_template.dart': ('primecare_page_templates', '', (), False),
    'page/page_template_model.dart': ('primecare_page_templates', '', (("package:primecare_navigation/navigation/workspace_navigation_model.dart", "../navigation/workspace_navigation_model.dart"),), False),
    'theme/theme_color_codec.dart': ('primecare_theme', '', (), False),
    'advanced_theme/advanced_theme_region.dart': ('primecare_theme', '', (("../theme/theme_color_codec.dart", "package:flutter_core/theme/theme_color_codec.dart"),), False),
    'theme/app_theme.dart': ('primecare_theme', '', (), False),
    'theme/theme_center_theme_data.dart': ('primecare_theme', '', (), False),
    'theme/prime_semantic_palette.dart': ('primecare_theme', '', (), False),
    'theme/theme_contrast.dart': ('primecare_theme', '', (), False),
    'component_catalogue/prime_component_catalogue.dart': (
        'primecare_component_factory',
        '// Temporary compatibility export; canonical implementation moved to primecare_component_factory.\n',
        (), True),
    'navigation/prime_workspace_navigation.dart': (
        'primecare_navigation',
        '// Temporary compatibility export; implementation moved to primecare_navigation.\n',
        (("package:primecare_assets/primecare_assets.dart", "../original_assets.dart"),), False),
    'data_controls/prime_data_controls.dart': (
        'primecare_data_controls',
        '// Temporary compatibility export; implementation moved to primecare_data_controls.\n',
        (("package:primecare_assets/primecare_assets.dart", "../original_assets.dart"),
         ("package:primecare_component_factory/primecare_component_factory.dart", "../component_catalogue/prime_component_catalogue.dart")), False),
    'dashboard_widgets/prime_dashboard_widgets.dart': (
        'primecare_dashboard_native', '',
        (("package:primecare_component_factory/component_catalogue/prime_component_catalogue.dart", "../component_catalogue/prime_component_catalogue.dart"),), False),
}



# Exact reviewed appearance changes after package relocation. Replay restores
# the original source only for an exact post-change hash; drift remains visible.
_REVIEWED_RELOCATED_INSETS = {
    'dashboard_pages/prime_dashboard_page.dart': ('28277c0a6197b4ca21f9f902ca8497d1442f29b0d7fc41fcd4c5f197d3050777', 'fe83061754554c649b3141859b44e2b2c83cfb3d63f5a547309e28b3e535c817'),
    'dashboard_pages/prime_record_page.dart': ('9a9efd9dac43ca3f109839496bee2e3057d071365f9a888cccbebdfd303bf1c4', '62a309a8182b48a5428817d78689230c91a74cd62b2871f8a131baa2bd4a4396'),
}

def _before_relocated_insets(source, path):
    receipt = _REVIEWED_RELOCATED_INSETS.get(path)
    if receipt is None:
        return source
    before, after = receipt
    if hashlib.sha256(source.encode()).hexdigest() != after:
        raise AssertionError('Reviewed relocated insets drift: ' + path)
    expected = "import 'package:primecare_ui_foundation/primecare_ui_foundation.dart' show PrimeContentInsets;\n"
    if not source.startswith(expected):
        raise AssertionError('Reviewed relocated insets import drift: ' + path)
    restored = source[len(expected):].replace('PrimeContentInsets.card', 'const EdgeInsets.all(16)').replace('PrimeContentInsets.row', 'const EdgeInsets.symmetric(vertical: 8)')
    if hashlib.sha256(restored.encode()).hexdigest() != before:
        raise AssertionError('Reviewed relocated insets source proof failed: ' + path)
    return restored

def read_reviewed_source(path, root=ROOT):
    source = (root / path).read_text()
    prefix = 'packages/flutter_core/lib/'
    rel = path[len(prefix):] if path.startswith(prefix) else None
    if rel not in _REVIEWED_RELOCATIONS:
        return source
    owner, comment, edits, terminal_newline = _REVIEWED_RELOCATIONS[rel]
    expected = comment + f"export 'package:{owner}/{rel}';\n"
    if source != expected:
        raise AssertionError('Compatibility export drift: ' + path)
    canonical = (root / f'packages/{owner}/lib/{rel}').read_text()
    canonical = _before_relocated_insets(canonical, rel)
    if rel == 'database/web_database.dart':
        if hashlib.sha256(canonical.encode()).hexdigest() != '98a2b5b0b74978b67bb43ca7ee5cdd35c4f979ac0c2fcaf8721d6d8f086e9097':
            raise AssertionError('Reviewed relocated database documentation drift: ' + path)
        canonical = canonical.replace('package:primecare_local_database/database/database.dart', 'package:flutter_core/database/database.dart', 1)
        if hashlib.sha256(canonical.encode()).hexdigest() != '1662570cbf6b60592824273147d7228cb3b9e2a81d307a16c7141e69f4c0019e':
            raise AssertionError('Reviewed relocated database documentation proof failed: ' + path)
    if rel == 'database/education_database.dart':
        if hashlib.sha256(canonical.encode()).hexdigest() != '80e4cb302e7c0c4988b411ff7d8c46d73ee4ae400a434fb85e3c71f1f92a5265':
            raise AssertionError('Reviewed relocated education source drift: ' + path)
        canonical = canonical.replace("import 'package:drift/drift.dart';\n", "import 'package:drift/drift.dart';\nimport 'package:flutter/foundation.dart' show kIsWeb;\n", 1)
        if hashlib.sha256(canonical.encode()).hexdigest() != '3ea80b1b1ce3804ccfb3eb93b167e973e0aaf6c8cb71f3eacd4f57d209f0103b':
            raise AssertionError('Reviewed relocated education source proof failed: ' + path)
    if rel == 'database/education_database_web.dart':
        if hashlib.sha256(canonical.encode()).hexdigest() != 'dd57031afc87a950da5393dcf5ef54cece41a27a059298941afa35b683d54916':
            raise AssertionError('Reviewed relocated education source drift: ' + path)
        canonical = canonical.replace("// Web implementation stub for Drift database (web platforms)\n", "// Web implementation stub for Drift database (web platforms)\nimport 'package:drift/drift.dart';\n", 1)
        if hashlib.sha256(canonical.encode()).hexdigest() != 'add8e1abfcfef9ca0930b9735204216553ef30b19bc2f44c5c3a470878b1a481':
            raise AssertionError('Reviewed relocated education source proof failed: ' + path)
    if rel == 'providers/clinical_education_provider.dart':
        if hashlib.sha256(canonical.encode()).hexdigest() != '8387e6902a654a273f29d7b2f352ecfed397017ff9ebd111fa16f19b9f231e62':
            raise AssertionError('Reviewed relocated education source drift: ' + path)
        canonical = canonical.replace("    final db = await database;\n", "    final db = await database;\n    final searchTerm = '%$query%';\n", 1)
        canonical = canonical.replace("packages/primecare_clinical_education/assets/db/precision_education.json", "packages/flutter_core/assets/db/precision_education.json")
        if hashlib.sha256(canonical.encode()).hexdigest() != '0fdc8f6fc17b6ddb258f7288c772d4a27932985da3ea4026a6cb9eecb3c0d51b':
            raise AssertionError('Reviewed relocated education source proof failed: ' + path)
    if rel == 'communications/communication_browser_media_web.dart':
        if hashlib.sha256(canonical.encode()).hexdigest() != '8e905278d62a731d3c69cce4d0820e7c51e8109822dd78ffa8868dbccfccfd0f':
            raise AssertionError('Reviewed relocated media asset drift: ' + path)
        canonical = canonical.replace('assets/packages/primecare_communication_media/assets/communications/audio-bridge.js', 'assets/packages/flutter_core/assets/communications/audio-bridge.js', 1)
        if hashlib.sha256(canonical.encode()).hexdigest() != 'eb34087ce1047a2544ef06856dfb4bc2d8efcce3811782cb3a3485bdeef81ae8':
            raise AssertionError('Reviewed relocated media asset proof failed: ' + path)
    for new, previous in edits:
        token = "import '" + new + "'"
        if canonical.count(token) != 1:
            raise AssertionError('Reviewed relocation import drift: ' + path)
        canonical = canonical.replace(token, "import '" + previous + "'", 1)
    if terminal_newline:
        if not canonical.endswith('\n\n'):
            raise AssertionError('Reviewed relocation newline drift: ' + path)
        canonical = canonical[:-1]
    return canonical
