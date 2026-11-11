import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/theme/theme_color_codec.dart';
import 'package:flutter_core/advanced_theme/advanced_theme_model.dart';
void main() {
 test('validated advanced-theme RGB preview colors retain opaque decoding', () {
  expect(themeHexColor('#12aBcD'),const Color(0xFF12ABCD));
  expect(themeHexColor('#000000'),const Color(0xFF000000));
  expect(themeHexColor('#FFFFFF'),const Color(0xFFFFFFFF));
  expect(themeHexColor(themeHex('#112233')),const Color(0xFF112233));
  for(final input in ['', '#', '#12345','#GGGGGG','112233','#00112233']) {
   expect(()=>themeHexColor(input),throwsFormatException,reason:input);
  }
 });
}
