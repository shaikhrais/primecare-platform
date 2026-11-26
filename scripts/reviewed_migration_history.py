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
    'application_modules/application_workflow_paths.dart': ('primecare_work_contracts', '', (), False),
    'theme/theme_center_settings_file.dart': ('primecare_theme', '', (("theme_settings_state.dart", "theme_settings_provider.dart"),), False),
    'theme/navbar_style_text_generated.dart': ('primecare_theme', '', (), False),
    'theme/theme_center_text_generated.dart': ('primecare_theme', '', (), False),
    'workspace/portal_workspace.dart': ('primecare_theme', '', (), False),
    'workspace/navbar_scroll_header.dart': ('primecare_layout', '', (), False),
    'workspace/prime_workspace_layout.dart': ('primecare_layout', '', (), False),
    'theme/theme_center_options.dart': ('primecare_theme', '', (), False),
    'theme/theme_center_options_generated.dart': ('primecare_theme', '', (), False),
    'security/shortcuts/shortcut_model.dart': ('primecare_application_shortcuts', '', (), False),
    'network/jwt_decoder.dart': ('primecare_security_models', '', (), False),
    'src/security/app_integrity_service.dart': ('primecare_device_security', '', (("package:primecare_logging/src/utils/prime_logger.dart", "../utils/prime_logger.dart"),), False),
    'src/security/mfa_service.dart': ('primecare_device_security', '', (), False),
    'src/security/screen_shield_service.dart': ('primecare_device_security', '', (("package:primecare_logging/primecare_logging.dart';\nimport 'package:primecare_security_models/primecare_security_models.dart';\nimport 'security_sentinel_service.dart", "package:flutter_core/flutter_core.dart"),), False),
    'src/security/security_orchestrator.dart': ('primecare_device_security', '', (), False),
    'src/security/security_sentinel_service.dart': ('primecare_device_security', '', (("package:primecare_logging/primecare_logging.dart';\nimport 'package:primecare_security_models/primecare_security_models.dart", "package:flutter_core/flutter_core.dart"),), False),
    'src/security/sensitive_action_guard.dart': ('primecare_device_security', '', (("package:flutter_riverpod/flutter_riverpod.dart';\nimport 'package:primecare_logging/primecare_logging.dart';\nimport 'package:primecare_session_watchdog/primecare_session_watchdog.dart';\nimport 'security_orchestrator.dart';\nimport 'mfa_service.dart", "package:flutter_core/flutter_core.dart"),), False),
    'src/security/trusted_device_service.dart': ('primecare_device_security', '', (("package:primecare_security_models/src/security/device_fingerprint.dart", "../security/device_fingerprint.dart"), ("package:primecare_auth_storage/src/security/secure_storage_manager.dart", "../security/secure_storage_manager.dart"),), False),
    'src/domain/platform_hierarchy.dart': ('primecare_governed_hierarchy', '', (("package:primecare_screen_intents/models/screen.dart", "../../models/screen.dart"), ("package:primecare_localization/src/localization/localization_scaffold.dart", "../localization/localization_scaffold.dart"), ("package:primecare_aura/primecare_aura.dart", "../../aura_behavioral_telemetry.dart"), ("package:flutter/material.dart';\nimport 'package:flutter_riverpod/flutter_riverpod.dart", "package:flutter/material.dart';\nimport 'package:flutter_core/flutter_core.dart';\nimport 'package:flutter_riverpod/flutter_riverpod.dart"),), False),
    'routes/governance_navigator.dart': ('primecare_screen_intents', '', (("package:primecare_theme/theme/prime_semantic_palette.dart", "package:flutter_core/theme/prime_semantic_palette.dart"),), False),
    'models/domain_governance.dart': ('primecare_platform_domain', '', (("package:primecare_screen_models/models/navigation_item.dart", "navigation_item.dart"), ("package:primecare_models/src/models/platform_role.dart", "../registry/platform_role.dart"), ("package:primecare_platform_registries/registry/platform_screen_registry.dart", "../registry/platform_screen_registry.dart"), ("package:primecare_route_catalog/routes/groups/common_routes.dart", "../routes/groups/common_routes.dart"), ("package:primecare_screen_intents/models/screen.dart", "screen.dart"),), False),
    'registry/platform_application_registry.dart': ('primecare_platform_domain', '', (("package:primecare_models/src/models/platform_role.dart", "platform_role.dart"),), False),
    'registry/platform_initializer.dart': ('primecare_platform_domain', '', (("../models/domain_governance.dart';\nimport 'platform_application_registry.dart", "../flutter_core.dart"),), False),
    'providers/platform_providers.dart': ('primecare_platform_domain', '', (), False),
    'models/screen_manager.dart': ('primecare_screen_models', '', (("app_shell_boundary.dart", "screen.dart"),), False),
    'manifest/aura_action_manifest.dart': ('primecare_action_feedback', '', (("package:primecare_theme/theme/prime_semantic_palette.dart", "package:flutter_core/theme/prime_semantic_palette.dart"), ("package:flutter/material.dart';\nimport 'package:lucide_icons_flutter/lucide_icons.dart';\nimport 'package:primecare_models/primecare_models.dart", "package:flutter_core/flutter_core.dart"),), False),
    'adapter_providers.dart': ('primecare_demo_dashboard', '', (), False),
    'src/registry/dynamic_adapter_resolver.dart': ('primecare_demo_dashboard', '', (("package:flutter_riverpod/flutter_riverpod.dart';\nimport 'package:primecare_models/primecare_models.dart", "package:flutter_core/flutter_core.dart"),), False),
    'registry/platform_screen_registry.dart': ('primecare_platform_registries', '', (("package:primecare_models/src/models/platform_geometry.dart", "../models/platform_geometry.dart"), ("package:primecare_models/src/models/governance_types.dart", "../models/governance_types.dart"), ("package:primecare_screen_models/models/screen_metadata.dart", "../models/screen_metadata.dart"), ("package:primecare_route_catalog/routes/groups/corporate_routes.dart", "../routes/groups/corporate_routes.dart"), ("package:primecare_route_catalog/routes/groups/franchise_routes.dart", "../routes/groups/franchise_routes.dart"), ("package:primecare_route_catalog/routes/groups/clinical_routes.dart", "../routes/groups/clinical_routes.dart"), ("package:primecare_route_catalog/routes/groups/common_routes.dart", "../routes/groups/common_routes.dart"), ("package:primecare_route_catalog/routes/groups/client_routes.dart", "../routes/groups/client_routes.dart"),), False),
    'registry/role_registry.dart': ('primecare_platform_registries', '', (("package:primecare_models/src/models/platform_role.dart", "platform_role.dart"),), False),
    'registry/governance_registry.dart': ('primecare_governance_registry', '', (("package:primecare_screen_intents/primecare_screen_intents.dart", "intents/app_screen_intent.dart"), ("package:primecare_models/src/models/platform_role.dart", "platform_role.dart"),), False),
    'aura_pulse_service.dart': ('primecare_aura', '', (("package:flutter_riverpod/flutter_riverpod.dart';\nimport 'package:primecare_models/primecare_models.dart';\nimport 'package:primecare_execution_gate/primecare_execution_gate.dart';\nimport 'package:primecare_governance_registry/primecare_governance_registry.dart", "package:flutter_core/flutter_core.dart"),), False),
    'intelligence_providers.dart': ('primecare_intelligence', '', (("package:flutter_riverpod/flutter_riverpod.dart';\nimport 'package:primecare_models/primecare_models.dart';\nimport 'package:primecare_execution_gate/primecare_execution_gate.dart';\nimport 'package:primecare_aura/primecare_aura.dart';\nimport 'package:primecare_data_logistics/primecare_data_logistics.dart';\nimport 'intelligence_service.dart", "package:flutter_core/flutter_core.dart"), ("package:primecare_demo_dashboard/primecare_demo_dashboard.dart", "dashboard_providers.dart"),), False),
    'scheduler_providers.dart': ('primecare_demo_scheduler', '', (("package:flutter_riverpod/flutter_riverpod.dart';\nimport 'package:primecare_models/primecare_models.dart';\nimport 'package:primecare_execution_gate/primecare_execution_gate.dart';\nimport 'package:primecare_aura/primecare_aura.dart';\nimport 'src/services/scheduler_service.dart", "package:flutter_core/flutter_core.dart"),), False),
    'src/resilience/mechanical_repair_kit.dart': ('primecare_resilience', '', (("package:primecare_governance_registry/primecare_governance_registry.dart", "../../registry/governance_registry.dart"),), False),
    'src/resilience/app_error_boundary.dart': ('primecare_recovery_ui', '', (("package:flutter/material.dart';\nimport 'package:flutter_riverpod/flutter_riverpod.dart';\nimport 'package:primecare_execution_gate/primecare_execution_gate.dart';\nimport 'package:primecare_resilience/primecare_resilience.dart';\nimport 'package:primecare_governance_registry/primecare_governance_registry.dart';\nimport 'system_recovery_mode.dart", "package:flutter_core/flutter_core.dart"),), False),
    'aura_providers.dart': ('primecare_aura', '', (("package:flutter_riverpod/flutter_riverpod.dart';\nimport 'package:primecare_models/primecare_models.dart';\nimport 'package:primecare_execution_gate/primecare_execution_gate.dart';\nimport 'aura_command_service.dart';\nimport 'aura_pulse_service.dart", "package:flutter_core/flutter_core.dart"), ("package:primecare_controller_base/primecare_controller_base.dart", "src/controllers/base_value_notifier.dart"),), False),
    'src/services/dashboard_service.dart': ('primecare_demo_dashboard', '', (("package:primecare_models/primecare_models.dart';\nimport 'package:primecare_data_logistics/primecare_data_logistics.dart", "package:flutter_core/flutter_core.dart"),), False),
    'dashboard_providers.dart': ('primecare_demo_dashboard', '', (("package:flutter_riverpod/flutter_riverpod.dart';\nimport 'package:primecare_models/primecare_models.dart';\nimport 'package:primecare_execution_gate/primecare_execution_gate.dart';\nimport 'package:primecare_data_logistics/primecare_data_logistics.dart';\nimport 'package:primecare_logging/primecare_logging.dart';\nimport 'package:primecare_resilience/primecare_resilience.dart';\nimport 'package:primecare_route_catalog/primecare_route_catalog.dart';\nimport 'src/services/dashboard_service.dart", "package:flutter_core/flutter_core.dart"),), False),
    'src/services/scheduler_service.dart': ('primecare_demo_scheduler', '', (("package:primecare_models/primecare_models.dart';\nimport 'package:primecare_execution_gate/primecare_execution_gate.dart';\nimport 'package:primecare_data_logistics/primecare_data_logistics.dart", "package:flutter_core/flutter_core.dart"),), False),
    'src/application/services/preference_service.dart': ('primecare_preferences', '', (("package:flutter_riverpod/flutter_riverpod.dart';\nimport 'package:primecare_models/primecare_models.dart';\nimport 'package:primecare_execution_gate/primecare_execution_gate.dart';\nimport '../../../providers/persistence_providers.dart", "package:flutter_core/flutter_core.dart"), ("package:primecare_guarded_service/primecare_guarded_service.dart", "base_business_service.dart"),), False),
    'intelligence_service.dart': ('primecare_intelligence', '', (("package:primecare_models/primecare_models.dart';\nimport 'package:primecare_execution_gate/primecare_execution_gate.dart", "package:flutter_core/flutter_core.dart"), ("package:primecare_guarded_service/primecare_guarded_service.dart", "src/application/services/base_business_service.dart"),), False),
    'aura_command_service.dart': ('primecare_aura', '', (("package:primecare_models/primecare_models.dart", "package:flutter_core/flutter_core.dart"),), False),
    'src/resilience/execution_gate_service.dart': ('primecare_execution_gate', '', (), False),
    'src/resilience/connectivity_service.dart': ('primecare_network_status', '', (("package:flutter_riverpod/flutter_riverpod.dart';\nimport 'package:primecare_execution_gate/primecare_execution_gate.dart", "package:flutter_core/flutter_core.dart"),), False),
    'src/resilience/resilient_notifier_mixin.dart': ('primecare_resilience', '', (("package:flutter_riverpod/flutter_riverpod.dart';\nimport 'package:primecare_models/primecare_models.dart", "package:flutter_core/flutter_core.dart"),), False),
    'registry/file_registry.dart': ('primecare_screen_registry_data', '', (), False),
    'registry/screen_data_registry.dart': ('primecare_screen_registry_data', '', (), False),
    'registry/intents/app_screen_intent.dart': ('primecare_screen_intents', '', (("package:primecare_models/src/models/platform_role.dart", "../platform_role.dart"), ("package:primecare_models/src/models/platform_types.dart", "../../models/platform_types.dart"),), False),
    'registry/widgets/governance_skeleton.dart': ('primecare_screen_intents', '', (), False),
    'providers/user_management_provider.dart': ('primecare_demo_user_management', '', (), False),
    'src/services/device_manager.dart': ('primecare_device_identity', '', (("package:primecare_security_models/src/security/device_fingerprint.dart", "../security/device_fingerprint.dart"),), False),
    'models/presentation_mode.dart': ('primecare_presentation_preview', '', (("package:primecare_theme/theme/prime_semantic_palette.dart", "../theme/prime_semantic_palette.dart"),), False),
    'routes/groups/admin_routes.dart': ('primecare_route_catalog', '', (), False),
    'routes/groups/business_development_routes.dart': ('primecare_route_catalog', '', (), False),
    'routes/groups/client_routes.dart': ('primecare_route_catalog', '', (), False),
    'routes/groups/clinical_routes.dart': ('primecare_route_catalog', '', (), False),
    'routes/groups/common_routes.dart': ('primecare_route_catalog', '', (), False),
    'routes/groups/corporate_routes.dart': ('primecare_route_catalog', '', (), False),
    'routes/groups/franchise_routes.dart': ('primecare_route_catalog', '', (), False),
    'routes/groups/marketing_routes.dart': ('primecare_route_catalog', '', (), False),
    'routes/groups/office_routes.dart': ('primecare_route_catalog', '', (), False),
    'routes/groups/regional_finance_routes.dart': ('primecare_route_catalog', '', (), False),
    'routes/groups/support_routes.dart': ('primecare_route_catalog', '', (), False),
    'routes/safe_navigation.dart': ('primecare_navigation', '', (), False),
    'governance/parity_engine.dart': ('primecare_governance_validation', '', (("package:primecare_models/src/models/api_metadata.dart", "../models/api_metadata.dart"), ("package:primecare_screen_models/models/screen_metadata.dart", "../models/screen_metadata.dart"),), False),
    'governance/registry_scanner.dart': ('primecare_governance_validation', '', (("package:primecare_models/src/models/api_metadata.dart", "../models/api_metadata.dart"),), False),
    'governance/governance_bridge.dart': ('primecare_governance_validation', '', (("package:primecare_models/src/models/api_metadata.dart", "../models/api_metadata.dart"),), False),
    'testing/governance_models.dart': ('primecare_governance_reports', '', (), False),
    'testing/governance_html_reporter.dart': ('primecare_governance_reports', '', (), False),
    'src/application/services/data_logistics_hub.dart': ('primecare_data_logistics', '', (), False),
    'stubs/common_feature_stub.dart': ('primecare_feature_stub', '', (), False),
    'src/services/telemetry_service.dart': ('primecare_demo_telemetry', '', (), False),
    'registry/widgets/responsive_screen_wrapper.dart': ('primecare_responsive_screen', '', (("package:primecare_layout/config/screen_breakpoints.dart", "../../config/screen_breakpoints.dart"), ("package:primecare_layout/config/adaptive_scaling_config.dart", "../../config/adaptive_scaling_config.dart"), ("package:primecare_preferences/providers/zoom_provider.dart", "../../providers/zoom_provider.dart"),), False),
    'manifest/action_manifest.dart': ('primecare_action_feedback', '', (("package:primecare_theme/theme/prime_semantic_palette.dart", "package:flutter_core/theme/prime_semantic_palette.dart"),), False),
    'theme/prime_palette_editor.dart': ('primecare_theme', '', (), False),
    'models/navigation_item.dart': ('primecare_screen_models', '', (), False),
    'models/screen_metadata.dart': ('primecare_screen_models', '', (("package:primecare_models/src/models/governance_types.dart", "governance_types.dart"), ("package:primecare_models/src/models/platform_geometry.dart", "platform_geometry.dart"),), False),
    'models/screen_features.dart': ('primecare_screen_models', '', (), False),
    'src/controllers/base_scaffold_controller.dart': ('primecare_controller_base', '', (), False),
    'src/controllers/base_value_notifier.dart': ('primecare_controller_base', '', (), False),
    'engine/form_schema_engine.dart': ('primecare_form_schema', '', (), False),
    'src/network/local_cache_service.dart': ('primecare_local_cache', '', (("package:primecare_preferences/providers/persistence_providers.dart", "../../providers/persistence_providers.dart"),), False),
    'config/offline_fallback_state.dart': ('primecare_runtime_config', '', (), False),
    'theme/prime_shell_metrics.dart': ('primecare_theme', '', (), False),
    'theme/prime_theme_center_style.dart': ('primecare_theme', '', (), False),
    'theme/prime_account_trigger_focus_frame.dart': ('primecare_theme', '', (), False),
    'theme/prime_toolbar_account_frame.dart': ('primecare_theme', '', (), False),
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

_THEME_OWNER_TOKEN_RECEIPTS = {
    "models/presentation_mode.dart": {
        "before": "409d6f39383e5e716bbb4e3b67be0aa01c2470ca58084dfb16e6b699da740de8",
        "after": "2fb82391f51d1746ef905ef26d5558a20986ec1bdd8b97e99b352e2ec003b08c",
        "edits": [["child: Semantics(label: title, child: bodyContent),", "child: bodyContent,", 1]],
    },
    "theme/prime_shell_metrics.dart": {
        "before": "c1790ef30142c14f939f01a76200c78407d734b94aa8e42cd3fa8c9050784cf3",
        "after": "dbff2f200150a06373a3de2ffbe67d7d303ebee77f5216051b3d227d3967779a",
        "edits": [
            [
                "import 'theme_color_codec.dart';\n",
                "",
                1
            ],
            [
                "PrimeReferenceColors.transparent",
                "Colors.transparent",
                1
            ],
            [
                "PrimeReferenceColors.white",
                "Colors.white",
                4
            ],
            [
                "PrimeReferenceColors.black",
                "Colors.black",
                2
            ],
            [
                "PrimeReferenceColors.flagUsNavy",
                "Color(0xff3c3b6e)",
                1
            ],
            [
                "PrimeReferenceColors.flagUsRed",
                "Color(0xffb22234)",
                1
            ],
            [
                "PrimeReferenceColors.flagFrenchBlue",
                "Color(0xff0055a4)",
                1
            ],
            [
                "PrimeReferenceColors.flagFrenchRed",
                "Color(0xffef4135)",
                1
            ],
            [
                "PrimeReferenceColors.flagSpanishRed",
                "Color(0xffaa151b)",
                1
            ],
            [
                "PrimeReferenceColors.flagSpanishYellow",
                "Color(0xfff1bf00)",
                1
            ],
            [
                "PrimeReferenceColors.drawerScrim",
                "Color(0x80000000)",
                1
            ],
            [
                "PrimeReferenceColors.drawerShadowNear",
                "Color(0x21000000)",
                1
            ],
            [
                "PrimeReferenceColors.drawerShadowFar",
                "Color(0x1C000000)",
                1
            ],
            [
                "PrimeReferenceColors.accountMenuShadow",
                "Color(0x66000000)",
                1
            ],
            [
                "PrimeReferenceColors.accountMenuLightShadow",
                "const Color(0x7A000000)",
                1
            ],
            [
                "PrimeReferenceColors.accountLightOutline",
                "const Color(0xffd1d5db)",
                1
            ],
            [
                "PrimeReferenceColors.fromArgb(",
                "Color.fromARGB(",
                2
            ]
        ]
    },
    "theme/prime_theme_center_style.dart": {
        "before": "7f007be81e7082671e4bcb4b6eb93fabd5209a11f43ad6a3f2e9e3a34a950522",
        "after": "923aec8758f964879d9f24a42dc164e7a55b0724994d55c6c197284b6640936e",
        "edits": [
            [
                "import 'package:primecare_ui_foundation/primecare_ui_foundation.dart' show PrimeFilledButton, PrimeTextButton, PrimeOutlinedButton;\nimport 'theme_color_codec.dart';\n",
                "",
                1
            ],
            [
                "PrimeReferenceColors.white",
                "Colors.white",
                2
            ],
            [
                "PrimeReferenceColors.black",
                "Colors.black",
                2
            ],
            [
                "PrimeFilledButton.styleFrom",
                "FilledButton.styleFrom",
                1
            ],
            [
                "PrimeTextButton.styleFrom",
                "TextButton.styleFrom",
                1
            ],
            [
                "PrimeOutlinedButton.styleFrom",
                "OutlinedButton.styleFrom",
                1
            ]
        ]
    },
    "theme/prime_palette_editor.dart": {
        "before": "6a92512c1c309025b35f734ca655a9684cdb8bb83a8201708af1190b96a34d82",
        "after": "0de536d7a81e027298b3ea4800815fc52fa55c83a7debd3a10717305f53f1d49",
        "edits": [
            [
                "import 'theme_color_codec.dart';\n",
                "",
                1
            ],
            [
                "themeHexColor(text)",
                "Color(int.parse(text.substring(1),radix:16)|0xff000000)",
                1
            ],
            [
                "PrimeReferenceColors.white",
                "Colors.white",
                1
            ],
            [
                "PrimeReferenceColors.fromArgb(",
                "Color.fromARGB(",
                1
            ]
        ]
    },
    "theme/theme_color_codec.dart": {
        "before": "b6a1388965fdbcdea36afcad8d6d850dd98636e41b9f1478a5b9d04fa3b9dbc7",
        "after": "782f8d49eae4ca90d0f0e99cc2c8a0621ff9ed5b41cb510d0f0bb50f041986db",
        "edits": [
            [
                "\n// Shared fixed reference color tokens for shell and palette controls.\nabstract final class PrimeReferenceColors {\n  static const transparent = Colors.transparent;\n  static const white = Colors.white;\n  static const black = Colors.black;\n  static const flagUsNavy = Color(0xff3c3b6e);\n  static const flagUsRed = Color(0xffb22234);\n  static const flagFrenchBlue = Color(0xff0055a4);\n  static const flagFrenchRed = Color(0xffef4135);\n  static const flagSpanishRed = Color(0xffaa151b);\n  static const flagSpanishYellow = Color(0xfff1bf00);\n  static const drawerScrim = Color(0x80000000);\n  static const drawerShadowNear = Color(0x21000000);\n  static const drawerShadowFar = Color(0x1C000000);\n  static const accountMenuShadow = Color(0x66000000);\n  static const accountMenuLightShadow = Color(0x7A000000);\n  static const accountLightOutline = Color(0xffd1d5db);\n\n  static Color fromArgb(int alpha, int red, int green, int blue) =>\n      Color.fromARGB(alpha, red, green, blue);\n}\n",
                "",
                1
            ]
        ]
    }
}

def _before_theme_owner_tokens(canonical, rel):
    receipt = _THEME_OWNER_TOKEN_RECEIPTS.get(rel)
    if receipt is None:
        return canonical
    if hashlib.sha256(canonical.encode()).hexdigest() != receipt['after']:
        raise AssertionError('Reviewed theme token source drift: ' + rel)
    for new, previous, count in reversed(receipt['edits']):
        if canonical.count(new) != count:
            raise AssertionError('Reviewed theme token substitution drift: ' + rel)
        canonical = canonical.replace(new, previous)
    if hashlib.sha256(canonical.encode()).hexdigest() != receipt['before']:
        raise AssertionError('Reviewed theme token proof failed: ' + rel)
    return canonical

def read_reviewed_source(path, root=ROOT):
    source = (root / path).read_text()
    prefix = 'packages/flutter_core/lib/'
    rel = path[len(prefix):] if path.startswith(prefix) else None
    if rel == 'models/screen.dart':
        if source != "export 'package:primecare_screen_intents/models/screen.dart';\n":
            raise AssertionError('Reviewed screen compatibility export drift: ' + path)
        source = (root / 'packages/primecare_screen_intents/lib/models/screen.dart').read_text()
        if source.count("export 'package:primecare_screen_models/models/screen_features.dart';") != 1:
            raise AssertionError('Reviewed screen import relocation drift: ' + path)
        source = source.replace("export 'package:primecare_screen_models/models/screen_features.dart';", "export 'screen_features.dart';", 1)
        if source.count("import 'package:primecare_screen_models/models/screen_features.dart';") != 1:
            raise AssertionError('Reviewed screen import relocation drift: ' + path)
        source = source.replace("import 'package:primecare_screen_models/models/screen_features.dart';", "import 'screen_features.dart';", 1)
        if source.count("import 'package:primecare_presentation_preview/models/presentation_mode.dart';") != 1:
            raise AssertionError('Reviewed screen import relocation drift: ' + path)
        source = source.replace("import 'package:primecare_presentation_preview/models/presentation_mode.dart';", "import 'presentation_mode.dart';", 1)
        if source.count("import 'package:primecare_responsive_screen/registry/widgets/responsive_screen_wrapper.dart';") != 1:
            raise AssertionError('Reviewed screen import relocation drift: ' + path)
        source = source.replace("import 'package:primecare_responsive_screen/registry/widgets/responsive_screen_wrapper.dart';", "import '../registry/widgets/responsive_screen_wrapper.dart';", 1)
        if source.count("import 'package:primecare_models/src/models/platform_types.dart';") != 1:
            raise AssertionError('Reviewed screen import relocation drift: ' + path)
        source = source.replace("import 'package:primecare_models/src/models/platform_types.dart';", "import 'platform_types.dart';", 1)
        if source.count("import '../registry/intents/app_screen_intent.dart';") != 1:
            raise AssertionError('Reviewed screen import relocation drift: ' + path)
        source = source.replace("import '../registry/intents/app_screen_intent.dart';", "import 'package:flutter_core/flutter_core.dart';\nimport '../registry/intents/app_screen_intent.dart';", 1)
        if source.count("import 'package:primecare_models/src/models/platform_role.dart';") != 1:
            raise AssertionError('Reviewed screen import relocation drift: ' + path)
        source = source.replace("import 'package:primecare_models/src/models/platform_role.dart';", "import '../registry/platform_role.dart';", 1)
        boundary = (root / 'packages/primecare_screen_models/lib/models/app_shell_boundary.dart').read_text()
        if hashlib.sha256(source.encode()).hexdigest() != '2f4ecc9a22baff3984d54a6879cefec4549b31a939d0c4eb554bdcdf9bbb6f77' or hashlib.sha256(boundary.encode()).hexdigest() != '918e470ad05f5f3cab6944817009c8cfa1072e1e6a748432b0014ffe1a24a063':
            raise AssertionError('Reviewed screen boundary split drift: ' + path)
        source = source.replace("import 'package:primecare_screen_models/models/app_shell_boundary.dart';\nexport 'package:primecare_screen_models/models/app_shell_boundary.dart';\n", '', 1)
        source = source.replace('/// The unified, high-fidelity definition of a PrimeCare screen.', boundary.removeprefix("import 'package:flutter/material.dart';\n\n") + '/// The unified, high-fidelity definition of a PrimeCare screen.', 1)
        if hashlib.sha256(source.encode()).hexdigest() != 'fbb7eeffc1d5076f10a0324d2e7e2a5e8cdcd970313985f503c338b4a320131d':
            raise AssertionError('Reviewed screen boundary reconstruction failed: ' + path)
        return source
    theme_binding_relocations = {"theme/theme_settings_provider.dart":["// Legacy composition retains the existing authenticated provider identity.\nimport 'package:flutter_riverpod/flutter_riverpod.dart';\nimport 'package:primecare_models/src/models/auth_state.dart';\nimport 'package:primecare_theme_preferences/theme/theme_settings_provider.dart';\nimport '../auth_service.dart' show authProvider;\nexport 'package:primecare_theme_preferences/theme/theme_settings_provider.dart';\nimport 'package:primecare_theme/theme/theme_settings_state.dart';\n\nclass ThemeSettingsNotifier extends ThemeSettingsNotifierBase {\n  @override AuthState watchThemeAccount() => ref.watch(authProvider);\n  @override AuthState readThemeAccount() => ref.read(authProvider);\n}\nfinal themeSettingsProvider=NotifierProvider<ThemeSettingsNotifier,ThemeSettingsState>(ThemeSettingsNotifier.new);\n",[["import '../auth_service.dart';","import 'package:primecare_models/src/models/auth_state.dart';"],["import '../providers/persistence_providers.dart';","import 'package:primecare_preferences/providers/persistence_providers.dart';"],["import 'personal_theme.dart';","import 'package:primecare_theme/theme/personal_theme.dart';"],["import 'theme_center_catalog_generated.dart';","import 'package:primecare_theme/theme/theme_center_catalog_generated.dart';"],["themeAccountScope(ref.read(authProvider))","themeAccountScope(readThemeAccount())"],["final auth=ref.watch(authProvider);","final auth=watchThemeAccount();"],["class ThemeSettingsNotifier extends Notifier<ThemeSettingsState> {","abstract class ThemeSettingsNotifierBase extends Notifier<ThemeSettingsState> {\n  AuthState watchThemeAccount();\n  AuthState readThemeAccount();"],["final ThemeSettingsNotifier _owner;","final ThemeSettingsNotifierBase _owner;"],["final themeSettingsProvider=NotifierProvider<ThemeSettingsNotifier,ThemeSettingsState>(ThemeSettingsNotifier.new);\n","\n/* Host composition owns the provider identity. */\n"]]],"theme/theme_library_provider.dart":["// Legacy composition retains the existing authenticated provider identity.\nimport 'package:flutter_riverpod/flutter_riverpod.dart';\nimport 'package:primecare_models/src/models/auth_state.dart';\nimport 'package:primecare_theme_preferences/theme/theme_library_provider.dart';\nimport '../auth_service.dart' show authProvider;\nexport 'package:primecare_theme_preferences/theme/theme_library_provider.dart';\n\nclass ThemeLibraryNotifier extends ThemeLibraryNotifierBase {\n  @override AuthState watchThemeAccount() => ref.watch(authProvider);\n  @override AuthState readThemeAccount() => ref.read(authProvider);\n}\nfinal themeLibraryProvider=NotifierProvider<ThemeLibraryNotifier,List<SavedPersonalTheme>>(ThemeLibraryNotifier.new);\n",[["import '../auth_service.dart';","import 'package:primecare_models/src/models/auth_state.dart';"],["import '../providers/persistence_providers.dart';","import 'package:primecare_preferences/providers/persistence_providers.dart';"],["import 'personal_theme.dart';","import 'package:primecare_theme/theme/personal_theme.dart';"],["import 'theme_settings_provider.dart';","import 'theme_settings_provider.dart';"],["themeAccountScope(ref.read(authProvider))","themeAccountScope(readThemeAccount())"],["final auth=ref.watch(authProvider);","final auth=watchThemeAccount();"],["class ThemeLibraryNotifier extends Notifier<List<SavedPersonalTheme>> {","abstract class ThemeLibraryNotifierBase extends Notifier<List<SavedPersonalTheme>> {\n  AuthState watchThemeAccount();\n  AuthState readThemeAccount();"],["final ThemeLibraryNotifier _owner;","final ThemeLibraryNotifierBase _owner;"],["final themeLibraryProvider=NotifierProvider<ThemeLibraryNotifier,List<SavedPersonalTheme>>(ThemeLibraryNotifier.new);\n","\n/* Host composition owns the provider identity. */\n"]]]}
    theme_binding_relocations['theme/theme_center_complete_panel.dart'] = ["// Legacy composition retains the authenticated provider bindings.\nimport 'package:flutter_riverpod/flutter_riverpod.dart';\nimport 'package:primecare_models/src/models/auth_state.dart';\nimport 'package:primecare_theme_preferences/theme/theme_center_complete_panel.dart';\nimport '../auth_service.dart' show authProvider;\nimport 'theme_settings_provider.dart';\n\nclass ThemeCenterCompletePanel extends ThemeCenterCompletePanelBase {\n  const ThemeCenterCompletePanel({super.key,super.actionsOnly=false});\n  @override AuthState watchAccount(WidgetRef ref) => ref.watch(authProvider);\n  @override AuthState readAccount(WidgetRef ref) => ref.read(authProvider);\n  @override ThemeSettingsState watchSettings(WidgetRef ref) => ref.watch(themeSettingsProvider);\n  @override ThemeSettingsState readSettings(WidgetRef ref) => ref.read(themeSettingsProvider);\n  @override ThemeSettingsNotifierBase readNotifier(WidgetRef ref) => ref.read(themeSettingsProvider.notifier);\n}\n",[["import '../auth_service.dart' show authProvider;","import 'package:primecare_models/src/models/auth_state.dart';"],["import '../providers/persistence_providers.dart';","import 'package:primecare_preferences/providers/persistence_providers.dart';"],["import '../workspace/portal_workspace.dart';","import 'package:primecare_theme/workspace/portal_workspace.dart';"],["import '../workspace/workspace_files.dart';","import 'package:primecare_layout/workspace/workspace_files.dart';"],["import 'personal_theme.dart';","import 'package:primecare_theme/theme/personal_theme.dart';"],["import 'theme_center_catalog_generated.dart';","import 'package:primecare_theme/theme/theme_center_catalog_generated.dart';"],["import 'theme_center_settings_file.dart';","import 'package:primecare_theme/theme/theme_center_settings_file.dart';"],["class ThemeCenterCompletePanel extends ConsumerWidget {\n  final bool actionsOnly;\n  const ThemeCenterCompletePanel({super.key,this.actionsOnly=false});","abstract class ThemeCenterCompletePanelBase extends ConsumerWidget {\n  final bool actionsOnly;\n  const ThemeCenterCompletePanelBase({super.key,this.actionsOnly=false});\n  AuthState watchAccount(WidgetRef ref);\n  AuthState readAccount(WidgetRef ref);\n  ThemeSettingsState watchSettings(WidgetRef ref);\n  ThemeSettingsState readSettings(WidgetRef ref);\n  ThemeSettingsNotifierBase readNotifier(WidgetRef ref);"],["ref.watch(authProvider)","watchAccount(ref)"],["ref.read(authProvider)","readAccount(ref)"],["ref.watch(themeSettingsProvider)","watchSettings(ref)"],["ref.read(themeSettingsProvider)","readSettings(ref)"],["ref.read(themeSettingsProvider.notifier)","readNotifier(ref)"]]]
    if rel == 'registry/widgets/theme_center_panel.dart':
        shim, edits = ["// Legacy composition retains live localization and account provider identities.\nimport 'package:flutter/material.dart';\nimport 'package:flutter_riverpod/flutter_riverpod.dart';\nimport 'package:primecare_theme_preferences/theme/theme_center_panel.dart';\nimport '../../src/localization/live_screen_text.dart';\nimport '../../theme/theme_library_provider.dart';\nimport '../../theme/theme_settings_provider.dart';\n\nString themeCenterText(BuildContext context,String key,{Map<String,String> args=const {}}) =>\n  resolvedThemeCenterText(liveScreenText,context,key,args:args);\n\nclass PrimeToolbarTextScale extends PrimeToolbarTextScaleBase {\n  const PrimeToolbarTextScale({super.key,required super.foreground});\n  @override String themeCenterText(BuildContext context,String key,{Map<String,String> args=const {}}) => resolvedThemeCenterText(liveScreenText,context,key,args:args);\n  @override ThemeSettingsState watchSettings(WidgetRef ref) => ref.watch(themeSettingsProvider);\n  @override PersonalThemeSettingsSession bindSettings(WidgetRef ref) => ref.read(themeSettingsProvider.notifier).bindAccount();\n}\n\nclass ThemeCenterPanel extends ThemeCenterPanelBase {\n  const ThemeCenterPanel({super.key});\n  @override String themeCenterText(BuildContext context,String key,{Map<String,String> args=const {}}) => resolvedThemeCenterText(liveScreenText,context,key,args:args);\n  @override ThemeSettingsState watchSettings(WidgetRef ref) => ref.watch(themeSettingsProvider);\n  @override List<SavedPersonalTheme> watchLibrary(WidgetRef ref) => ref.watch(themeLibraryProvider);\n  @override PersonalThemeSettingsSession bindSettings(WidgetRef ref) => ref.read(themeSettingsProvider.notifier).bindAccount();\n  @override ThemeLibrarySession bindLibrary(WidgetRef ref) => ref.read(themeLibraryProvider.notifier).bindAccount();\n}\n",[["import '../../src/localization/live_screen_text.dart';import '../../theme/theme_center_text_generated.dart';","import 'package:primecare_theme/theme/theme_center_text_generated.dart';"],["import '../../theme/theme_center_options_generated.dart';","import 'package:primecare_theme/theme/theme_center_options_generated.dart';"],["import '../../theme/personal_theme.dart';import '../../theme/theme_center_catalog_generated.dart';import '../../theme/theme_library_provider.dart';import '../../theme/theme_settings_provider.dart';","import 'package:primecare_theme/theme/personal_theme.dart';import 'package:primecare_theme/theme/theme_center_catalog_generated.dart';import 'theme_library_provider.dart';import 'theme_settings_provider.dart';"],["String themeCenterText(BuildContext context,String key,{Map<String,String> args=const {}}) {","typedef ThemeCenterLiveText = String Function(BuildContext context,String screen,String language,String key,String fallback,{required Map<String,String> args});\nString resolvedThemeCenterText(ThemeCenterLiveText liveScreenText,BuildContext context,String key,{Map<String,String> args=const {}}) {"],["class PrimeToolbarTextScale extends ConsumerWidget {\n  final Color foreground;\n  const PrimeToolbarTextScale({super.key, required this.foreground});","abstract class PrimeToolbarTextScaleBase extends ConsumerWidget {\n  final Color foreground;\n  const PrimeToolbarTextScaleBase({super.key, required this.foreground});\n  String themeCenterText(BuildContext context,String key,{Map<String,String> args=const {}});\n  ThemeSettingsState watchSettings(WidgetRef ref);\n  PersonalThemeSettingsSession bindSettings(WidgetRef ref);"],["class ThemeCenterPanel extends ConsumerWidget {\n const ThemeCenterPanel({super.key});","abstract class ThemeCenterPanelBase extends ConsumerWidget {\n const ThemeCenterPanelBase({super.key});\n String themeCenterText(BuildContext context,String key,{Map<String,String> args=const {}});\n ThemeSettingsState watchSettings(WidgetRef ref);\n List<SavedPersonalTheme> watchLibrary(WidgetRef ref);\n PersonalThemeSettingsSession bindSettings(WidgetRef ref);\n ThemeLibrarySession bindLibrary(WidgetRef ref);"],["final current = ref.watch(themeSettingsProvider).theme.fontScale;","final current = watchSettings(ref).theme.fontScale;"],["final account = ref.read(themeSettingsProvider.notifier).bindAccount();","final account = bindSettings(ref);"],["final current=ref.watch(themeSettingsProvider).theme,items=ref.watch(themeLibraryProvider);final settings=ref.read(themeSettingsProvider.notifier).bindAccount(),library=ref.read(themeLibraryProvider.notifier).bindAccount();","final current=watchSettings(ref).theme,items=watchLibrary(ref);final settings=bindSettings(ref),library=bindLibrary(ref);"]]]
        if source != shim:
            raise AssertionError('Theme panel composition drift: ' + path)
        source = (root / 'packages/primecare_theme_preferences/lib/theme/theme_center_panel.dart').read_text()
        for previous, current in reversed(edits):
            if source.count(current) != 1:
                raise AssertionError('Theme panel relocation drift: ' + path)
            source = source.replace(current, previous, 1)
        return source
    if rel == 'registry/widgets/theme_settings_drawer.dart':
        shim, edits = ["// Legacy composition supplies the existing Theme Center widget.\nimport 'package:flutter/material.dart';\nimport 'package:primecare_theme_preferences/theme/theme_settings_drawer.dart';\nimport '../../theme/prime_theme_center.dart';\n\nclass ThemeSettingsDrawer extends ThemeSettingsDrawerBase {\n  const ThemeSettingsDrawer({super.key,required super.tenantDefaultPreset});\n  @override Widget buildThemeCenter(String tenantDefaultPreset) => PrimeThemeCenter(tenantDefaultPreset:tenantDefaultPreset);\n}\n",[["class ThemeSettingsDrawer extends StatelessWidget {\n  final String tenantDefaultPreset;\n  const ThemeSettingsDrawer({super.key,required this.tenantDefaultPreset});","abstract class ThemeSettingsDrawerBase extends StatelessWidget {\n  final String tenantDefaultPreset;\n  const ThemeSettingsDrawerBase({super.key,required this.tenantDefaultPreset});\n  Widget buildThemeCenter(String tenantDefaultPreset);"],["PrimeThemeCenter(tenantDefaultPreset:tenantDefaultPreset)","buildThemeCenter(tenantDefaultPreset)"]]]
        if source != shim:
            raise AssertionError('Theme drawer composition drift: ' + path)
        source = (root / 'packages/primecare_theme_preferences/lib/theme/theme_settings_drawer.dart').read_text()
        for previous, current in reversed(edits):
            if source.count(current) != 1:
                raise AssertionError('Theme drawer relocation drift: ' + path)
            source = source.replace(current, previous, 1)
        return source.replace("import 'package:flutter/material.dart';\n", "import 'package:flutter/material.dart';\nimport '../../theme/prime_theme_center.dart';\n", 1)
    if rel == 'theme/prime_theme_center.dart':
        shim, edits = ["// Legacy composition retains the account provider and Theme Center child bindings.\nimport 'package:flutter/material.dart';\nimport 'package:flutter_riverpod/flutter_riverpod.dart';\nimport 'package:primecare_models/src/models/auth_state.dart';\nimport 'package:primecare_theme_preferences/theme/prime_theme_center.dart';\nimport '../auth_service.dart' show authProvider;\nimport '../registry/widgets/theme_center_panel.dart';\nimport 'theme_center_complete_panel.dart';\nimport 'theme_settings_provider.dart';\nexport 'package:primecare_theme_preferences/theme/prime_theme_center.dart' show PrimeSettingsGroup, PrimeSettingsChoices, PrimeSettingsNumber;\n\nclass PrimeThemeCenter extends PrimeThemeCenterBase {\n  const PrimeThemeCenter({super.key,required super.tenantDefaultPreset});\n  @override AuthState watchAccount(WidgetRef ref) => ref.watch(authProvider);\n  @override AuthState readAccount(WidgetRef ref) => ref.read(authProvider);\n  @override ThemeSettingsState watchSettings(WidgetRef ref) => ref.watch(themeSettingsProvider);\n  @override ThemeSettingsNotifierBase readNotifier(WidgetRef ref) => ref.read(themeSettingsProvider.notifier);\n  @override Widget completePanel() => const ThemeCenterCompletePanel(actionsOnly:true);\n  @override Widget savedPanel() => const ThemeCenterPanel();\n}\n",[["import 'dart:math' as math;\nimport 'package:flutter/material.dart';\nimport 'package:flutter_riverpod/flutter_riverpod.dart';\nimport 'package:primecare_ui_foundation/primecare_ui_foundation.dart';\nimport '../auth_service.dart' show authProvider;\nimport '../providers/persistence_providers.dart';\nimport '../registry/widgets/theme_center_panel.dart';\nimport '../workspace/portal_workspace.dart';\nimport 'personal_theme.dart';\nimport 'navbar_style_text_generated.dart';\nimport 'prime_palette_editor.dart';\nimport 'prime_theme_center_style.dart';\nimport 'prime_shell_metrics.dart';\nimport 'theme_center_catalog_generated.dart';\nimport 'theme_center_complete_panel.dart';\nimport 'theme_center_settings_file.dart';\nimport 'theme_settings_provider.dart';\n\n","import 'dart:math' as math;\nimport 'package:flutter/material.dart';\nimport 'package:flutter_riverpod/flutter_riverpod.dart';\nimport 'package:primecare_ui_foundation/primecare_ui_foundation.dart';\nimport 'package:primecare_models/src/models/auth_state.dart';\nimport 'package:primecare_preferences/providers/persistence_providers.dart';\nimport 'package:primecare_theme/workspace/portal_workspace.dart';\nimport 'package:primecare_theme/theme/personal_theme.dart';\nimport 'package:primecare_theme/theme/navbar_style_text_generated.dart';\nimport 'package:primecare_theme/theme/prime_palette_editor.dart';\nimport 'package:primecare_theme/theme/prime_theme_center_style.dart';\nimport 'package:primecare_theme/theme/prime_shell_metrics.dart';\nimport 'package:primecare_theme/theme/theme_center_catalog_generated.dart';\nimport 'package:primecare_theme/theme/theme_center_settings_file.dart';\nimport 'theme_settings_provider.dart';\n\n",1],["class PrimeThemeCenter extends ConsumerWidget {\n  final String tenantDefaultPreset;\n  const PrimeThemeCenter({super.key,required this.tenantDefaultPreset});","abstract class PrimeThemeCenterBase extends ConsumerWidget {\n  final String tenantDefaultPreset;\n  const PrimeThemeCenterBase({super.key,required this.tenantDefaultPreset});\n  AuthState watchAccount(WidgetRef ref);\n  AuthState readAccount(WidgetRef ref);\n  ThemeSettingsState watchSettings(WidgetRef ref);\n  ThemeSettingsNotifierBase readNotifier(WidgetRef ref);\n  Widget completePanel();\n  Widget savedPanel();",1],["ref.watch(themeSettingsProvider)","watchSettings(ref)",2],["ref.read(themeSettingsProvider.notifier)","readNotifier(ref)",1],["ref.watch(authProvider)","watchAccount(ref)",1],["ref.read(authProvider)","readAccount(ref)",8],["children:[const ThemeCenterCompletePanel(actionsOnly:true),","children:[completePanel(),",1],["const ExpansionTile(title:PrimeText('Saved themes & typography'),tilePadding:EdgeInsets.zero,children:[ThemeCenterPanel()])","ExpansionTile(title:const PrimeText('Saved themes & typography'),tilePadding:EdgeInsets.zero,children:[savedPanel()])",1]]]
        if source != shim:
            raise AssertionError('Theme Center composition drift: ' + path)
        source = (root / 'packages/primecare_theme_preferences/lib/theme/prime_theme_center.dart').read_text()
        for previous, current, count in reversed(edits):
            if source.count(current) != count:
                raise AssertionError('Theme Center relocation drift: ' + path)
            source = source.replace(current, previous)
        return source
    if rel == 'src/controllers/base_dashboard_controller.dart':
        shim, edits = ["// Host supplies the original authenticated API client.\nimport 'package:flutter_riverpod/flutter_riverpod.dart';\nimport 'package:primecare_controller_base/src/controllers/base_dashboard_controller.dart';\nimport '../network/api_client.dart';\nexport 'package:primecare_controller_base/src/controllers/base_dashboard_controller.dart' show DashboardState, DashboardLoadResult, DashboardLoader;\n\nabstract class BaseDashboardController<S extends DashboardState<S>>\n    extends BaseDashboardControllerBase<S> {\n  BaseDashboardController(\n    Ref ref, {\n    required S initialState,\n    required String endpoint,\n    DashboardLoader? loader,\n  }) : super(ref, initialState: initialState, endpoint: endpoint,\n           loader: loader ?? (() async {\n             final response = await ref.read(apiClientProvider).get(endpoint);\n             return DashboardLoadResult(\n               isSuccess: response.isSuccess,\n               data: response.data,\n               error: response.error,\n             );\n           }));\n}\n",[["import 'package:flutter_riverpod/legacy.dart';\nimport '../network/api_client.dart';\n","import 'package:flutter_riverpod/legacy.dart';\n"],["abstract class BaseDashboardController<","abstract class BaseDashboardControllerBase<"],["  BaseDashboardController(\n    this.ref, {\n    required S initialState,\n    required this.endpoint,\n    DashboardLoader? loader,\n  }) : _loader =\n           loader ??\n           (() async {\n             final response = await ref.read(apiClientProvider).get(endpoint);\n             return DashboardLoadResult(\n               isSuccess: response.isSuccess,\n               data: response.data,\n               error: response.error,\n             );\n           }),\n       super(initialState) {\n    unawaited(loadDashboardData());\n  }\n\n","  BaseDashboardControllerBase(\n    this.ref, {\n    required S initialState,\n    required this.endpoint,\n    required DashboardLoader loader,\n  }) : _loader = loader,\n       super(initialState) {\n    unawaited(loadDashboardData());\n  }\n\n"]]]
        if source != shim:
            raise AssertionError('Dashboard controller composition drift: ' + path)
        source = (root / 'packages/primecare_controller_base/lib/src/controllers/base_dashboard_controller.dart').read_text()
        for previous, current in reversed(edits):
            if source.count(current) != 1:
                raise AssertionError('Dashboard controller relocation drift: ' + path)
            source = source.replace(current, previous, 1)
        return source
    if rel == 'src/providers/psw_providers.dart':
        shim, edits = ["// Existing provider identity and authenticated service binding.\nimport 'package:flutter_riverpod/flutter_riverpod.dart';\nimport 'package:primecare_models/src/models/psw_models.dart';\nimport 'package:primecare_models/src/models/result.dart';\nimport 'package:primecare_psw/src/providers/psw_providers.dart';\nimport '../services/psw_service.dart';\n\nfinal pswDashboardProvider = FutureProvider.autoDispose<Result<PswDashboardData>>((ref) =>\n  loadPswDashboard(ref, (ref) => ref.watch(pswServiceProvider).getDashboardData));\n",[["import 'package:flutter_core/flutter_core.dart';","import 'package:flutter_riverpod/flutter_riverpod.dart';\nimport 'package:primecare_models/src/models/psw_models.dart';\nimport 'package:primecare_models/src/models/result.dart';\nimport 'package:primecare_resilience/src/resilience/provider_ttl.dart';\nimport 'package:primecare_resilience/src/resilience/resilience_service.dart';\nimport 'package:primecare_execution_gate/src/resilience/execution_gate_service.dart';\nimport 'package:primecare_network_status/src/resilience/connectivity_service.dart';"],["final pswDashboardProvider = FutureProvider.autoDispose<Result<PswDashboardData>>((\n  ref,\n) async {","Future<Result<PswDashboardData>> loadPswDashboard(\n  Ref ref,\n  Future<Result<PswDashboardData>> Function() Function(Ref) watchLoader,\n) async {"],["final service = ref.watch(pswServiceProvider);","final load = watchLoader(ref);"],["await service.getDashboardData()","await load()"],["});\n\nFuture<Result<PswDashboardData>> _handlePswFallback","}\n\nFuture<Result<PswDashboardData>> _handlePswFallback"]]]
        if source != shim:
            raise AssertionError('PSW composition drift: ' + path)
        source = (root / 'packages/primecare_psw/lib/src/providers/psw_providers.dart').read_text()
        for previous, current in reversed(edits):
            if source.count(current) != 1:
                raise AssertionError('PSW relocation drift: ' + path)
            source = source.replace(current, previous, 1)
        return source
    if rel == 'src/services/psw_service.dart':
        shim, edits = ["// Host supplies the original authenticated API transport.\nimport 'package:flutter_riverpod/flutter_riverpod.dart';\nimport 'package:primecare_psw/src/services/psw_service.dart';\nimport '../network/api_client.dart';\n\nclass PswService extends PswServiceBase {\n  PswService(ApiClient api) : super((path) async => (await api.get(path)).data);\n}\n\nfinal pswServiceProvider = Provider<PswService>((ref) {\n  final api = ref.watch(apiClientProvider);\n  return PswService(api);\n});\n",[["import 'package:flutter_core/flutter_core.dart';","import 'package:primecare_models/src/models/psw_models.dart';\nimport 'package:primecare_models/src/models/result.dart';",1],["class PswService {\n  final ApiClient _api;\n\n  PswService(this._api);","class PswServiceBase {\n  final Future<dynamic> Function(String path) _read;\n\n  PswServiceBase(this._read);",1],["final response = await _api.get(","final data = await _read(",3],["PswDashboardData.fromJson(response.data as Map<String, dynamic>)","PswDashboardData.fromJson(data as Map<String, dynamic>)",1],["return (response.data as List)","return (data as List)",2],["\nfinal pswServiceProvider = Provider<PswService>((ref) {\n  final api = ref.watch(apiClientProvider);\n  return PswService(api);\n});\n","\n// Host composition provides the original authenticated API provider.\n",1]]]
        if source != shim:
            raise AssertionError('PSW service composition drift: ' + path)
        source = (root / 'packages/primecare_psw/lib/src/services/psw_service.dart').read_text()
        for previous, current, count in reversed(edits):
            if source.count(current) != count:
                raise AssertionError('PSW service relocation drift: ' + path)
            source = source.replace(current, previous)
        return source
    if rel == 'report_providers.dart':
        shim, edits = ["// Legacy composition supplies the original report service and provider identity.\nimport 'package:flutter_core/flutter_core.dart';\nimport 'package:primecare_reporting/report_providers.dart';\n\n/// Provider for the ReportService instance.\nfinal reportServiceProvider = Provider<ReportService>((ref) {\n  final apiClient = ref.watch(apiClientProvider);\n  final telemetry = ref.read<ExecutionGateService>(executionGateProvider);\n  return ReportService(apiClient, telemetry);\n});\n\nfinal reportDataProvider = FutureProvider.family<Result<ReportData>, String>((ref,reportId) {\n  final reportService = ref.watch(reportServiceProvider);\n  return loadReportData(ref, reportId, () => reportService.getReport(reportId));\n});\n\nfinal auraFinancialForecastProvider =\n  Provider<({List<DataPoint> forecast,List<IntelligenceInsight> insights})>((ref) =>\n    buildAuraFinancialForecast(ref.watch(reportDataProvider('revenue_log'))));\n",[["import 'package:flutter_core/flutter_core.dart';\n\n/// Provider for the ReportService instance.\nfinal reportServiceProvider = Provider<ReportService>((ref) {\n  final apiClient = ref.watch(apiClientProvider);\n  final telemetry = ref.read<ExecutionGateService>(executionGateProvider);\n  return ReportService(apiClient, telemetry);\n});\n\n","import 'package:flutter_riverpod/flutter_riverpod.dart';\nimport 'package:primecare_models/src/models/report_models.dart';\nimport 'package:primecare_models/src/models/dashboard_models.dart';\nimport 'package:primecare_models/src/models/result.dart';\nimport 'package:primecare_execution_gate/src/resilience/execution_gate_service.dart';\nimport 'package:primecare_data_logistics/src/application/services/data_logistics_hub.dart';\n\n"],["final reportDataProvider = FutureProvider.family<Result<ReportData>, String>((\n  ref,\n  reportId,\n) async {\n  final reportService = ref.watch(reportServiceProvider);","Future<Result<ReportData>> loadReportData(\n  Ref ref,\n  String reportId,\n  Future<Result<ReportData>> Function() loadReport,\n) async {"],["await reportService.getReport(reportId)","await loadReport()"],["});\n\n/// Intelligent provider","}\n\n/// Intelligent provider"],["final auraFinancialForecastProvider =\n    Provider<({List<DataPoint> forecast, List<IntelligenceInsight> insights})>((\n      ref,\n    ) {\n      final reportAsync = ref.watch(reportDataProvider('revenue_log'));","({List<DataPoint> forecast, List<IntelligenceInsight> insights}) buildAuraFinancialForecast(\n      AsyncValue<Result<ReportData>> reportAsync,\n    ) {"],["      );\n    });\n","      );\n    }\n"]]]
        if source != shim:
            raise AssertionError('Report provider composition drift: ' + path)
        source = (root / 'packages/primecare_reporting/lib/report_providers.dart').read_text()
        for previous, current in reversed(edits):
            if source.count(current) != 1:
                raise AssertionError('Report provider relocation drift: ' + path)
            source = source.replace(current, previous, 1)
        return source
    if rel == 'dynamic_page_providers.dart':
        shim, edits = ["// Host retains the existing authenticated API client and endpoint configuration.\nimport 'package:flutter_core/flutter_core.dart';\nimport 'package:primecare_dynamic_pages/dynamic_page_providers.dart';\n\nfinal dynamicPageProvider =\n  FutureProvider.family<Result<List<dynamic>>, String>((ref, endpointKey) {\n    final apiClient = ref.watch(apiClientProvider);\n    return loadDynamicPage(ref, endpointKey,\n      (key) => ApiConfig.endpoints[key],\n      (path) async => (await apiClient.get(path)).data);\n  });\n",[["import 'package:flutter_core/flutter_core.dart';","import 'package:flutter_riverpod/flutter_riverpod.dart';\nimport 'package:primecare_models/src/models/result.dart';\nimport 'package:primecare_execution_gate/src/resilience/execution_gate_service.dart';"],["final dynamicPageProvider =\n    FutureProvider.family<Result<List<dynamic>>, String>((\n      ref,\n      endpointKey,\n    ) async {\n      final apiClient = ref.watch(apiClientProvider);","Future<Result<List<dynamic>>> loadDynamicPage(\n      Ref ref,\n      String endpointKey,\n      String? Function(String endpointKey) resolveEndpoint,\n      Future<dynamic> Function(String path) read,\n    ) async {"],["ApiConfig.endpoints[endpointKey]","resolveEndpoint(endpointKey)"],["final response = await apiClient.get(path);\n          final json = response.data;","final json = await read(path);"],["      );\n    });\n","      );\n    }\n"]]]
        if source != shim:
            raise AssertionError('Dynamic page composition drift: ' + path)
        source = (root / 'packages/primecare_dynamic_pages/lib/dynamic_page_providers.dart').read_text()
        for previous, current in reversed(edits):
            if source.count(current) != 1:
                raise AssertionError('Dynamic page relocation drift: ' + path)
            source = source.replace(current, previous, 1)
        return source
    if rel == 'src/application/services/report_service.dart':
        shim, edits = ["// Existing business service and authenticated repository are retained.\nimport 'package:primecare_reporting/report_service.dart';\nimport 'base_business_service.dart';\n\nclass ReportService extends BaseBusinessService with ReportServiceImplementation {\n  ReportService(super.client, super.telemetry);\n  @override\n  Future<({int? statusCode, dynamic data})> readReport(String endpoint) async {\n    final response = await repository.get(endpoint);\n    return (statusCode: response.statusCode, data: response.data);\n  }\n}\n",[["import 'package:flutter_core/flutter_core.dart'\n    hide ReportData, ReportRow, ReportColumn;\nimport 'base_business_service.dart';\nimport '../../domain/models/report_models.dart';\n\nclass ReportService extends BaseBusinessService {\n  ReportService(super.client, super.telemetry);\n\n","import 'package:primecare_models/src/models/report_models.dart';\nimport 'package:primecare_models/src/models/result.dart';\nimport 'package:primecare_execution_gate/src/resilience/execution_gate_service.dart';\nimport 'package:primecare_guarded_service/primecare_guarded_service.dart';\n\nmixin ReportServiceImplementation on BaseGuardedService {\n  Future<({int? statusCode, dynamic data})> readReport(String endpoint);\n\n"],["await repository.get(endpoint)","await readReport(endpoint)"]]]
        if source != shim:
            raise AssertionError('Report service composition drift: ' + path)
        source = (root / 'packages/primecare_reporting/lib/report_service.dart').read_text()
        for previous, current in reversed(edits):
            if source.count(current) != 1:
                raise AssertionError('Report service relocation drift: ' + path)
            source = source.replace(current, previous, 1)
        return source
    if rel == 'src/application/services/verification_service.dart':
        shim, edits = ["// Host retains the existing authenticated repository and endpoint configuration.\nimport 'package:flutter_core/flutter_core.dart';\nimport 'package:primecare_verification/verification_service.dart';\nimport 'base_business_service.dart';\n\nclass VerificationService extends BaseBusinessService with VerificationServiceImplementation {\n  VerificationService(super.client, super.telemetry);\n  @override\n  String verificationEndpoint(String key) => ApiConfig.endpoints[key]!;\n  @override\n  Future<({int? statusCode, dynamic data})> readVerificationReport(String endpoint) async {\n    final response = await repository.get(endpoint);\n    return (statusCode: response.statusCode, data: response.data);\n  }\n}\n",[["import 'base_business_service.dart';\n// Governance - Category: service | Purpose: Layer: 01_INFRASTRUCTURE Hardened Verification Service for PrimeCare Infrastructure audits. Handles architectural pur...\n// Layer: 01_INFRASTRUCTURE\nimport 'package:flutter_core/flutter_core.dart';\n\n/// Hardened Verification Service for PrimeCare Infrastructure audits.\n/// Handles architectural purpose reports and database integrity metrics.\nclass VerificationService extends BaseBusinessService {\n  VerificationService(super.client, super.telemetry);\n\n","// Governance - Category: service | Purpose: infrastructure verification reports.\nimport 'package:primecare_models/src/models/result.dart';\nimport 'package:primecare_execution_gate/src/resilience/execution_gate_service.dart';\nimport 'package:primecare_guarded_service/primecare_guarded_service.dart';\n\nmixin VerificationServiceImplementation on BaseGuardedService {\n  String verificationEndpoint(String key);\n  Future<({int? statusCode, dynamic data})> readVerificationReport(String endpoint);\n\n",1],["ApiConfig.endpoints['verificationPurposeReport']!","verificationEndpoint('verificationPurposeReport')",1],["ApiConfig.endpoints['verificationDatabaseReport']!","verificationEndpoint('verificationDatabaseReport')",1],["await repository.get(endpoint)","await readVerificationReport(endpoint)",2]]]
        if source != shim:
            raise AssertionError('Verification service composition drift: ' + path)
        source = (root / 'packages/primecare_verification/lib/verification_service.dart').read_text()
        for previous, current, count in reversed(edits):
            if source.count(current) != count:
                raise AssertionError('Verification service relocation drift: ' + path)
            source = source.replace(current, previous)
        return source
    if rel in theme_binding_relocations:
        shim, edits = theme_binding_relocations[rel]
        if source != shim:
            raise AssertionError('Theme preference composition drift: ' + path)
        source = (root / ('packages/primecare_theme_preferences/lib/' + rel)).read_text()
        for previous, current in reversed(edits):
            if source.count(current) != 1:
                raise AssertionError('Theme preference relocation drift: ' + path)
            source = source.replace(current, previous, 1)
        if rel in ('theme/theme_library_provider.dart', 'theme/theme_center_complete_panel.dart'):
            return source
    if rel == 'theme/theme_settings_provider.dart':
        boundary = "import 'package:primecare_theme/theme/theme_settings_state.dart';\nexport 'package:primecare_theme/theme/theme_settings_state.dart';\n"
        canonical = (root / 'packages/primecare_theme/lib/theme/theme_settings_state.dart').read_text()
        prefix = "import 'package:flutter/material.dart';\nimport 'personal_theme.dart';\n\n"
        enum_line = "enum LayoutStyle { verticalLeft, verticalRight, horizontal, collapsed }\n"
        if source.count(boundary) != 1 or not canonical.startswith(prefix + enum_line + '\n'):
            raise AssertionError('Theme state relocation drift: ' + path)
        body = canonical.removeprefix(prefix + enum_line + '\n')
        if not body.startswith('class ThemeSettingsState {') or source.count('bool hasThemeAccount') != 1 or source.count('class ThemeSettingsNotifier') != 1:
            raise AssertionError('Theme state split drift: ' + path)
        return source.replace(boundary, '', 1).replace('bool hasThemeAccount', enum_line + 'bool hasThemeAccount', 1).replace('class ThemeSettingsNotifier', body + 'class ThemeSettingsNotifier', 1)
    if rel not in _REVIEWED_RELOCATIONS:
        return source
    owner, comment, edits, terminal_newline = _REVIEWED_RELOCATIONS[rel]
    expected = comment + f"export 'package:{owner}/{rel}';\n"
    if source != expected:
        raise AssertionError('Compatibility export drift: ' + path)
    canonical = (root / f'packages/{owner}/lib/{rel}').read_text()
    canonical = _before_theme_owner_tokens(canonical, rel)
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
