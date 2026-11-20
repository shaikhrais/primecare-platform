import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_core/auth_service.dart';
import 'package:flutter_core/providers/persistence_providers.dart';
import 'package:flutter_core/theme/theme_settings_provider.dart';
import 'theme_center_test.dart' show TestThemeAuth;
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/theme/personal_theme.dart';
import 'package:flutter_core/theme/prime_palette_editor.dart';
import 'package:flutter_core/theme/theme_center_catalog_generated.dart';
import 'package:flutter_core/theme/theme_center_theme_data.dart';
import 'package:flutter_core/theme/theme_config_generated.dart';

void main(){
  test('all source combinations apply all regions atomically and survive reload',()async{
    SharedPreferences.setMockInitialValues({});final prefs=await SharedPreferences.getInstance();
    ProviderContainer create()=>ProviderContainer(overrides:[sharedPreferencesProvider.overrideWithValue(prefs),authProvider.overrideWith(()=>TestThemeAuth(AuthState(isAuthenticated:true,userId:'colors',tenantId:'tenant',role:'admin',preferredLanguage:'en')))]);
    final container=create();addTearDown(container.dispose);
    for(final entry in themeCenterColorCombinations.entries){
      await container.read(themeSettingsProvider.notifier).applyColorCombination(entry.key);
      final state=container.read(themeSettingsProvider);
      expect(state.theme.preset,entry.value['main']);
      for(final part in ['navbar','toolbar','footer'])expect(state.sectionThemes[part]!.preset,entry.value[part]);
    }
    final restored=create();addTearDown(restored.dispose);
    expect(restored.read(themeSettingsProvider).toJson(),container.read(themeSettingsProvider).toJson());
  });
  test('all 39 palettes supply semantic colors and switch brightness',(){
    expect(themeCenterPresetNames.length,39);
    for(final name in themeCenterPresetNames){
      final palette=ThemeConfig.getAppPalette(name);
      final theme=applyPersonalThemeData(ThemeData(),PersonalTheme(name:'Test',preset:name).validated());
      expect(theme.brightness,palette.brightness,reason:name);
      expect(theme.extension<PrimePaletteTokens>()!['success.main'],palette.token('success.main'),reason:name);
      expect(theme.hoverColor,palette.token('action.hover'),reason:name);
      expect(theme.colorScheme.error,palette.token('error.main'),reason:name);
    }
    expect(ThemeConfig.getAppPalette('navyTealPalette').primary,const Color(0xff0f3c6e));
    expect(ThemeConfig.getAppPalette('defaultDark').token('action.hover'),const Color(0x14ffffff));
  });
  testWidgets('day and night keep the selected source color combination',(tester)async{
    await tester.pumpWidget(MaterialApp(home:PrimePaletteEditor(section:'main',initial:PersonalTheme(name:'Sky',preset:'skyBlueOrange'))));
    await tester.tap(find.text('Dark'));await tester.pumpAndSettle();
    expect(tester.widget<TextField>(find.byKey(const Key('palette-color-background'))).controller!.text,'#121212');
    final primary=find.byKey(const Key('palette-color-primary'));
    expect(tester.widget<TextField>(primary).controller!.text,'#64b5f6');
    await tester.tap(find.text('Light'));await tester.pumpAndSettle();
    expect(tester.widget<TextField>(primary).controller!.text,'#64b5f6');
    expect(tester.takeException(),isNull);
  });
}
