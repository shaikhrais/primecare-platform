import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../auth_service.dart';
import '../providers/persistence_providers.dart';
import 'personal_theme.dart';
import 'theme_center_catalog_generated.dart';
import 'package:primecare_theme/theme/theme_settings_state.dart';
export 'package:primecare_theme/theme/theme_settings_state.dart';

bool hasThemeAccount(AuthState auth) => auth.isAuthenticated &&
  [auth.tenantId,auth.userId,auth.role].every((value)=>value!=null && value.trim().isNotEmpty);
String themeAccountScope(AuthState auth) => Uri.encodeComponent(jsonEncode([
  auth.tenantId ?? '',hasThemeAccount(auth)?auth.userId:'guest',auth.role ?? ''
]));
/// Only unambiguous authenticated legacy keys may be read during migration.
String? legacyThemeAccountScope(AuthState auth) {
  if(!hasThemeAccount(auth) || [auth.tenantId!,auth.userId!,auth.role!].any((value)=>value.contains(':')))return null;
  return Uri.encodeComponent('${auth.tenantId}:${auth.userId}:${auth.role}');
}

class ThemeSettingsNotifier extends Notifier<ThemeSettingsState> {
  String _scope='';
  bool _authenticated=false;
  bool _matchesAccount(String scope) => _scope==scope && themeAccountScope(ref.read(authProvider))==scope;
  PersonalTheme _themeForAccount(String scope) {
    if(!_matchesAccount(scope))throw StateError('Account changed');
    return state.theme;
  }
  PersonalThemeSettingsSession bindAccount() => PersonalThemeSettingsSession._(this,_scope);
  @override ThemeSettingsState build() {
    final auth=ref.watch(authProvider);_scope=themeAccountScope(auth);_authenticated=hasThemeAccount(auth);final prefs=ref.watch(sharedPreferencesProvider);
    try {final legacy=legacyThemeAccountScope(auth);final raw=!_authenticated?null:prefs?.getString('theme_center_settings_v1:$_scope') ?? (legacy==null?null:prefs?.getString('theme_center_settings_v1:$legacy'));if(raw!=null && utf8.encode(raw).length<=16384)return ThemeSettingsState.fromJson(jsonDecode(raw));}catch (_) {}
    return const ThemeSettingsState(layoutStyle:LayoutStyle.verticalLeft,presetName:'navyTealPalette',customScrollbars:false,direction:TextDirection.ltr,navbarStyle:'fixed');
  }
  Future<void> _save(ThemeSettingsState next) async {
    if(!_matchesAccount(_scope))throw StateError('Account changed');
    final scope=_scope,prefs=ref.read(sharedPreferencesProvider);final json=jsonEncode(next.toJson());
    if(_authenticated && prefs!=null && !await prefs.setString('theme_center_settings_v1:$scope',json)) throw StateError('Unable to save appearance settings');
    if(!_matchesAccount(scope))throw StateError('Account changed');state=next;
  }
  Future<void> replaceSettings(ThemeSettingsState next) => _save(ThemeSettingsState.fromJson(next.toJson()));
  Future<void> updateSectionTheme(String section, PersonalTheme? theme) {
    if(!['navbar','toolbar','footer'].contains(section)) throw ArgumentError('Unknown theme section');
    final sections={...state.sectionThemes};
    if(theme==null) {sections.remove(section);} else {sections[section]=theme.validated();}
    return _save(ThemeSettingsState(layoutStyle:state.layoutStyle,presetName:state.presetName,
      customScrollbars:state.customScrollbars,direction:state.direction,personalTheme:state.personalTheme,
      customPrimary:state.customPrimary,customPrimaryContainer:state.customPrimaryContainer,
      customSidebarBg:state.customSidebarBg,customTopbarBg:state.customTopbarBg,
      sectionThemes:Map.unmodifiable(sections),navigationStyle:state.navigationStyle,hiddenChrome:state.hiddenChrome,navbarStyle:state.navbarStyle));
  }
  Future<void> applyColorCombination(String name) {
    final sections=themeCenterColorCombinations[name];
    if(sections==null)throw ArgumentError('Unknown color combination');
    final current=state.theme;
    PersonalTheme palette(String part)=>PersonalTheme(name:name,preset:sections[part]!,fontFamily:current.fontFamily,fontScale:current.fontScale,radius:current.radius).validated();
    return replaceSettings(ThemeSettingsState.fromJson({...state.toJson(),'personal':true,'theme':palette('main').toJson(),
      'sections':{for(final part in ['navbar','toolbar','footer'])part:palette(part).toJson()}}));
  }
  Future<void> applyPersonalTheme(PersonalTheme theme) => _save(state.withTheme(theme));
  Future<void> rememberChrome(String part,String value) => replaceSettings(state.copyWith(hiddenChrome:Map.unmodifiable({...state.hiddenChrome,part:value})));
  Future<void> updateNavbarStyle(String style) {
    if(!['fixed','static'].contains(style))throw ArgumentError('Unknown navbar style');
    return _save(state.copyWith(navbarStyle:style));
  }
  Future<void> updateNavigationStyle(String style) {
    if(!['slide','tabbed'].contains(style))throw ArgumentError('Unknown navigation style');
    return _save(state.copyWith(navigationStyle:style));
  }
  Future<void> updateLayoutStyle(LayoutStyle style) => _save(state.copyWith(layoutStyle:style));
  Future<void> updatePreset(String presetName) => _save(state.withTheme(PersonalTheme(name:'My theme',preset:presetName,fontFamily:state.theme.fontFamily,fontScale:state.theme.fontScale,radius:state.theme.radius)));
  Future<void> toggleScrollbars(bool enabled) => _save(state.copyWith(customScrollbars:enabled));
  Future<void> updateDirection(TextDirection direction) => _save(state.copyWith(direction:direction));
  Future<void> updateCustomColors({String? primary,String? primaryContainer,String? sidebarBg,String? topbarBg}) {
    final colors={...state.theme.colors};for(final key in ['primary','primaryContainer','sidebar','topbar'])colors.remove(key);
    if(primary!=null)colors['primary']=primary;if(primaryContainer!=null)colors['primaryContainer']=primaryContainer;if(sidebarBg!=null)colors['sidebar']=sidebarBg;if(topbarBg!=null)colors['topbar']=topbarBg;
    return applyPersonalTheme(PersonalTheme(name:state.theme.name,preset:state.presetName,fontFamily:state.theme.fontFamily,fontScale:state.theme.fontScale,radius:state.theme.radius,colors:colors));
  }
  Future<void> clearCustomColors() => applyPersonalTheme(PersonalTheme(name:state.theme.name,preset:state.presetName,fontFamily:state.theme.fontFamily,fontScale:state.theme.fontScale,radius:state.theme.radius));
  Future<void> resetToTenantDefault(String tenantPreset) => _save(ThemeSettingsState(layoutStyle:LayoutStyle.verticalLeft,presetName:tenantPreset,customScrollbars:false,direction:TextDirection.ltr,navbarStyle:'fixed'));
}
final themeSettingsProvider=NotifierProvider<ThemeSettingsNotifier,ThemeSettingsState>(ThemeSettingsNotifier.new);

/// Dialogs retain the account that opened them, even after a login switch.
class PersonalThemeSettingsSession {
  final ThemeSettingsNotifier _owner;
  final String _scope;
  PersonalThemeSettingsSession._(this._owner,this._scope);
  Future<void> updateNavbarStyle(String style) {
    if(!_owner._matchesAccount(_scope))throw StateError('Account changed');
    return _owner.updateNavbarStyle(style);
  }
  Future<void> applyPersonalTheme(PersonalTheme theme) {
    if(!_owner._matchesAccount(_scope))throw StateError('Account changed');
    return _owner.applyPersonalTheme(theme);
  }
  Future<void> updateTextScale(double scale) {
    final current = _owner._themeForAccount(_scope);
    return _owner.applyPersonalTheme(
      PersonalTheme.fromJson({...current.toJson(), 'fontScale': scale}),
    );
  }
}
