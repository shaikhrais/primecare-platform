import 'dart:io';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:path/path.dart' as p;

/// [ASTPatchEngine] - A high-fidelity remediation engine that uses AST parsing
/// to safely modify architectural registries without breaking code integrity.
class ASTPatchEngine {
  final String projectRoot;

  ASTPatchEngine(this.projectRoot);

  /// Safely injects a new screen entry into a domain registry.
  Future<bool> injectScreenConstant({
    required String registryPath,
    required String className,
    required String screenId,
    required Map<String, dynamic> metadata,
    String mapName = 'screens',
    bool overwrite = false,
  }) async {
    final fullPath = p.join(projectRoot, registryPath);
    final file = File(fullPath);
    if (!await file.exists()) return false;

    final content = await file.readAsString();
    final result = parseString(content: content);
    final unit = result.unit;

    final visitor = _RegistryVisitor(className: className, mapName: mapName);
    unit.accept(visitor);

    if (visitor.registryClass == null || visitor.targetMap == null) return false;

    // Check if entry already exists
    final entryExists = content.contains("'$screenId':");
    if (entryExists && !overwrite) {
      return true;
    }

    // 1. Build the ScreenMetadata object string
    final buffer = StringBuffer();
    buffer.writeln("    '$screenId': const ScreenMetadata(");
    metadata.forEach((key, value) {
      if (value is String) {
        if (value.startsWith('LifecycleStatus.') || value.startsWith('Icons.') || value.startsWith('PriorityLevel.') || value.startsWith('SecurityTier.') || value.startsWith('DataMode.')) {
          buffer.writeln("      $key: $value,");
        } else if (value == 'true' || value == 'false') {
          buffer.writeln("      $key: $value,");
        } else {
          buffer.writeln("      $key: '$value',");
        }
      } else if (value is List) {
        final listStr = value.map((e) => "'$e'").join(', ');
        buffer.writeln("      $key: [$listStr],");
      } else {
        buffer.writeln("      $key: $value,");
      }
    });
    buffer.writeln("    ),");

    String updatedContent;
    if (entryExists && overwrite) {
      final startMatch = "'$screenId': const ScreenMetadata(";
      final startIndex = content.indexOf(startMatch);
      if (startIndex == -1) return false;
      
      int endIndex = content.indexOf("),", startIndex);
      if (endIndex == -1) return false;
      endIndex += 2; 

      updatedContent = content.substring(0, startIndex) + buffer.toString() + content.substring(endIndex);
    } else {
      final mapEnd = visitor.targetMap!.rightBracket.offset;
      updatedContent = content.substring(0, mapEnd) + buffer.toString() + content.substring(mapEnd);
    }

    await file.writeAsString(updatedContent);
    return true;
  }

  /// Safely injects multiple cases into a switch statement within a provider.
  Future<bool> batchInjectSwitchCases(
    List<({String enumValue, String returnValue})> cases, {
    required String filePath,
    required String variableName,
  }) async {
    final fullPath = p.join(projectRoot, filePath);
    final file = File(fullPath);
    if (!await file.exists()) return false;

    String content = await file.readAsString();
    
    for (final c in cases) {
      final result = parseString(content: content);
      final visitor = _SwitchVisitor(variableName);
      result.unit.accept(visitor);

      if (visitor.targetSwitch == null) continue;

      // Check if case already exists
      bool exists = false;
      for (final member in visitor.targetSwitch!.members) {
        if (member is SwitchCase) {
          if (member.expression.toString() == c.enumValue) {
            exists = true;
            break;
          }
        } else if (member is SwitchPatternCase) {
          final pattern = member.guardedPattern.pattern;
          if (pattern is ConstantPattern && pattern.expression.toString() == c.enumValue) {
            exists = true;
            break;
          }
        }
      }
      if (exists) continue;

      int insertOffset = visitor.targetSwitch!.rightBracket.offset;
      for (final member in visitor.targetSwitch!.members) {
        if (member is SwitchDefault) {
          insertOffset = member.offset;
          break;
        }
      }

      final newCase = "    case ${c.enumValue}:\n      return ${c.returnValue};\n";
      content = content.substring(0, insertOffset) + newCase + content.substring(insertOffset);
    }
    
    await file.writeAsString(content);
    return true;
  }

  /// Updates metadata for a specific entry in a registry.
  Future<bool> updateRegistryMetadata(String entryKey, Map<String, String> updates, {
    String registryPath = 'apps/primecare_governance/lib/core/governance/screen_registry.dart',
    String className = 'ScreenRegistry',
    String mapName = 'screens',
  }) async {
    final fullPath = p.join(projectRoot, registryPath);
    final file = File(fullPath);
    if (!await file.exists()) return false;

    final content = await file.readAsString();
    final result = parseString(content: content);
    final unit = result.unit;

    final visitor = _RegistryVisitor(className: className, mapName: mapName);
    unit.accept(visitor);

    if (visitor.targetMap == null) return false;

    // Find the specific entry for entryKey
    for (final element in visitor.targetMap!.elements) {
      if (element is MapLiteralEntry) {
        final key = element.key;
        if (key is SimpleStringLiteral && key.value == entryKey) {
          final value = element.value;
          if (value is InstanceCreationExpression) {
            // final args = value.argumentList;
            String updatedContent = content;
            for (final update in updates.entries) {
              // Re-parse to get fresh offsets after each update
              final freshResult = parseString(content: updatedContent);
              final freshUnit = freshResult.unit;
              final freshVisitor = _RegistryVisitor(className: className, mapName: mapName);
              freshUnit.accept(freshVisitor);
              
              final freshMap = freshVisitor.targetMap;
              if (freshMap == null) break;
              
              InstanceCreationExpression? freshTarget;
              for (final element in freshMap.elements) {
                if (element is MapLiteralEntry) {
                  final key = element.key;
                  if (key is SimpleStringLiteral && key.value == entryKey) {
                    final value = element.value;
                    if (value is InstanceCreationExpression) {
                      freshTarget = value;
                      break;
                    }
                  }
                }
              }

              if (freshTarget != null) {
                updatedContent = _updateArgument(updatedContent, freshTarget.argumentList, update.key, update.value);
              }
            }

            if (updatedContent != content) {
              await file.writeAsString(updatedContent);
              return true;
            }
          }
        }
      }
    }

    return false;
  }

  /// Updates metadata for a specific screen in screen_registry.dart. (Legacy wrapper)
  Future<bool> updateScreenMetadata(String screenId, {
    bool? isRenderOk, 
    String? lifecycleStatus,
    int? storyPoints,
    String? lastAuditDate,
  }) async {
    final updates = <String, String>{};
    if (isRenderOk != null) updates['isRenderOk'] = isRenderOk.toString();
    if (lifecycleStatus != null) updates['lifecycleStatus'] = 'LifecycleStatus.$lifecycleStatus';
    if (storyPoints != null) updates['storyPoints'] = storyPoints.toString();
    if (lastAuditDate != null) updates['lastAuditDate'] = "'$lastAuditDate'";
    
    return updateRegistryMetadata(
      screenId,
      updates,
      registryPath: 'apps/primecare_governance/lib/core/governance/screen_registry.dart',
      className: 'ScreenRegistry',
      mapName: 'screens',
    );
  }

  String _updateArgument(String content, ArgumentList args, String name, String newValue) {
    for (final arg in args.arguments) {
      if (arg is NamedExpression && arg.name.label.name == name) {
        // Update existing argument
        final offset = arg.expression.offset;
        final length = arg.expression.length;
        return content.substring(0, offset) + newValue + content.substring(offset + length);
      }
    }
    
    // If not found, append to the argument list
    final closingParen = args.rightParenthesis.offset;
    final hasArgs = args.arguments.isNotEmpty;
    final prefix = hasArgs ? ", " : "";
    final newArg = "$prefix$name: $newValue";
    
    return content.substring(0, closingParen) + newArg + content.substring(closingParen);
  }

  /// Safely injects a new case into a switch statement within a provider.
  Future<bool> injectSwitchCase(String enumValue, String returnValue, {
    required String filePath,
    required String variableName,
  }) async {
    final fullPath = p.join(projectRoot, filePath);
    final file = File(fullPath);
    if (!await file.exists()) return false;

    final content = await file.readAsString();
    final result = parseString(content: content);
    final unit = result.unit;

    final visitor = _SwitchVisitor(variableName);
    unit.accept(visitor);

    if (visitor.targetSwitch == null) return false;

    // Check if case already exists
    bool exists = false;
    for (final member in visitor.targetSwitch!.members) {
      if (member is SwitchCase) {
        if (member.expression.toString() == enumValue) {
          exists = true;
          break;
        }
      } else if (member is SwitchPatternCase) {
        final pattern = member.guardedPattern.pattern;
        if (pattern is ConstantPattern && pattern.expression.toString() == enumValue) {
          exists = true;
          break;
        }
      }
    }
    if (exists) return true;

    // Inject the new case before the default case
    int insertOffset = visitor.targetSwitch!.rightBracket.offset;
    for (final member in visitor.targetSwitch!.members) {
      if (member is SwitchDefault) {
        insertOffset = member.offset;
        break;
      }
    }

    final newCase = "    case $enumValue:\n      return $returnValue;\n";
    
    // Ensure we don't mess up the indentation or structure
    String updatedContent = content.substring(0, insertOffset) + newCase + content.substring(insertOffset);
    
    await file.writeAsString(updatedContent);
    return true;
  }
}

class _RegistryVisitor extends RecursiveAstVisitor<void> {
  final String className;
  final String mapName;
  ClassDeclaration? registryClass;
  SetOrMapLiteral? targetMap;
  ListLiteral? targetList;

  _RegistryVisitor({required this.className, required this.mapName});

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    if (node.name.lexeme == className) {
      registryClass = node;
    }
    super.visitClassDeclaration(node);
  }

  @override
  void visitVariableDeclaration(VariableDeclaration node) {
    if (node.name.lexeme == mapName) {
      final initializer = node.initializer;
      if (initializer is SetOrMapLiteral) {
        targetMap = initializer;
      } else if (initializer is ListLiteral) {
        targetList = initializer;
      }
    }
    super.visitVariableDeclaration(node);
  }
}

class _SwitchVisitor extends RecursiveAstVisitor<void> {
  final String variableName;
  SwitchStatement? targetSwitch;
  bool _insideTarget = false;

  _SwitchVisitor(this.variableName);

  @override
  void visitVariableDeclaration(VariableDeclaration node) {
    if (node.name.lexeme == variableName) {
      _insideTarget = true;
      node.visitChildren(this);
      _insideTarget = false;
    } else {
      super.visitVariableDeclaration(node);
    }
  }

  @override
  void visitFunctionDeclaration(FunctionDeclaration node) {
    if (node.name.lexeme == variableName) {
      _insideTarget = true;
      node.visitChildren(this);
      _insideTarget = false;
    } else {
      super.visitFunctionDeclaration(node);
    }
  }

  @override
  void visitSwitchStatement(SwitchStatement node) {
    if (_insideTarget && targetSwitch == null) {
      targetSwitch = node;
    }
    super.visitSwitchStatement(node);
  }
}

