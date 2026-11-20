import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../auth_service.dart';
import '../providers/persistence_providers.dart';
import 'personal_theme.dart';
import 'theme_center_catalog_generated.dart';

enum LayoutStyle { verticalLeft, verticalRight, horizontal, collapsed }
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

class ThemeSettingsState {
  final LayoutStyle layoutStyle;
  final String navigationStyle;
  final Map<String,String> hiddenChrome;
  final String presetName;
  final bool customScrollbars;
  final TextDirection direction;
  final String? customPrimary, customPrimaryContainer, customSidebarBg, customTopbarBg;
  final PersonalTheme? personalTheme;
  final Map<String, PersonalTheme> sectionThemes;
  const ThemeSettingsState({required this.layoutStyle,required this.presetName,required this.customScrollbars,required this.direction,this.customPrimary,this.customPrimaryContainer,this.customSidebarBg,this.customTopbarBg,this.personalTheme,this.sectionThemes=const {},this.navigationStyle='slide',this.hiddenChrome=const {}});
  PersonalTheme get theme => personalTheme ?? PersonalTheme(name:'My theme',preset:presetName,colors:{if(customPrimary!=null)'primary':customPrimary!,if(customPrimaryContainer!=null)'primaryContainer':customPrimaryContainer!,if(customSidebarBg!=null)'sidebar':customSidebarBg!,if(customTopbarBg!=null)'topbar':customTopbarBg!});
  ThemeSettingsState copyWith({Map<String,String>? hiddenChrome,String? navigationStyle,LayoutStyle? layoutStyle,String? presetName,bool? customScrollbars,TextDirection? direction,String? customPrimary,String? customPrimaryContainer,String? customSidebarBg,String? customTopbarBg}) => ThemeSettingsState(layoutStyle:layoutStyle ?? this.layoutStyle,presetName:presetName ?? this.presetName,customScrollbars:customScrollbars ?? this.customScrollbars,direction:direction ?? this.direction,customPrimary:customPrimary ?? this.customPrimary,customPrimaryContainer:customPrimaryContainer ?? this.customPrimaryContainer,customSidebarBg:customSidebarBg ?? this.customSidebarBg,customTopbarBg:customTopbarBg ?? this.customTopbarBg,personalTheme:personalTheme,sectionThemes:sectionThemes,navigationStyle:navigationStyle ?? this.navigationStyle,hiddenChrome:hiddenChrome ?? this.hiddenChrome);
  ThemeSettingsState withTheme(PersonalTheme value) {final next=value.validated();return ThemeSettingsState(layoutStyle:layoutStyle,presetName:next.preset,customScrollbars:customScrollbars,direction:direction,customPrimary:next.colors['primary'],customPrimaryContainer:next.colors['primaryContainer'],customSidebarBg:next.colors['sidebar'],customTopbarBg:next.colors['topbar'],personalTheme:next,sectionThemes:sectionThemes,navigationStyle:navigationStyle,hiddenChrome:hiddenChrome);}
  Map<String,Object> toJson() => {'version':4,'hiddenChrome':hiddenChrome,'navigationStyle':navigationStyle,'sections':{for(final entry in sectionThemes.entries)entry.key:entry.value.validated().toJson()},'layout':layoutStyle.name,'scrollbars':customScrollbars,'direction':direction==TextDirection.rtl?'rtl':'ltr','personal':personalTheme!=null,'theme':theme.validated().toJson()};
  factory ThemeSettingsState.fromJson(Object? raw) {
    if(raw is! Map || ![1,2,3,4].contains(raw['version']) ||
      raw.length != (raw['version']==1?6:raw['version']==2?7:raw['version']==3?8:9) ||
      !raw.keys.toSet().containsAll(['version','layout','scrollbars','direction','personal','theme']) ||
      !LayoutStyle.values.any((v)=>v.name==raw['layout']) || raw['scrollbars'] is! bool ||
      raw['personal'] is! bool || !['ltr','rtl'].contains(raw['direction'])) throw const FormatException('Invalid theme settings');
    final sections=<String,PersonalTheme>{};
    if(raw['version']!=1) {
      final source=raw['sections'];
      if(source is! Map || source.keys.any((key)=>!['navbar','toolbar','footer'].contains(key))) throw const FormatException('Invalid section themes');
      for(final entry in source.entries) { sections[entry.key as String]=PersonalTheme.fromJson(entry.value); }
    }
    if([3,4].contains(raw['version']) && !['slide','tabbed'].contains(raw['navigationStyle']))throw const FormatException('Invalid navigation style');
    final chrome=<String,String>{};
    if(raw['version']==4){
      final values=raw['hiddenChrome'];
      const permitted={'navigation':['left','right','top','bottom'],'toolbar':['top','belowNavigation','bottom'],'footer':['sticky','static']};
      if(values is! Map || values.keys.any((key)=>!permitted.containsKey(key)))throw const FormatException('Invalid hidden chrome');
      for(final entry in values.entries){if(!permitted[entry.key]!.contains(entry.value))throw const FormatException('Invalid hidden chrome');chrome[entry.key as String]=entry.value as String;}
    }
    final theme=PersonalTheme.fromJson(raw['theme']);
    final settings=ThemeSettingsState(layoutStyle:LayoutStyle.values.firstWhere((v)=>v.name==raw['layout']),
      presetName:theme.preset,customScrollbars:raw['scrollbars'] as bool,
      direction:raw['direction']=='rtl'?TextDirection.rtl:TextDirection.ltr,
      sectionThemes:Map.unmodifiable(sections),navigationStyle:[3,4].contains(raw['version'])?raw['navigationStyle'] as String:'slide',hiddenChrome:Map.unmodifiable(chrome));
    return raw['personal']==true?settings.withTheme(theme):settings;
  }
}
class ThemeSettingsNotifier extends Notifier<ThemeSettingsState> {
  String _scope='';
  bool _authenticated=false;
  bool _matchesAccount(String scope) => _scope==scope && themeAccountScope(ref.read(authProvider))==scope;
  PersonalThemeSettingsSession bindAccount() => PersonalThemeSettingsSession._(this,_scope);
  @override ThemeSettingsState build() {
    final auth=ref.watch(authProvider);_scope=themeAccountScope(auth);_authenticated=hasThemeAccount(auth);final prefs=ref.watch(sharedPreferencesProvider);
    try {final legacy=legacyThemeAccountScope(auth);final raw=!_authenticated?null:prefs?.getString('theme_center_settings_v1:$_scope') ?? (legacy==null?null:prefs?.getString('theme_center_settings_v1:$legacy'));if(raw!=null && utf8.encode(raw).length<=16384)return ThemeSettingsState.fromJson(jsonDecode(raw));}catch (_) {}
    return const ThemeSettingsState(layoutStyle:LayoutStyle.verticalLeft,presetName:'navyTealPalette',customScrollbars:false,direction:TextDirection.ltr);
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
      sectionThemes:Map.unmodifiable(sections),navigationStyle:state.navigationStyle,hiddenChrome:state.hiddenChrome));
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
  Future<void> resetToTenantDefault(String tenantPreset) => _save(ThemeSettingsState(layoutStyle:LayoutStyle.verticalLeft,presetName:tenantPreset,customScrollbars:false,direction:TextDirection.ltr));
}
final themeSettingsProvider=NotifierProvider<ThemeSettingsNotifier,ThemeSettingsState>(ThemeSettingsNotifier.new);

/// Dialogs retain the account that opened them, even after a login switch.
class PersonalThemeSettingsSession {
  final ThemeSettingsNotifier _owner;
  final String _scope;
  PersonalThemeSettingsSession._(this._owner,this._scope);
  Future<void> applyPersonalTheme(PersonalTheme theme) {
    if(!_owner._matchesAccount(_scope))throw StateError('Account changed');
    return _owner.applyPersonalTheme(theme);
  }
}
