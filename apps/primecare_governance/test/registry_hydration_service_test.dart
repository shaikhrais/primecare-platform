import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:primecare_governance/governance/services/ast_patch_engine.dart';
import 'package:primecare_governance/governance/services/registry_hydration_service.dart';

void main() {
  late Directory root;
  late RegistryHydrationService service;
  const screen = ScreenMetadata(id: 'fixture.source', title: 'Fixture',
    route: '/fixture', sourcePath: 'lib/source.dart', roles: ['fixture']);
  setUp(() async {
    root = await Directory.systemTemp.createTemp('source-observation-');
    Directory('${root.path}/lib').createSync();
    File('${root.path}/lib/source.dart').writeAsStringSync('''
class SourceView {
  bool get isTranslationVerified => true;
  bool get isMobileVerified => true;
  bool get isDesktopVerified => true;
  bool get isSecurityVerified => true;
  List<String> get translationKeys => ['fixture.title'];
}
''');
    service = RegistryHydrationService(projectRoot: root.path,
      astEngine: ASTPatchEngine(root.path));
  });
  tearDown(() async => root.delete(recursive: true));

  test('true source declarations cannot certify metadata or rewrite files', () async {
    final before = screen.toJson();
    final source = File('${root.path}/lib/source.dart').readAsStringSync();
    final result = await service.performHydrationSweep(screens: [screen]);
    expect(result['hydrated'], 0);
    expect(result['observed'], 1);
    expect(result['pending'], 1);
    expect(result['mutationsAttempted'], isFalse);
    final attributes = result['sourceDeclarations'][screen.id] as Map;
    expect(attributes['isMobileVerified'], isTrue);
    expect(screen.isMobileVerified, isFalse);
    expect(screen.isDesktopVerified, isFalse);
    expect(screen.isSecurityVerified, isFalse);
    expect(screen.toJson(), before);
    expect(File('${root.path}/lib/source.dart').readAsStringSync(), source);
    expect(root.listSync(recursive: true).whereType<File>().length, 1);
    expect(() => attributes['isMobileVerified'] = false, throwsUnsupportedError);
    expect(() => (attributes['translationKeys'] as List).clear(), throwsUnsupportedError);
  });

  test('missing registered paths never fall back to a guessed implementation', () async {
    final result = await service.performHydrationSweep(screens: [screen.copyWith(sourcePath: '')]);
    expect(result['observed'], 0);
    expect(result['failed'], 1);
    expect(result['pending'], 1);
    expect(result['hydrated'], 0);
  });

  test('source traversal and symlinks outside the project remain unavailable', () async {
    final outside = await Directory.systemTemp.createTemp('outside-observation-');
    addTearDown(() => outside.delete(recursive: true));
    final file = File('${outside.path}/source.dart')..writeAsStringSync('class SourceView {}');
    Link('${root.path}/lib/linked.dart').createSync(file.path);
    final result = await service.performHydrationSweep(screens: [
      screen.copyWith(sourcePath: '../${outside.uri.pathSegments.where((s) => s.isNotEmpty).last}/source.dart'),
      screen.copyWith(id: 'fixture.linked', sourcePath: 'lib/linked.dart'),
    ]);
    expect(result['failed'], 2);
    expect(result['observed'], 0);
    expect(result['hydrated'], 0);
    expect(result['mutationsAttempted'], isFalse);
  });

  test('empty and unavailable observations remain explicitly pending', () async {
    final empty = await service.performHydrationSweep(screens: []);
    expect(empty['total'], 0);
    expect(empty['hydrated'], 0);
    File('${root.path}/lib/source.dart').writeAsStringSync('class OtherView {}');
    final result = await service.performHydrationSweep(screens: [screen]);
    expect(result['observed'], 0);
    expect(result['pending'], 1);
    expect(result['details'][screen.id], contains('No declarations found'));
  });
}
