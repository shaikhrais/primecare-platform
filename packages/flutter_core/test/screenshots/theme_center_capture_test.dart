import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_core/auth_service.dart';
import 'package:flutter_core/providers/persistence_providers.dart';
import 'package:flutter_core/registry/widgets/theme_settings_drawer.dart';
import 'package:flutter_core/theme/personal_theme.dart';
import 'package:flutter_core/theme/theme_settings_provider.dart';
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
  final geist=FontLoader('packages/flutter_core/PrimeCareGeist')..addFont(rootBundle.load('assets/fonts/Geist-VariableFont_wght.ttf'));await geist.load();
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
    for(final mode in ['light','dark']){
    testWidgets('capture actual Dart Theme Center ${view.$1} $mode',(tester)async{
      debugDefaultTargetPlatformOverride=view.$1=='desktop'?TargetPlatform.linux:TargetPlatform.android;
      try {
      tester.view.physicalSize=Size(view.$2,view.$3);tester.view.devicePixelRatio=1;
      addTearDown(tester.view.resetPhysicalSize);addTearDown(tester.view.resetDevicePixelRatio);
      final auth=AuthState(isAuthenticated:true,userId:'render-only',tenantId:'render-only',role:'admin',preferredLanguage:'en');
      final preset=mode=='dark'?'defaultDark':'default';
      final appearance=ThemeSettingsState(layoutStyle:LayoutStyle.verticalLeft,presetName:preset,customScrollbars:true,direction:TextDirection.ltr,
        sectionThemes:mode=='light'?{'navbar':PersonalTheme(name:'Navbar reference',preset:'defaultNavbar')}:const {});
      SharedPreferences.setMockInitialValues({'auth_preferred_language':'en','theme_center_settings_v1:${themeAccountScope(auth)}':jsonEncode(appearance.toJson())});final preferences=await SharedPreferences.getInstance();
      final theme=applyPersonalThemeData(ThemeData(fontFamily:'Roboto',useMaterial3:true),PersonalTheme(name:'Render',preset:preset));
      await tester.pumpWidget(ProviderScope(overrides:[sharedPreferencesProvider.overrideWithValue(preferences),authProvider.overrideWith(CaptureAuth.new)],child:MaterialApp(theme:theme,
        home:PortalWorkspace(scope:WorkspaceScope(tenant:'render-only',user:'render-only',role:'admin'),preferences:SharedWorkspacePreferences(preferences),legacyLayoutStyle:'verticalLeft',
          builder:(context,controller)=>Scaffold(body:Center(child:RepaintBoundary(key:const Key('capture-panel'),
            child:const ThemeSettingsDrawer(tenantDefaultPreset:'navyTealPalette'))))))));
      await tester.pumpAndSettle();
      PortalWorkspaceScope.maybeOf(tester.element(find.byType(ThemeSettingsDrawer)))!.patch({'container':'content','maxWidth':1120,'navigationWidth':248,'footer':'sticky'});
      await tester.pumpAndSettle();expect(tester.takeException(),isNull);
      final suffix=mode=='dark'?'-dark':'';
      final frame=tester.getRect(find.byWidgetPredicate((widget)=>widget is Drawer));
      Map<String,double> box(Finder finder){final rect=tester.getRect(finder);return {'x':rect.left-frame.left,'y':rect.top-frame.top,'width':rect.width,'height':rect.height};}
      final metrics=<String,Object>{'device':view.$1,'mode':mode,'drawer':{'width':frame.width,'height':frame.height},'title':box(find.text('Theme Settings')),'layoutLegend':box(find.text('Layout',skipOffstage:false).first)};
      Directory('test/screenshots/captures').createSync(recursive:true);
      File('test/screenshots/captures/primecare-metrics-${view.$1}-$mode.json').writeAsStringSync(jsonEncode(metrics));
      await expectLater(find.byKey(const Key('capture-panel')),matchesGoldenFile('captures/theme-layout-${view.$1}$suffix.png'));
      final layout=find.byKey(const Key('theme-settings-palette'));
      await tester.scrollUntilVisible(layout,500,scrollable:find.byType(Scrollable).first);
      await tester.pumpAndSettle();expect(tester.takeException(),isNull);
      await Scrollable.ensureVisible(tester.element(layout),alignment:0);
      await tester.pumpAndSettle();
      await expectLater(find.byKey(const Key('capture-panel')),matchesGoldenFile('captures/theme-center-${view.$1}$suffix.png'));
      if(view.$1=='desktop'){
        await tester.tap(find.byKey(const Key('palette-main')));await tester.pumpAndSettle();
        expect(tester.takeException(),isNull);
        final editor=tester.getRect(find.byKey(const Key('palette-editor-capture')));
        File('test/screenshots/captures/primecare-editor-$mode.json').writeAsStringSync(jsonEncode({'width':editor.width,'height':editor.height}));
        await expectLater(find.byKey(const Key('palette-editor-capture')),matchesGoldenFile('captures/palette-editor-desktop$suffix.png'));
      }
      } finally { debugDefaultTargetPlatformOverride=null; }
    });
    }
  }
}
