import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_layout/primecare_layout.dart';
void main() {
  test('breakpoint boundaries and grid sizing are preserved', () {
    expect([767,768,1024,1440,2560,3840,5120].map((w)=>ScreenBreakpoints.getTier(w.toDouble())), ResolutionTier.values);
    expect(ScreenBreakpoints.getTier(3840, pixelRatio: 4), ResolutionTier.mega);
    expect(ResolutionTier.values.map(AdaptiveScalingConfig.getGridColumns), [4,8,12,16,20,20,24]);
    expect(AdaptiveScalingConfig.getSidebarSpan(ResolutionTier.mob), 0);
    expect(AdaptiveScalingConfig.getScaleFactor(ResolutionTier.mega), 3.0);
  });
}
