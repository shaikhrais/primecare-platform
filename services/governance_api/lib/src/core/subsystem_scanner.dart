import 'dart:io';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:path/path.dart' as p;

class SubsystemScanner {
  /// Scans the entire platform for Dart APIs and their routes.
  static Map<String, List<String>> scanPlatform(String rootPath) {
    final Map<String, List<String>> platformMap = {};
    final servicesDir = Directory(p.join(rootPath, 'services'));
    
    if (servicesDir.existsSync()) {
      for (var entity in servicesDir.listSync()) {
        if (entity is Directory) {
          final serviceName = p.basename(entity.path);
          final serverFile = File(p.join(entity.path, 'bin', 'server.dart'));
          
          if (serverFile.existsSync()) {
            print('[SCANNER] Discovering routes for: $serviceName');
            platformMap[serviceName] = scanRoutes(serverFile.path);
          }
        }
      }
    }
    return platformMap;
  }

  /// Scans a specific Dart file for shelf_router route definitions using AST analysis.
  static List<String> scanRoutes(String filePath) {
    try {
      final file = File(filePath);
      if (!file.existsSync()) return [];

      final content = file.readAsStringSync();
      final result = parseString(content: content);
      
      final List<String> routes = [];
      final visitor = _RouteVisitor((path) => routes.add(path));
      result.unit.accept(visitor);

      return routes.toSet().toList(); 
    } catch (e) {
      print('[SCANNER] Error scanning routes in $filePath: $e');
      return [];
    }
  }
}

/// AST Visitor that identifies shelf_router path registrations.
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
          if (path != null) {
            onRouteFound(path);
          }
        }
      }
    }
    super.visitMethodInvocation(node);
  }
}
