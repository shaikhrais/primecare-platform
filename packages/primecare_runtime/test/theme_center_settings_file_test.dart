import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_runtime/theme/personal_theme.dart';
import 'package:primecare_runtime/theme/portal_section_theme.dart';
import 'package:primecare_runtime/theme/theme_center_settings_file.dart';
import 'package:primecare_runtime/theme/theme_center_theme_data.dart';
import 'package:primecare_runtime/theme/theme_settings_provider.dart';
import 'package:primecare_runtime/workspace/workspace_layout.dart';

void main() {
  ThemeSettingsState appearance() => ThemeSettingsState(layoutStyle:LayoutStyle.horizontal,
    presetName:'navyTealPalette',customScrollbars:true,direction:TextDirection.rtl,
    personalTheme:PersonalTheme(name:'Main',preset:'navyTealPalette',fontScale:1.25,radius:8),
    sectionThemes:{for(final name in ['navbar','toolbar','footer'])name:PersonalTheme(name:name,preset:'navyTealPalette',colors:{'surface':'#111827','background':'#111827'})});
  test('one file roundtrips appearance, all four areas, direction and full layout', () {
    final file=ThemeCenterSettingsFile(appearance:appearance(),layout:WorkspaceLayout.defaults([]).patch({
      'navigation':'top','toolbar':'belowNavigation','footer':'sticky','container':'content','maxWidth':1120}));
    final restored=ThemeCenterSettingsFile.parse(file.exportJson(),[]);
    expect(restored.appearance.toJson(),file.appearance.toJson());
    expect(restored.layout.toJson(),file.layout.toJson());
    expect(restored.appearance.sectionThemes.length,3);
    expect(restored.appearance.theme.fontScale,1.25);
    expect(restored.appearance.direction,TextDirection.rtl);
  });
  test('legacy v1 appearance loads; unknown sections, access rules and oversized files fail', () {
    final legacy=appearance().toJson()..remove('sections')..remove('navigationStyle')..remove('hiddenChrome');legacy['version']=1;
    expect(ThemeSettingsState.fromJson(legacy).sectionThemes,isEmpty);
    final bad=appearance().toJson();bad['sections']={'authorization':<String,Object?>{}};
    expect(()=>ThemeSettingsState.fromJson(bad),throwsFormatException);
    final file=ThemeCenterSettingsFile(appearance:appearance(),layout:WorkspaceLayout.defaults([]));
    final json=jsonDecode(file.exportJson()) as Map<String,dynamic>;json['defaultAuth']=['admin'];
    expect(()=>ThemeCenterSettingsFile.parse(jsonEncode(json),[]),throwsFormatException);
    expect(()=>ThemeCenterSettingsFile.parse('x'*65537,[]),throwsFormatException);
    expect(()=>ThemeCenterSettingsFile.parse(file.exportJson(),['new-panel']),throwsFormatException);
  });
  test('section palettes are independent; absent sections inherit the main theme', () {
    final state=appearance();final main=applyPersonalThemeData(ThemeData(),state.theme);
    final themed=applyPortalSectionThemes(main,state.sectionThemes);
    expect(portalSectionTheme(themed,'footer').colorScheme.surface,const Color(0xff111827));
    expect(portalSectionTheme(themed,'toolbar').colorScheme.surface,const Color(0xff111827));
    expect(main.colorScheme.surface,isNot(const Color(0xff111827)));
    final inherited=applyPortalSectionThemes(main,{});
    expect(identical(portalSectionTheme(inherited,'footer'),inherited),true);
  });
}
