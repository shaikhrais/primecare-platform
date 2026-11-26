import 'package:flutter/material.dart';
import 'personal_theme.dart';

enum LayoutStyle { verticalLeft, verticalRight, horizontal, collapsed }

class ThemeSettingsState {
  final LayoutStyle layoutStyle;
  final String navigationStyle;
  final String? navbarStyle;
  final Map<String,String> hiddenChrome;
  final String presetName;
  final bool customScrollbars;
  final TextDirection direction;
  final String? customPrimary, customPrimaryContainer, customSidebarBg, customTopbarBg;
  final PersonalTheme? personalTheme;
  final Map<String, PersonalTheme> sectionThemes;
  const ThemeSettingsState({required this.layoutStyle,required this.presetName,required this.customScrollbars,required this.direction,this.customPrimary,this.customPrimaryContainer,this.customSidebarBg,this.customTopbarBg,this.personalTheme,this.sectionThemes=const {},this.navigationStyle='slide',this.hiddenChrome=const {},this.navbarStyle});
  PersonalTheme get theme => personalTheme ?? PersonalTheme(name:'My theme',preset:presetName,colors:{if(customPrimary!=null)'primary':customPrimary!,if(customPrimaryContainer!=null)'primaryContainer':customPrimaryContainer!,if(customSidebarBg!=null)'sidebar':customSidebarBg!,if(customTopbarBg!=null)'topbar':customTopbarBg!});
  ThemeSettingsState copyWith({String? navbarStyle,Map<String,String>? hiddenChrome,String? navigationStyle,LayoutStyle? layoutStyle,String? presetName,bool? customScrollbars,TextDirection? direction,String? customPrimary,String? customPrimaryContainer,String? customSidebarBg,String? customTopbarBg}) => ThemeSettingsState(layoutStyle:layoutStyle ?? this.layoutStyle,presetName:presetName ?? this.presetName,customScrollbars:customScrollbars ?? this.customScrollbars,direction:direction ?? this.direction,customPrimary:customPrimary ?? this.customPrimary,customPrimaryContainer:customPrimaryContainer ?? this.customPrimaryContainer,customSidebarBg:customSidebarBg ?? this.customSidebarBg,customTopbarBg:customTopbarBg ?? this.customTopbarBg,personalTheme:personalTheme,sectionThemes:sectionThemes,navigationStyle:navigationStyle ?? this.navigationStyle,hiddenChrome:hiddenChrome ?? this.hiddenChrome,navbarStyle:navbarStyle ?? this.navbarStyle);
  ThemeSettingsState withTheme(PersonalTheme value) {final next=value.validated();return ThemeSettingsState(layoutStyle:layoutStyle,presetName:next.preset,customScrollbars:customScrollbars,direction:direction,customPrimary:next.colors['primary'],customPrimaryContainer:next.colors['primaryContainer'],customSidebarBg:next.colors['sidebar'],customTopbarBg:next.colors['topbar'],personalTheme:next,sectionThemes:sectionThemes,navigationStyle:navigationStyle,hiddenChrome:hiddenChrome,navbarStyle:navbarStyle);}
  Map<String,Object> toJson() => {'version':navbarStyle==null?4:5,if(navbarStyle!=null)'navbarStyle':navbarStyle!,'hiddenChrome':hiddenChrome,'navigationStyle':navigationStyle,'sections':{for(final entry in sectionThemes.entries)entry.key:entry.value.validated().toJson()},'layout':layoutStyle.name,'scrollbars':customScrollbars,'direction':direction==TextDirection.rtl?'rtl':'ltr','personal':personalTheme!=null,'theme':theme.validated().toJson()};
  factory ThemeSettingsState.fromJson(Object? raw) {
    if(raw is! Map || ![1,2,3,4,5].contains(raw['version']) ||
      raw.length != (raw['version']==1?6:raw['version']==2?7:raw['version']==3?8:raw['version']==4?9:10) ||
      !raw.keys.toSet().containsAll(['version','layout','scrollbars','direction','personal','theme']) ||
      !LayoutStyle.values.any((v)=>v.name==raw['layout']) || raw['scrollbars'] is! bool ||
      raw['personal'] is! bool || !['ltr','rtl'].contains(raw['direction'])) throw const FormatException('Invalid theme settings');
    if(raw['version']==5&&!['fixed','static'].contains(raw['navbarStyle']))throw const FormatException('Invalid navbar style');
    final sections=<String,PersonalTheme>{};
    if(raw['version']!=1) {
      final source=raw['sections'];
      if(source is! Map || source.keys.any((key)=>!['navbar','toolbar','footer'].contains(key))) throw const FormatException('Invalid section themes');
      for(final entry in source.entries) { sections[entry.key as String]=PersonalTheme.fromJson(entry.value); }
    }
    if([3,4,5].contains(raw['version']) && !['slide','tabbed'].contains(raw['navigationStyle']))throw const FormatException('Invalid navigation style');
    final chrome=<String,String>{};
    if([4,5].contains(raw['version'])){
      final values=raw['hiddenChrome'];
      const permitted={'navigation':['left','right','top','bottom'],'toolbar':['top','belowNavigation','bottom'],'footer':['sticky','static']};
      if(values is! Map || values.keys.any((key)=>!permitted.containsKey(key)))throw const FormatException('Invalid hidden chrome');
      for(final entry in values.entries){if(!permitted[entry.key]!.contains(entry.value))throw const FormatException('Invalid hidden chrome');chrome[entry.key as String]=entry.value as String;}
    }
    final theme=PersonalTheme.fromJson(raw['theme']);
    final settings=ThemeSettingsState(layoutStyle:LayoutStyle.values.firstWhere((v)=>v.name==raw['layout']),
      presetName:theme.preset,customScrollbars:raw['scrollbars'] as bool,
      direction:raw['direction']=='rtl'?TextDirection.rtl:TextDirection.ltr,
      sectionThemes:Map.unmodifiable(sections),navigationStyle:[3,4,5].contains(raw['version'])?raw['navigationStyle'] as String:'slide',hiddenChrome:Map.unmodifiable(chrome),navbarStyle:raw['version']==5?raw['navbarStyle'] as String:null);
    return raw['personal']==true?settings.withTheme(theme):settings;
  }
}
