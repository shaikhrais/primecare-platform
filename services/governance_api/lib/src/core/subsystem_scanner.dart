import 'dart:io';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:path/path.dart' as p;

/// [PlatformAuditResult] - Model representing the findings of a platform-wide audit.
class PlatformAuditResult {
  final Map<String, List<String>> services;
  final Map<String, List<String>> apps;
  final Map<String, List<String>> packages;
  final DateTime timestamp;

  PlatformAuditResult({
    required this.services,
    required this.apps,
    required this.packages,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() => {
    'services': services,
    'apps': apps,
    'packages': packages,
    'timestamp': timestamp.toIso8601String(),
  };
}

/// [IAuditScanner] - Interface for platform discovery and auditing.
abstract class IAuditScanner {
  PlatformAuditResult scanPlatform(String rootPath);
}

/// [SubsystemScanner] - Implementation of [IAuditScanner] using AST analysis.
class SubsystemScanner implements IAuditScanner {
  @override
  PlatformAuditResult scanPlatform(String rootPath) {
    return PlatformAuditResult(
      services: _scanDirectory(p.join(rootPath, 'services'), 'bin/server.dart'),
      apps: _scanDirectory(p.join(rootPath, 'apps'), 'lib/main.dart'),
      packages: _scanDirectory(p.join(rootPath, 'packages'), 'lib/*.dart', isPackage: true),
      timestamp: DateTime.now(),
    );
  }

  Map<String, List<String>> _scanDirectory(String dirPath, String entryPattern, {bool isPackage = false}) {
    final Map<String, List<String>> results = {};
    final dir = Directory(dirPath);
    
    if (dir.existsSync()) {
      for (var entity in dir.listSync()) {
        if (entity is Directory) {
          final name = p.basename(entity.path);
          
          if (isPackage) {
             // For packages, we look for exports in the main library file
             final libFile = File(p.join(entity.path, 'lib', '$name.dart'));
             if (libFile.existsSync()) {
               results[name] = _scanExports(libFile.path);
             }
          } else {
            // For services/apps, we look for routes
            final entryFile = File(p.join(entity.path, p.normalize(entryPattern)));
            if (entryFile.existsSync()) {
              results[name] = _scanRoutes(entryFile.path);
            }
          }
        }
      }
    }
    return results;
  }

  List<String> _scanRoutes(String filePath) {
    try {
      final file = File(filePath);
      final content = file.readAsStringSync();
      final result = parseString(content: content);
      
      final List<String> routes = [];
      final visitor = _RouteVisitor((path) => routes.add(path));
      result.unit.accept(visitor);

      return routes.toSet().toList();
    } catch (e) {
      return [];
    }
  }

  List<String> _scanExports(String filePath) {
    try {
      final file = File(filePath);
      final content = file.readAsStringSync();
      final result = parseString(content: content);
      
      final List<String> exports = [];
      final visitor = _ExportVisitor((path) => exports.add(path));
      result.unit.accept(visitor);

      return exports.toSet().toList();
    } catch (e) {
      return [];
    }
  }
}

class _RouteVisitor extends RecursiveAstVisitor<void> {
  final void Function(String) onRouteFound;
  _RouteVisitor(this.onRouteFound);

  @override
  void visitMethodInvocation(MethodInvocation node) {
    final methodName = node.methodName.name;
    const routeMethods = {'get', 'post', 'put', 'delete', 'patch', 'all', 'add'};
    
    if (routeMethods.contains(methodName)) {
      final args = node.argumentList.arguments;
      if (args.isNotEmpty) {
        final firstArg = args.first;
        if (firstArg is StringLiteral) {
          final path = firstArg.stringValue;
          if (path != null) onRouteFound(path);
        }
      }
    }
    super.visitMethodInvocation(node);
  }
}

class _ExportVisitor extends RecursiveAstVisitor<void> {
  final void Function(String) onExportFound;
  _ExportVisitor(this.onExportFound);

  @override
  void visitExportDirective(ExportDirective node) {
    onExportFound(node.uri.stringValue ?? '');
    super.visitExportDirective(node);
  }
}
