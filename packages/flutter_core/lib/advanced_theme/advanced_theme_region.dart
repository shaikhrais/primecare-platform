import 'package:flutter_core/theme/theme_color_codec.dart';
import 'package:primecare_ui_foundation/primecare_ui_foundation.dart' show PrimeElevatedButton, PrimeOutlinedButton, PrimeTextButton;
import 'package:flutter/material.dart';
import 'advanced_theme_model.dart';
Color _color(String hex)=>themeHexColor(themeHex(hex));
class AdvancedThemeTokens extends ThemeExtension<AdvancedThemeTokens> {
 final AdvancedTheme theme;final String region;
 const AdvancedThemeTokens(this.theme,this.region);
 double get spacing=>(theme.tokens['spacing']! as num).toDouble()*(theme.tokens['density']=='compact' ? 0.75 : 1.0);
 double get radius=>(theme.tokens['radius']! as num).toDouble();
 double get borderWidth=>(theme.tokens['borderWidth']! as num).toDouble();
 Map<String,Object> get preview=>themePalettePreview(theme.region(region));
 @override AdvancedThemeTokens copyWith({AdvancedTheme? theme,String? region})=>AdvancedThemeTokens(theme??this.theme,region??this.region);
 @override AdvancedThemeTokens lerp(covariant AdvancedThemeTokens? other,double t)=>other==null||t<.5?this:other;
}
ThemeData advancedThemeData(ThemeData base,AdvancedTheme theme,String region){final p=theme.region(region),preview=themePalettePreview(p),colors=preview['colors']! as Map<String,Object>,tokens=theme.tokens;
 Color color(String key)=>_color(p[key]! as String);Color on(String key)=>_color((colors[key]! as Map<String,String>)['on']!);
 final text=_color(preview['text']! as String),brightness=p['mode']=='dark'?Brightness.dark:Brightness.light,radius=(tokens['radius']! as num).toDouble();
 final shape=RoundedRectangleBorder(borderRadius:BorderRadius.circular(radius));
 final scheme=base.colorScheme.copyWith(brightness:brightness,primary:color('primary'),onPrimary:on('primary'),secondary:color('secondary'),onSecondary:on('secondary'),error:color('error'),onError:on('error'),surface:color('surface'),onSurface:text,onSurfaceVariant:text,outline:color('border'));
 return base.copyWith(brightness:brightness,colorScheme:scheme,scaffoldBackgroundColor:color('background'),textTheme:base.textTheme.apply(fontFamily:tokens['fontFamily']=='system'?null:tokens['fontFamily']! as String,fontSizeFactor:(tokens['fontScale']! as num).toDouble(),bodyColor:text,displayColor:text),iconTheme:base.iconTheme.copyWith(color:text),visualDensity:tokens['density']=='compact'?VisualDensity.compact:VisualDensity.standard,materialTapTargetSize:MaterialTapTargetSize.padded,textButtonTheme:TextButtonThemeData(style:PrimeTextButton.styleFrom(foregroundColor:text,minimumSize:const Size.square(kMinInteractiveDimension),shape:shape)),outlinedButtonTheme:OutlinedButtonThemeData(style:PrimeOutlinedButton.styleFrom(foregroundColor:text,backgroundColor:color('surface'),minimumSize:const Size.square(kMinInteractiveDimension),shape:shape)),elevatedButtonTheme:ElevatedButtonThemeData(style:PrimeElevatedButton.styleFrom(foregroundColor:text,backgroundColor:color('surface'),minimumSize:const Size.square(kMinInteractiveDimension),shape:shape)),filledButtonTheme:FilledButtonThemeData(style:FilledButton.styleFrom(foregroundColor:on('primary'),backgroundColor:color('primary'),minimumSize:const Size.square(kMinInteractiveDimension),shape:shape)),cardTheme:base.cardTheme.copyWith(color:color('surface'),shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(radius),side:BorderSide(color:color('border'),width:(tokens['borderWidth']! as num).toDouble()))),extensions:[...base.extensions.values.where((e)=>e is! AdvancedThemeTokens),AdvancedThemeTokens(theme,region)]);
}
class AdvancedThemeRegion extends StatelessWidget {
 final AdvancedTheme theme;final String region;final ThemeData base;final Widget child;
 const AdvancedThemeRegion({super.key,required this.theme,required this.region,required this.base,required this.child});
 @override Widget build(BuildContext context){final data=advancedThemeData(base,theme,region);return Theme(data:data,child:ColoredBox(color:_color(theme.region(region)['background']! as String),child:DefaultTextStyle(style:data.textTheme.bodyMedium!,child:child)));}
}
