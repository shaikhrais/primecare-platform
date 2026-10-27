import 'package:flutter/material.dart';
import 'app_theme.dart';
import 'personal_theme.dart';
import 'theme_config_generated.dart';
import 'theme_contrast.dart';

ThemeData applyPersonalThemeData(ThemeData baseTheme,PersonalTheme personal) {
    Color? parseHexColor(String? value) => value != null && RegExp(r'^#[0-9a-fA-F]{6}$').hasMatch(value) ? Color(int.parse(value.substring(1),radix:16) | 0xff000000) : null;
    Color foreground(Color background,Color candidate) => readableThemeForeground(background,candidate);
    final style=personal;
    final palette = ThemeConfig.getAppPalette(style.preset);
    Color resolved(String key,Color fallback) => parseHexColor(style.colors[key]) ?? fallback;
    final resolvedPrimary=resolved('primary',palette.primary),resolvedPrimaryContainer=resolved('primaryContainer',palette.primaryContainer),resolvedSidebarBg=resolved('sidebar',palette.sidebarBackground),resolvedTopbarBg=resolved('topbar',palette.topbarBackground),resolvedSecondary=resolved('secondary',palette.secondary),background=resolved('background',palette.background),surface=resolved('surface',palette.surface),text=resolved('text',palette.textPrimary),muted=resolved('muted',palette.textSecondary),border=resolved('border',palette.divider);
    
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
      cardTheme:baseTheme.cardTheme.copyWith(color:surface,elevation:0,surfaceTintColor:Colors.transparent,shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(style.radius.toDouble()),side:BorderSide(color:border))),
      appBarTheme:baseTheme.appBarTheme.copyWith(backgroundColor:resolvedTopbarBg,foregroundColor:foreground(resolvedTopbarBg,text),elevation:0,scrolledUnderElevation:0,surfaceTintColor:Colors.transparent),
      iconTheme:baseTheme.iconTheme.copyWith(color:readable),
      inputDecorationTheme:baseTheme.inputDecorationTheme.copyWith(fillColor:surface,labelStyle:TextStyle(color:readableMuted),hintStyle:TextStyle(color:readableMuted),border:OutlineInputBorder(borderRadius:BorderRadius.circular(style.radius.toDouble()),borderSide:BorderSide(color:border)),enabledBorder:OutlineInputBorder(borderRadius:BorderRadius.circular(style.radius.toDouble()),borderSide:BorderSide(color:border)),focusedBorder:OutlineInputBorder(borderRadius:BorderRadius.circular(style.radius.toDouble()),borderSide:BorderSide(color:foreground(surface,resolvedPrimary),width:2)),floatingLabelStyle:TextStyle(color:foreground(surface,resolvedPrimary))),
      filledButtonTheme:FilledButtonThemeData(style:FilledButton.styleFrom(shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(style.radius.toDouble())))),
      outlinedButtonTheme:OutlinedButtonThemeData(style:OutlinedButton.styleFrom(shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(style.radius.toDouble())))),
      textButtonTheme:TextButtonThemeData(style:TextButton.styleFrom(shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(style.radius.toDouble())))),
      elevatedButtonTheme:ElevatedButtonThemeData(style:ElevatedButton.styleFrom(shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(style.radius.toDouble())))),
      colorScheme:ColorScheme.fromSeed(seedColor:resolvedPrimary,brightness:palette.brightness).copyWith(primary:resolvedPrimary,onPrimary:foreground(resolvedPrimary,palette.onPrimary),primaryContainer:resolvedPrimaryContainer,onPrimaryContainer:foreground(resolvedPrimaryContainer,text),secondary:resolvedSecondary,onSecondary:foreground(resolvedSecondary,palette.onSecondary),surface:surface,surfaceContainerLowest:surface,surfaceContainerLow:surface,surfaceContainer:surface,surfaceContainerHigh:surface,surfaceContainerHighest:surface,surfaceDim:surface,surfaceBright:surface,onSurface:readable,onSurfaceVariant:readableMuted,outline:border),
      extensions:[...baseTheme.extensions.values.where((e)=>e is! GovernanceThemeColors),GovernanceThemeColors(sidebarBackground:resolvedSidebarBg,topbarBackground:resolvedTopbarBg,sidebarTextColor:foreground(resolvedSidebarBg,muted),sidebarSelectedTextColor:foreground(surface,text),sidebarIconColor:foreground(resolvedSidebarBg,muted),sidebarSelectedIconColor:foreground(surface,text),sidebarSelectedTileColor:surface,sidebarDividerColor:border,topbarTextColor:foreground(resolvedTopbarBg,muted),topbarSelectedTextColor:foreground(resolvedTopbarBg,text),topbarIconColor:foreground(resolvedTopbarBg,muted),topbarSelectedIconColor:foreground(resolvedTopbarBg,text),topbarDividerColor:border)],
    );

}
