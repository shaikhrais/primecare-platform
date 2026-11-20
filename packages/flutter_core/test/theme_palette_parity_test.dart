import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/theme/personal_theme.dart';
import 'package:flutter_core/theme/prime_palette_editor.dart';
import 'package:flutter_core/theme/theme_center_catalog_generated.dart';
import 'package:flutter_core/theme/theme_center_theme_data.dart';
import 'package:flutter_core/theme/theme_config_generated.dart';

void main(){
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
    final primary=find.byKey(const Key('palette-color-primary'));
    expect(tester.widget<TextField>(find.descendant(of:primary,matching:find.byType(TextField))).controller!.text,'#64b5f6');
    await tester.tap(find.text('Light'));await tester.pumpAndSettle();
    expect(tester.widget<TextField>(find.descendant(of:primary,matching:find.byType(TextField))).controller!.text,'#64b5f6');
    expect(tester.takeException(),isNull);
  });
}
