import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/theme/prime_shell_metrics.dart';
import 'package:flutter_core/workspace.dart';
void main() {
  for(final width in [390.0,820.0,959.0,960.0,1440.0]) {
    testWidgets('reference shell dimensions at $width px', (tester) async {
      tester.view.physicalSize=Size(width,1000);tester.view.devicePixelRatio=1;
      addTearDown(tester.view.resetPhysicalSize);addTearDown(tester.view.resetDevicePixelRatio);
      final c=WorkspaceController(scope:WorkspaceScope(tenant:'fixture',user:'fixture',role:'fixture'),panelIds:[]);
      addTearDown(c.dispose);c.patch({'navigation':'top','toolbar':'belowNavigation','footer':'sticky'});
      await tester.pumpWidget(MaterialApp(home:Scaffold(body:PrimeWorkspaceLayout(controller:c,
        navbarStyle:'fixed',toolbarExtent:PrimeShellMetrics.toolbarExtent(width,horizontal:true),footerExtent:PrimeShellMetrics.footerExtent(width),
        horizontalNavigationExtent:PrimeShellMetrics.horizontalNavbarHeight,
        navigation:const SizedBox(key:Key('nav')),toolbar:const SizedBox(key:Key('toolbar')),
        footer:const SizedBox(key:Key('footer')),main:const SizedBox(),panels:const {}))));
      await tester.pumpAndSettle();
      expect(tester.getSize(find.byKey(const Key('nav'))).height,64);
      expect(tester.getSize(find.byKey(const Key('toolbar'))).height,width>=960?65:49);
      expect(tester.getSize(find.byKey(const Key('footer'))).height,width>=960?65:49);
      expect(tester.takeException(),isNull);
    });
  }
}
