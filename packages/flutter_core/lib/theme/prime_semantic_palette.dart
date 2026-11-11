import 'package:flutter/material.dart';
import 'theme_contrast.dart';

/// Status roles shared with the UI theme without a dependency on its widgets.
@immutable
class PrimeSemanticStatusColors extends ThemeExtension<PrimeSemanticStatusColors> {
  final Color success, successContainer, warning, warningContainer;
  const PrimeSemanticStatusColors({required this.success,required this.successContainer,required this.warning,required this.warningContainer});
  @override PrimeSemanticStatusColors copyWith({Color? success,Color? successContainer,Color? warning,Color? warningContainer})=>PrimeSemanticStatusColors(success:success??this.success,successContainer:successContainer??this.successContainer,warning:warning??this.warning,warningContainer:warningContainer??this.warningContainer);
  @override PrimeSemanticStatusColors lerp(covariant PrimeSemanticStatusColors? other,double t)=>other==null ? this:PrimeSemanticStatusColors(success:Color.lerp(success,other.success,t)!,successContainer:Color.lerp(successContainer,other.successContainer,t)!,warning:Color.lerp(warning,other.warning,t)!,warningContainer:Color.lerp(warningContainer,other.warningContainer,t)!);
}
enum PrimeSemanticTone { primary,secondary,success,warning,error,muted }
class PrimeSemanticPalette {
  final Color accent,surface,onAccent,onSurface,onBase;
  PrimeSemanticPalette._(this.accent,this.surface,Color base,Color candidate)
      :onAccent=readableThemeForeground(accent,candidate),onSurface=readableThemeForeground(surface,accent),onBase=readableThemeForeground(base,accent);
  factory PrimeSemanticPalette.of(BuildContext context,PrimeSemanticTone tone) {
    final theme=Theme.of(context),c=theme.colorScheme;
    final status=theme.extension<PrimeSemanticStatusColors>();
    // A standalone Material host uses its category roles until it supplies
    // status tokens. The shared UI theme supplies its actual success/warning.
    final (accent,surface)=switch(tone) {
      PrimeSemanticTone.primary=>(c.primary,c.primaryContainer),
      PrimeSemanticTone.secondary=>(c.secondary,c.secondaryContainer),
      PrimeSemanticTone.success=>(status?.success??c.tertiary,status?.successContainer??c.tertiaryContainer),
      PrimeSemanticTone.warning=>(status?.warning??c.secondary,status?.warningContainer??c.secondaryContainer),
      PrimeSemanticTone.error=>(c.error,c.errorContainer),
      PrimeSemanticTone.muted=>(c.onSurfaceVariant,c.surfaceContainerHigh),
    };
    return PrimeSemanticPalette._(accent,Color.alphaBlend(surface,c.surface),c.surface,c.onSurface);
  }
  static Color tint(BuildContext context,Color color,{double alpha=.2})=>Color.alphaBlend(color.withValues(alpha:alpha),Theme.of(context).colorScheme.surface);
  static Color onTint(BuildContext context,Color color,{double alpha=.2})=>readableThemeForeground(tint(context,color,alpha:alpha),color);
}
