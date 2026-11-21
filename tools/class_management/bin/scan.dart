import 'dart:convert';
import 'dart:io';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:crypto/crypto.dart';
import 'package:path/path.dart' as p;
import 'package:primecare_class_management/registry.dart';

String hash(String value) => sha256.convert(utf8.encode(value)).toString();

/// Scan production Dart libraries using the real analyzer parser, never regex.
Map<String, dynamic> scanSource(String source, String path, String manager) {
  final parsed = parseString(content: source, throwIfDiagnostics: false);
  final classes = <Map<String, dynamic>>[];
  for (final node in parsed.unit.declarations) {
    String? name, kind, base, documentation;
    var abstract = false;
    final interfaces = <String>[], mixins = <String>[];
    if (node is ClassDeclaration) {
      name = node.namePart.typeName.lexeme;
      kind = 'class';
      abstract = node.abstractKeyword != null;
      base = node.extendsClause?.superclass.toSource() ?? 'Object';
      interfaces.addAll(
        node.implementsClause?.interfaces.map((type) => type.toSource()) ?? [],
      );
      mixins.addAll(
        node.withClause?.mixinTypes.map((type) => type.toSource()) ?? [],
      );
      final comment = node.documentationComment;
      documentation = comment == null
          ? null
          : source.substring(comment.offset, comment.end);
    } else if (node is ClassTypeAlias) {
      name = node.name.lexeme;
      kind = 'class_alias';
      base = node.superclass.toSource();
      abstract = node.abstractKeyword != null;
      final comment = node.documentationComment;
      documentation = comment == null
          ? null
          : source.substring(comment.offset, comment.end);
    } else if (node is MixinDeclaration) {
      name = node.name.lexeme;
      kind = 'mixin';
      final comment = node.documentationComment;
      documentation = comment == null
          ? null
          : source.substring(comment.offset, comment.end);
    } else if (node is EnumDeclaration) {
      name = node.namePart.typeName.lexeme;
      kind = 'enum';
      base = 'Enum';
      final comment = node.documentationComment;
      documentation = comment == null
          ? null
          : source.substring(comment.offset, comment.end);
    }
    if (name == null || name.isEmpty) continue;
    final id = 'dart:${hash('$path::$name')}';
    final tokens = <String>[];
    var token = node.beginToken;
    while (true) {
      tokens.add(token.lexeme);
      if (identical(token, node.endToken)) break;
      final next = token.next;
      if (next == null) break;
      token = next;
    }
    classes.add({
      'id': id,
      'name': name,
      'language': 'dart',
      'path': path,
      'kind': kind,
      'abstract': abstract,
      'private': name.startsWith('_'),
      'line': parsed.lineInfo.getLocation(node.offset).lineNumber,
      'sourceSha256': hash(source),
      'bodySha256': hash(tokens.join('\u0000')),
      'managerId': manager,
      'baseName': base,
      'interfaces': interfaces,
      'mixins': mixins,
      'scope':
          path
              .split('/')
              .any((part) => ['test', 'tests', 'fixtures'].contains(part))
          ? 'test'
          : 'source',
      'sourceDescription': documentation
          ?.replaceAll(RegExp(r'^\s*///\s?', multiLine: true), '')
          .trim(),
      'descriptionStatus': 'needs_review',
      'databaseStatus': 'unknown',
      'parseValid': parsed.errors.isEmpty,
    });
  }
  return {
    'classes': classes,
    'diagnostics': [
      for (final error in parsed.errors)
        {
          'path': path,
          'line': parsed.lineInfo.getLocation(error.offset).lineNumber,
          'code': error.diagnosticCode.lowerCaseName,
        },
    ],
  };
}

void main(List<String> args) {
  if (args.length != 2)
    throw ArgumentError('Usage: scan.dart REPOSITORY OUTPUT');
  final root = Directory(args[0]).absolute.path;
  final config =
      jsonDecode(
            File(
              p.join(root, 'tools/class_management/master_registry.json'),
            ).readAsStringSync(),
          )
          as Map<String, dynamic>;
  final registry = MasterClassManager.fromJson(config);
  final rows = <Map<String, dynamic>>[], diagnostics = <dynamic>[];
  var files = 0;
  for (final directory in [
    'apps',
    'packages',
    'services',
    'tools',
    'scripts',
    'cloudflare',
    'websites',
  ]) {
    final base = Directory(p.join(root, directory));
    if (!base.existsSync()) continue;
    for (final entity in base.listSync(recursive: true, followLinks: false)) {
      if (entity is! File || !entity.path.endsWith('.dart')) continue;
      final relative = p
          .relative(entity.path, from: root)
          .replaceAll('\\', '/');
      final parts = p.split(relative);
      if (parts.any(
        (part) =>
            ['build', '.dart_tool', 'node_modules', '.git'].contains(part),
      ))
        continue;
      final manager = registry.managerFor(relative);
      if (manager == null) throw FormatException('Unmanaged source: $relative');
      final result = scanSource(entity.readAsStringSync(), relative, manager);
      rows.addAll((result['classes'] as List).cast<Map<String, dynamic>>());
      diagnostics.addAll(result['diagnostics'] as List);
      files++;
    }
  }
  rows.sort((a, b) => (a['id'] as String).compareTo(b['id'] as String));
  final output = {
    'format': 1,
    'language': 'dart',
    'files': files,
    'complete': diagnostics.isEmpty,
    'classes': rows,
    'diagnostics': diagnostics,
    'registrySha256': hash(jsonEncode(config)),
  };
  File(args[1]).parent.createSync(recursive: true);
  File(args[1]).writeAsStringSync(jsonEncode(output));
  stdout.writeln(
    jsonEncode({
      'files': files,
      'classes': rows.length,
      'diagnostics': diagnostics.length,
    }),
  );
}
