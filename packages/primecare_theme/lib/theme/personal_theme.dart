import 'package:flutter/material.dart';
import 'theme_config_generated.dart';
import 'dart:convert';
import 'theme_center_catalog_generated.dart';

class PersonalTheme {
  final String name, preset, fontFamily;
  final double fontScale;
  final int radius;
  final Map<String, String> colors;
  PersonalTheme({required this.name, required this.preset, this.fontFamily = 'system', this.fontScale = 1, this.radius = 12, Map<String,String> colors = const {}}) : colors = Map.unmodifiable(colors);
  factory PersonalTheme.fromJson(Object? value) {
    if (value is! Map || value.length != 7 || !value.keys.toSet().containsAll(['version','name','preset','fontFamily','fontScale','radius','colors'])) throw const FormatException('Invalid theme');
    final name = value['name'], preset = value['preset'], font = value['fontFamily'], scale = value['fontScale'], radius = value['radius'], raw = value['colors'];
    if (value['version'] != 1 || name is! String || name.trim().isEmpty || name.trim().length > 60 || RegExp(r'[\x00-\x1f\x7f]').hasMatch(name) || preset is! String || !themeCenterPresetNames.contains(preset) || font is! String || !['system','serif','monospace'].contains(font) || scale is! num || !scale.isFinite || scale < .875 || scale > 1.5 || radius is! num || !radius.isFinite || radius != radius.roundToDouble() || radius < 0 || radius > 24 || raw is! Map) throw const FormatException('Invalid theme setting');
    final colors = <String,String>{};
    for (final entry in raw.entries) {
      if (entry.key is! String || !themeCenterColorKeys.contains(entry.key) || entry.value is! String || !RegExp(r'^#[0-9a-fA-F]{6}$').hasMatch(entry.value as String)) throw const FormatException('Invalid color');
      colors[entry.key as String] = (entry.value as String).toLowerCase();
    }
    Color color(String value)=>Color(int.parse(value.substring(1),radix:16)|0xff000000);
    final background=colors['background']==null?ThemeConfig.getAppPalette(preset).background:color(colors['background']!),surface=colors['surface']==null?ThemeConfig.getAppPalette(preset).surface:color(colors['surface']!);
    double ratio(Color a,Color b){final x=a.computeLuminance(),y=b.computeLuminance();return (x>y?(x+.05)/(y+.05):(y+.05)/(x+.05));}
    final candidates=[if(colors['text']!=null)color(colors['text']!),Colors.black,Colors.white];
    if(!candidates.any((c)=>ratio(c,background)>=4.5 && ratio(c,surface)>=4.5))throw const FormatException('Choose compatible backgrounds and readable text');
    return PersonalTheme(name:name.trim(),preset:preset,fontFamily:font,fontScale:scale.toDouble(),radius:radius.toInt(),colors:colors);
  }
  Map<String,Object> toJson() => {'version':1,'name':name,'preset':preset,'fontFamily':fontFamily,'fontScale':fontScale,'radius':radius,'colors':colors};
  PersonalTheme validated() => PersonalTheme.fromJson(toJson());
  PersonalTheme named(String value) => PersonalTheme.fromJson({...toJson(),'name':value});
  static PersonalTheme importJson(String text) {if(utf8.encode(text).length > 16384) throw const FormatException('Theme file too large');return PersonalTheme.fromJson(jsonDecode(text));}
  String exportJson() => const JsonEncoder.withIndent('  ').convert(validated().toJson());
}
