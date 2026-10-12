import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../auth_service.dart';
import '../providers/persistence_providers.dart';
import 'personal_theme.dart';

enum LayoutStyle { verticalLeft, verticalRight, horizontal, collapsed }
String themeAccountScope(AuthState auth) => Uri.encodeComponent('${auth.tenantId ?? ''}:${auth.isAuthenticated ? auth.userId ?? 'guest' : 'guest'}:${auth.role ?? ''}');

class ThemeSettingsState {
  final LayoutStyle layoutStyle;
  final String presetName;
  final bool customScrollbars;
  final TextDirection direction;
  final String? customPrimary, customPrimaryContainer, customSidebarBg, customTopbarBg;
  final PersonalTheme? personalTheme;
  const ThemeSettingsState({required this.layoutStyle,required this.presetName,required this.customScrollbars,required this.direction,this.customPrimary,this.customPrimaryContainer,this.customSidebarBg,this.customTopbarBg,this.personalTheme});
  PersonalTheme get theme => personalTheme ?? PersonalTheme(name:'My theme',preset:presetName,colors:{if(customPrimary!=null)'primary':customPrimary!,if(customPrimaryContainer!=null)'primaryContainer':customPrimaryContainer!,if(customSidebarBg!=null)'sidebar':customSidebarBg!,if(customTopbarBg!=null)'topbar':customTopbarBg!});
  ThemeSettingsState copyWith({LayoutStyle? layoutStyle,String? presetName,bool? customScrollbars,TextDirection? direction,String? customPrimary,String? customPrimaryContainer,String? customSidebarBg,String? customTopbarBg}) => ThemeSettingsState(layoutStyle:layoutStyle ?? this.layoutStyle,presetName:presetName ?? this.presetName,customScrollbars:customScrollbars ?? this.customScrollbars,direction:direction ?? this.direction,customPrimary:customPrimary ?? this.customPrimary,customPrimaryContainer:customPrimaryContainer ?? this.customPrimaryContainer,customSidebarBg:customSidebarBg ?? this.customSidebarBg,customTopbarBg:customTopbarBg ?? this.customTopbarBg,personalTheme:personalTheme);
  ThemeSettingsState withTheme(PersonalTheme value) {final next=value.validated();return ThemeSettingsState(layoutStyle:layoutStyle,presetName:next.preset,customScrollbars:customScrollbars,direction:direction,customPrimary:next.colors['primary'],customPrimaryContainer:next.colors['primaryContainer'],customSidebarBg:next.colors['sidebar'],customTopbarBg:next.colors['topbar'],personalTheme:next);}
  Map<String,Object> toJson() => {'version':1,'layout':layoutStyle.name,'scrollbars':customScrollbars,'direction':direction==TextDirection.rtl?'rtl':'ltr','personal':personalTheme!=null,'theme':theme.validated().toJson()};
  factory ThemeSettingsState.fromJson(Object? raw) {
    if(raw is! Map || raw.length!=6 || !raw.keys.toSet().containsAll(['version','layout','scrollbars','direction','personal','theme']) || raw['version']!=1 || !LayoutStyle.values.any((v)=>v.name==raw['layout']) || raw['scrollbars'] is! bool || raw['personal'] is! bool || !['ltr','rtl'].contains(raw['direction'])) throw const FormatException('Invalid theme settings');
    final theme=PersonalTheme.fromJson(raw['theme']);final settings=ThemeSettingsState(layoutStyle:LayoutStyle.values.firstWhere((v)=>v.name==raw['layout']),presetName:theme.preset,customScrollbars:raw['scrollbars'] as bool,direction:raw['direction']=='rtl'?TextDirection.rtl:TextDirection.ltr);return raw['personal']==true?settings.withTheme(theme):settings;
  }
}
class ThemeSettingsNotifier extends Notifier<ThemeSettingsState> {
  String _scope='';
  @override ThemeSettingsState build() {
    final auth=ref.watch(authProvider);_scope=themeAccountScope(auth);final prefs=ref.watch(sharedPreferencesProvider);
    try {final raw=prefs?.getString('theme_center_settings_v1:$_scope');if(raw!=null && utf8.encode(raw).length<=16384)return ThemeSettingsState.fromJson(jsonDecode(raw));}catch (_) {}
    return const ThemeSettingsState(layoutStyle:LayoutStyle.verticalLeft,presetName:'navyTealPalette',customScrollbars:false,direction:TextDirection.ltr);
  }
  Future<void> _save(ThemeSettingsState next) async {
    final scope=_scope,prefs=ref.read(sharedPreferencesProvider);final json=jsonEncode(next.toJson());
    if(prefs!=null && !await prefs.setString('theme_center_settings_v1:$scope',json)) throw StateError('Unable to save appearance settings');
    if(_scope!=scope)throw StateError('Account changed');state=next;
  }
  Future<void> applyPersonalTheme(PersonalTheme theme) => _save(state.withTheme(theme));
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
