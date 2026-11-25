import 'package:primecare_ui_foundation/primecare_ui_foundation.dart' show PrimeFilledButton, PrimeTextButton, PrimeOutlinedButton;
import 'theme_color_codec.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

/// Central presentation metrics for the reference-sized theme configurator.
abstract final class PrimeThemeCenterStyle {
  static const fontFamily='packages/flutter_core/PrimeCareGeist';
  static const panelWidth=380.0;
  static const bodySize=13.0;
  static const controlHeight=32.0;
  static double inset(double width)=>width<600?16:24;
  static Color inputFill(ThemeData theme)=>theme.brightness==Brightness.dark?PrimeReferenceColors.black:PrimeReferenceColors.white;
  static Color inputBorder(ThemeData theme)=>(theme.brightness==Brightness.dark?PrimeReferenceColors.white:PrimeReferenceColors.black).withValues(alpha:.23);
  static ThemeData resolve(ThemeData base,{String family='system',double scale=1}){
    final font=family=='system'?fontFamily:family;
    TextStyle body(TextStyle? source)=> (source??const TextStyle()).copyWith(fontFamily:font,fontSize:bodySize*scale,height:1.5,letterSpacing:.12,fontFeatures:const [ui.FontFeature.enable('salt')]);
    final text=base.textTheme.copyWith(bodyLarge:body(base.textTheme.bodyLarge),bodyMedium:body(base.textTheme.bodyMedium),bodySmall:body(base.textTheme.bodySmall),
      labelLarge:body(base.textTheme.labelLarge),labelMedium:body(base.textTheme.labelMedium),labelSmall:body(base.textTheme.labelSmall),
      titleLarge:body(base.textTheme.titleLarge).copyWith(fontSize:18.57*scale,fontWeight:FontWeight.w600,height:1.6),
      titleMedium:body(base.textTheme.titleMedium).copyWith(fontSize:14.86*scale,fontWeight:FontWeight.w500));
    final outline=OutlineInputBorder(borderRadius:BorderRadius.circular(8),borderSide:BorderSide(color:inputBorder(base)));
    return base.copyWith(textTheme:text,splashFactory:NoSplash.splashFactory,visualDensity:VisualDensity.standard,materialTapTargetSize:MaterialTapTargetSize.shrinkWrap,radioTheme:base.radioTheme.copyWith(
      fillColor:WidgetStateProperty.resolveWith((states)=>states.contains(WidgetState.selected)?base.colorScheme.secondary:base.colorScheme.onSurfaceVariant),
      materialTapTargetSize:MaterialTapTargetSize.shrinkWrap,visualDensity:VisualDensity.compact),
      inputDecorationTheme:base.inputDecorationTheme.copyWith(filled:true,fillColor:inputFill(base),border:outline,enabledBorder:outline,focusedBorder:outline.copyWith(borderSide:BorderSide(color:base.colorScheme.secondary)),
        floatingLabelStyle:text.labelLarge?.copyWith(color:base.colorScheme.secondary),isDense:true,contentPadding:const EdgeInsets.symmetric(horizontal:12,vertical:6)),
      filledButtonTheme:FilledButtonThemeData(style:PrimeFilledButton.styleFrom(backgroundColor:base.colorScheme.secondary,foregroundColor:base.colorScheme.onSecondary,
        minimumSize:const Size(64,32),padding:const EdgeInsets.symmetric(horizontal:12,vertical:6),textStyle:text.labelLarge?.copyWith(fontWeight:FontWeight.w500),shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(8)))),
      textButtonTheme:TextButtonThemeData(style:PrimeTextButton.styleFrom(foregroundColor:base.colorScheme.onSurface,minimumSize:const Size(64,32),padding:const EdgeInsets.symmetric(horizontal:12,vertical:6),textStyle:text.labelLarge?.copyWith(fontWeight:FontWeight.w500),shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(8)))),
      outlinedButtonTheme:OutlinedButtonThemeData(style:PrimeOutlinedButton.styleFrom(minimumSize:const Size(64,32),textStyle:text.labelLarge?.copyWith(fontWeight:FontWeight.w500),shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(8)))));
  }
}
