import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_theme/primecare_theme.dart';
void main() {
  test('shared shell color values preserve reference appearance', () {
    expect(PrimeShellMetrics.drawerScrimColor.toARGB32(), 0x80000000);
    expect(PrimeShellMetrics.accountMenuShadowFor(Brightness.light).toARGB32(), 0x7a000000);
    expect(PrimeShellMetrics.accountMenuShadowFor(Brightness.dark).toARGB32(), 0x66000000);
    expect(PrimeThemeCenterStyle.inputFill(ThemeData.light()).toARGB32(), 0xffffffff);
    expect(PrimeThemeCenterStyle.inputFill(ThemeData.dark()).toARGB32(), 0xff000000);
    expect(PrimeReferenceColors.fromArgb(255, 12, 34, 56).toARGB32(), 0xff0c2238);
    expect(themeHexColor('#0c2238').toARGB32(), 0xff0c2238);
  });
}
