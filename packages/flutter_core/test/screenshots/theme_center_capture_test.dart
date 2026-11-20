import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_core/auth_service.dart';
import 'package:flutter_core/providers/persistence_providers.dart';
import 'package:flutter_core/registry/widgets/theme_settings_drawer.dart';
import 'package:flutter_core/theme/personal_theme.dart';
import 'package:flutter_core/theme/theme_center_theme_data.dart';
import 'package:flutter_core/workspace/portal_workspace.dart';

class CaptureAuth extends AuthNotifier {
  @override AuthState build()=>AuthState(isAuthenticated:true,userId:'render-only',tenantId:'render-only',role:'admin',preferredLanguage:'en');
}
Future<void> loadFonts()async{
  final manifest=jsonDecode(await rootBundle.loadString('FontManifest.json')) as List<dynamic>;
  for(final row in manifest){
    final font=row as Map<String,dynamic>;final loader=FontLoader(font['family'] as String);
    for(final item in font['fonts'] as List<dynamic>){loader.addFont(rootBundle.load((item as Map<String,dynamic>)['asset'] as String));}
    await loader.load();
  }
  final sdk=Platform.environment['FLUTTER_ROOT'];
  if(sdk==null)throw StateError('FLUTTER_ROOT required for readable screenshot fonts');
  final directory=Directory('$sdk/bin/cache/artifacts/material_fonts');
  final regular=directory.listSync(recursive:true).whereType<File>().where((f)=>f.path.endsWith('Roboto-Regular.ttf')).first;
  final font=FontLoader('Roboto')..addFont(Future.value(ByteData.sublistView(regular.readAsBytesSync())));await font.load();
}
void main(){
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(loadFonts);
  for(final view in [('desktop',1440.0,1000.0),('tablet',820.0,1180.0),('mobile',390.0,844.0)]){
    testWidgets('capture actual Dart Theme Center ${view.$1}',(tester)async{
      tester.view.physicalSize=Size(view.$2,view.$3);tester.view.devicePixelRatio=1;
      addTearDown(tester.view.resetPhysicalSize);addTearDown(tester.view.resetDevicePixelRatio);
      SharedPreferences.setMockInitialValues({'auth_preferred_language':'en'});final preferences=await SharedPreferences.getInstance();
      final theme=applyPersonalThemeData(ThemeData(fontFamily:'Roboto',useMaterial3:true),PersonalTheme(name:'Render',preset:'navyTealPalette'));
      await tester.pumpWidget(ProviderScope(overrides:[sharedPreferencesProvider.overrideWithValue(preferences),authProvider.overrideWith(CaptureAuth.new)],child:MaterialApp(theme:theme,
        home:PortalWorkspace(scope:WorkspaceScope(tenant:'render-only',user:'render-only',role:'admin'),preferences:SharedWorkspacePreferences(preferences),legacyLayoutStyle:'verticalLeft',
          builder:(context,controller)=>Scaffold(body:Center(child:RepaintBoundary(key:const Key('capture-panel'),
            child:const ThemeSettingsDrawer(tenantDefaultPreset:'navyTealPalette'))))))));
      await tester.pumpAndSettle();expect(tester.takeException(),isNull);
      await expectLater(find.byKey(const Key('capture-panel')),matchesGoldenFile('captures/theme-center-${view.$1}.png'));
      final layout=find.text('WORKSPACE LAYOUT');
      await tester.scrollUntilVisible(layout,500,scrollable:find.byType(Scrollable).first);
      await tester.pumpAndSettle();expect(tester.takeException(),isNull);
      await expectLater(find.byKey(const Key('capture-panel')),matchesGoldenFile('captures/theme-layout-${view.$1}.png'));
    });
  }
}
