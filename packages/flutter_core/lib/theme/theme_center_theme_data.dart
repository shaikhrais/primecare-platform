import 'package:flutter/material.dart';
import 'app_theme.dart';
import 'personal_theme.dart';
import 'theme_config_generated.dart';

ThemeData applyPersonalThemeData(ThemeData baseTheme,PersonalTheme personal) {
    Color? parseHexColor(String? value) => value != null && RegExp(r'^#[0-9a-fA-F]{6}$').hasMatch(value) ? Color(int.parse(value.substring(1),radix:16) | 0xff000000) : null;
    Color foreground(Color background,Color candidate) {
      double contrast(Color text) {final a=text.computeLuminance(),b=background.computeLuminance();return (a>b?(a+.05)/(b+.05):(b+.05)/(a+.05));}
      if(contrast(candidate)>=4.5)return candidate;return contrast(Colors.black)>=contrast(Colors.white)?Colors.black:Colors.white;
    }
    final style=personal;
    final palette = ThemeConfig.getAppPalette(style.preset);
    Color resolved(String key,Color fallback) => parseHexColor(style.colors[key]) ?? fallback;
    final resolvedPrimary=resolved('primary',palette.primary),resolvedPrimaryContainer=resolved('primaryContainer',palette.primaryContainer),resolvedSidebarBg=resolved('sidebar',palette.sidebarBackground),resolvedTopbarBg=resolved('topbar',palette.topbarBackground),background=resolved('background',palette.background),surface=resolved('surface',palette.surface),text=resolved('text',palette.textPrimary),muted=resolved('muted',palette.textSecondary),border=resolved('border',palette.divider);
    
    Color commonForeground(Color candidate) {double ratio(Color a,Color b){final x=a.computeLuminance(),y=b.computeLuminance();return (x>y?(x+.05)/(y+.05):(y+.05)/(x+.05));}return [candidate,Colors.black,Colors.white].firstWhere((c)=>ratio(c,background)>=4.5 && ratio(c,surface)>=4.5);}
    final readable=commonForeground(text),readableMuted=commonForeground(muted);
    final fontFamily=style.fontFamily=='system'?null:style.fontFamily;
    final seed=ThemeData(brightness:palette.brightness).textTheme;
    TextStyle sized(TextStyle? original,TextStyle? fallback)=>(original ?? fallback ?? const TextStyle()).copyWith(fontSize:original?.fontSize ?? fallback?.fontSize ?? 14);
    final completeText=TextTheme(
      displayLarge:sized(baseTheme.textTheme.displayLarge,seed.displayLarge),
      displayMedium:sized(baseTheme.textTheme.displayMedium,seed.displayMedium),
      displaySmall:sized(baseTheme.textTheme.displaySmall,seed.displaySmall),
      headlineLarge:sized(baseTheme.textTheme.headlineLarge,seed.headlineLarge),
      headlineMedium:sized(baseTheme.textTheme.headlineMedium,seed.headlineMedium),
      headlineSmall:sized(baseTheme.textTheme.headlineSmall,seed.headlineSmall),
      titleLarge:sized(baseTheme.textTheme.titleLarge,seed.titleLarge),
      titleMedium:sized(baseTheme.textTheme.titleMedium,seed.titleMedium),
      titleSmall:sized(baseTheme.textTheme.titleSmall,seed.titleSmall),
      bodyLarge:sized(baseTheme.textTheme.bodyLarge,seed.bodyLarge),
      bodyMedium:sized(baseTheme.textTheme.bodyMedium,seed.bodyMedium),
      bodySmall:sized(baseTheme.textTheme.bodySmall,seed.bodySmall),
      labelLarge:sized(baseTheme.textTheme.labelLarge,seed.labelLarge),
      labelMedium:sized(baseTheme.textTheme.labelMedium,seed.labelMedium),
      labelSmall:sized(baseTheme.textTheme.labelSmall,seed.labelSmall),
    );
    return baseTheme.copyWith(
      primaryColor:resolvedPrimary,scaffoldBackgroundColor:background,dividerColor:border,hintColor:readableMuted,
      textTheme:completeText.apply(fontFamily:fontFamily,fontSizeFactor:style.fontScale,bodyColor:readable,displayColor:readable),
      cardTheme:CardThemeData(shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(style.radius.toDouble()))),
      inputDecorationTheme:baseTheme.inputDecorationTheme.copyWith(border:OutlineInputBorder(borderRadius:BorderRadius.circular(style.radius.toDouble()))),
      filledButtonTheme:FilledButtonThemeData(style:FilledButton.styleFrom(shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(style.radius.toDouble())))),
      outlinedButtonTheme:OutlinedButtonThemeData(style:OutlinedButton.styleFrom(shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(style.radius.toDouble())))),
      textButtonTheme:TextButtonThemeData(style:TextButton.styleFrom(shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(style.radius.toDouble())))),
      elevatedButtonTheme:ElevatedButtonThemeData(style:ElevatedButton.styleFrom(shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(style.radius.toDouble())))),
      colorScheme:baseTheme.colorScheme.copyWith(brightness:palette.brightness,primary:resolvedPrimary,onPrimary:foreground(resolvedPrimary,palette.onPrimary),primaryContainer:resolvedPrimaryContainer,secondary:resolved('secondary',palette.secondary),surface:surface,onSurface:readable,onSurfaceVariant:readableMuted,outline:border),
      extensions:[...baseTheme.extensions.values.where((e)=>e is! GovernanceThemeColors),GovernanceThemeColors(sidebarBackground:resolvedSidebarBg,topbarBackground:resolvedTopbarBg,sidebarTextColor:foreground(resolvedSidebarBg,muted),sidebarSelectedTextColor:foreground(surface,text),sidebarIconColor:foreground(resolvedSidebarBg,muted),sidebarSelectedIconColor:foreground(surface,text),sidebarSelectedTileColor:surface,sidebarDividerColor:border,topbarTextColor:foreground(resolvedTopbarBg,muted),topbarSelectedTextColor:foreground(resolvedTopbarBg,text),topbarIconColor:foreground(resolvedTopbarBg,muted),topbarSelectedIconColor:foreground(resolvedTopbarBg,text),topbarDividerColor:border)],
    );

}
