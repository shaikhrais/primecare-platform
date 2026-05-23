// Governance - Category: service | Purpose: [ASTPatchEngine] - A high-fidelity remediation engine that uses AST parsing to safely modify architectural registries...
import 'dart:io';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:flutter_core/flutter_core.dart';
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

    if (visitor.registryClass == null || visitor.targetMap == null) {
      return false;
    }

    // Check if entry already exists
    final entryExists = content.contains("'$screenId':");
    if (entryExists && !overwrite) {
      return true;
    }

    // 1. Build the ScreenMetadata object string
    final buffer = StringBuffer();
    buffer.writeln("    '$screenId': const ScreenMetadata(");
    metadata.forEach((key, value) {
      buffer.writeln("      $key: ${_formatValue(value)},");
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

      updatedContent =
          content.substring(0, startIndex) +
          buffer.toString() +
          content.substring(endIndex);
    } else {
      final mapEnd = visitor.targetMap!.rightBracket.offset;
      updatedContent =
          content.substring(0, mapEnd) +
          buffer.toString() +
          content.substring(mapEnd);
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
          if (pattern is ConstantPattern &&
              pattern.expression.toString() == c.enumValue) {
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

      final newCase =
          "    case ${c.enumValue}:\n      return ${c.returnValue};\n";
      content =
          content.substring(0, insertOffset) +
          newCase +
          content.substring(insertOffset);
    }

    await file.writeAsString(content);
    return true;
  }

  /// Updates metadata for a specific entry in a registry.
  Future<bool> updateRegistryMetadata(
    String entryKey,
    Map<String, dynamic> updates, {
    String registryPath =
        'apps/primecare_governance/lib/core/governance/screen_registry.dart',
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
              final freshVisitor = _RegistryVisitor(
                className: className,
                mapName: mapName,
              );
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
                updatedContent = _updateArgument(
                  updatedContent,
                  freshTarget.argumentList,
                  update.key,
                  _formatValue(update.value),
                );
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
  Future<bool> updateScreenMetadata(
    String screenId, {
    bool? isRenderOk,
    String? lifecycleStatus,
    int? storyPoints,
    String? lastAuditDate,
  }) async {
    final updates = <String, dynamic>{};
    if (isRenderOk != null) updates['isRenderOk'] = isRenderOk;
    if (lifecycleStatus != null) {
      updates['lifecycleStatus'] = 'LifecycleStatus.$lifecycleStatus';
    }
    if (storyPoints != null) updates['storyPoints'] = storyPoints;
    if (lastAuditDate != null) updates['lastAuditDate'] = lastAuditDate;

    return updateRegistryMetadata(
      screenId,
      updates,
      registryPath:
          'apps/primecare_governance/lib/core/governance/screen_registry.dart',
      className: 'ScreenRegistry',
      mapName: 'screens',
    );
  }

  String _updateArgument(
    String content,
    ArgumentList args,
    String name,
    String newValue,
  ) {
    for (final arg in args.arguments) {
      if (arg is NamedExpression && arg.name.label.name == name) {
        // Update existing argument
        final offset = arg.expression.offset;
        final length = arg.expression.length;
        return content.substring(0, offset) +
            newValue +
            content.substring(offset + length);
      }
    }

    // If not found, append to the argument list
    final closingParen = args.rightParenthesis.offset;
    final hasArgs = args.arguments.isNotEmpty;
    final prefix = hasArgs ? ", " : "";
    final newArg = "$prefix$name: $newValue";

    return content.substring(0, closingParen) +
        newArg +
        content.substring(closingParen);
  }

  /// Safely injects a new case into a switch statement within a provider.
  Future<bool> injectSwitchCase(
    String enumValue,
    String returnValue, {
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
        if (pattern is ConstantPattern &&
            pattern.expression.toString() == enumValue) {
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
    String updatedContent =
        content.substring(0, insertOffset) +
        newCase +
        content.substring(insertOffset);

    await file.writeAsString(updatedContent);
    return true;
  }

  String _formatValue(dynamic value) {
    if (value is String) {
      // 1. Explicitly quoted strings are returned as is
      if ((value.startsWith("'") && value.endsWith("'")) ||
          (value.startsWith('"') && value.endsWith('"'))) {
        return value;
      }

      // 2. Known code constants/enums (Heuristic)
      final bool isBoolean = value == 'true' || value == 'false';
      final bool isEnumOrStatic = RegExp(
        r'^[A-Z][a-zA-Z0-9_]*\.[a-zA-Z0-9_]+$',
      ).hasMatch(value);
      final bool isIcon = RegExp(
        r'^Icons\.[a-z][a-zA-Z0-9_]*$',
      ).hasMatch(value);
      final bool isColor = RegExp(
        r'^Color\(0x[0-9a-fA-F]{8}\)$',
      ).hasMatch(value);
      final bool isConstructor = RegExp(
        r'^const\s+[A-Z][a-zA-Z0-9_]*\(',
      ).hasMatch(value);

      if (isBoolean || isEnumOrStatic || isIcon || isColor || isConstructor) {
        return value;
      }

      // 3. Fallback to single-quoted string
      // Escape single quotes if present
      final escaped = value.replaceAll("'", "\\'");
      return "'$escaped'";
    } else if (value is List) {
      final listStr = value.map((e) => _formatValue(e)).join(', ');
      return "[$listStr]";
    } else if (value is Map) {
      final mapEntries = value.entries
          .map((e) => "${_formatValue(e.key)}: ${_formatValue(e.value)}")
          .join(', ');
      return "{$mapEntries}";
    } else {
      return value.toString();
    }
  }

  /// Safely injects a header into the ApiClient's BaseOptions.
  Future<bool> injectHeader(
    String header,
    String value, {
    required String filePath,
    bool isRaw = false,
  }) async {
    final fullPath = p.join(projectRoot, filePath);
    final file = File(fullPath);
    if (!await file.exists()) {
      PrimeLogger.warning(
        'injectHeader - File not found at $fullPath',
        tag: 'ASTPatchEngine',
      );
      return false;
    }

    final content = await file.readAsString();
    final unit = parseString(content: content).unit;
    final visitor = _HeadersVisitor();
    unit.accept(visitor);

    if (visitor.headersMap == null) {
      return false;
    }

    final headersMap = visitor.headersMap!;

    // Check if header already exists
    bool exists = false;
    for (final element in headersMap.elements) {
      if (element is MapLiteralEntry) {
        final key = element.key;
        if (key is SimpleStringLiteral && key.value == header) {
          exists = true;
          break;
        }
      }
    }
    if (exists) return true;

    // Inject into existing map
    final insertOffset = headersMap.leftBracket.offset + 1;
    final entry = isRaw
        ? "\n            '$header': $value,"
        : "\n            '$header': '$value',";

    final updatedContent =
        content.substring(0, insertOffset) +
        entry +
        content.substring(insertOffset);

    await file.writeAsString(updatedContent);
    return true;
  }

  /// Safely injects a line of code into a specific class constructor.
  Future<bool> injectIntoConstructor({
    required String filePath,
    required String className,
    required String codeLine,
  }) async {
    final fullPath = p.join(projectRoot, filePath);
    final file = File(fullPath);
    if (!await file.exists()) return false;

    final content = await file.readAsString();
    if (content.contains(codeLine)) return true;

    final unit = parseString(content: content).unit;
    final visitor = _ConstructorVisitor(className);
    unit.accept(visitor);

    if (visitor.constructorBody == null) return false;

    final body = visitor.constructorBody!;
    int insertOffset;
    if (body is BlockFunctionBody) {
      insertOffset = body.block.leftBracket.offset + 1;
    } else {
      // Expression body or something else not easily handleable
      return false;
    }

    final updatedContent =
        "${content.substring(0, insertOffset)}\n    $codeLine${content.substring(insertOffset)}";

    await file.writeAsString(updatedContent);
    return true;
  }

  /// Safely injects a line of code into a specific function (e.g. main).
  Future<bool> injectIntoFunction({
    required String filePath,
    required String functionName,
    required String codeLine,
  }) async {
    final fullPath = p.join(projectRoot, filePath);
    final file = File(fullPath);
    if (!await file.exists()) return false;

    final content = await file.readAsString();
    if (content.contains(codeLine)) return true;

    final unit = parseString(content: content).unit;
    final visitor = _FunctionVisitor(functionName);
    unit.accept(visitor);

    if (visitor.functionBody == null) return false;

    final body = visitor.functionBody!;
    int insertOffset;
    if (body is BlockFunctionBody) {
      insertOffset = body.block.leftBracket.offset + 1;
    } else {
      return false;
    }

    final updatedContent =
        "${content.substring(0, insertOffset)}\n  $codeLine${content.substring(insertOffset)}";

    await file.writeAsString(updatedContent);
    return true;
  }

  /// Extracts attributes like translationKeys and isTranslationVerified from a GovernedScreen class.
  Future<Map<String, dynamic>> extractScreenClassAttributes({
    required String filePath,
    required String className,
  }) async {
    final fullPath = p.join(projectRoot, filePath);
    final file = File(fullPath);
    if (!await file.exists()) return {};

    final content = await file.readAsString();
    final unit = parseString(content: content).unit;
    final visitor = _ScreenClassVisitor(className);
    unit.accept(visitor);

    final results = <String, dynamic>{};
    if (visitor.translationKeys != null) {
      results['translationKeys'] = visitor.translationKeys;
    }
    if (visitor.isTranslationVerified != null) {
      results['isTranslationVerified'] = visitor.isTranslationVerified;
    }
    if (visitor.isMobileVerified != null) {
      results['isMobileVerified'] = visitor.isMobileVerified;
    }
    if (visitor.isTabletVerified != null) {
      results['isTabletVerified'] = visitor.isTabletVerified;
    }
    if (visitor.isDesktopVerified != null) {
      results['isDesktopVerified'] = visitor.isDesktopVerified;
    }
    if (visitor.isSecurityVerified != null) {
      results['isSecurityVerified'] = visitor.isSecurityVerified;
    }
    if (visitor.subsystem != null) {
      results['subsystem'] = visitor.subsystem;
    }
    if (visitor.hasEmptyState != null) {
      results['hasEmptyState'] = visitor.hasEmptyState;
    }

    return results;
  }
}

class _ConstructorVisitor extends RecursiveAstVisitor<void> {
  final String className;
  FunctionBody? constructorBody;

  _ConstructorVisitor(this.className);

  @override
  void visitConstructorDeclaration(ConstructorDeclaration node) {
    final parent = node.parent;
    if (parent is ClassDeclaration && parent.name.lexeme == className) {
      constructorBody = node.body;
    }
    super.visitConstructorDeclaration(node);
  }
}

class _FunctionVisitor extends RecursiveAstVisitor<void> {
  final String functionName;
  FunctionBody? functionBody;

  _FunctionVisitor(this.functionName);

  @override
  void visitFunctionDeclaration(FunctionDeclaration node) {
    if (node.name.lexeme == functionName) {
      functionBody = node.functionExpression.body;
    }
    super.visitFunctionDeclaration(node);
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

class _HeadersVisitor extends RecursiveAstVisitor<void> {
  SetOrMapLiteral? headersMap;

  @override
  void visitNamedExpression(NamedExpression node) {
    if (node.name.label.name == 'headers' &&
        node.expression is SetOrMapLiteral) {
      headersMap = node.expression as SetOrMapLiteral;
    }
    super.visitNamedExpression(node);
  }
}

class _ScreenClassVisitor extends RecursiveAstVisitor<void> {
  final String className;
  List<String>? translationKeys;
  bool? isTranslationVerified;
  bool? isMobileVerified;
  bool? isTabletVerified;
  bool? isDesktopVerified;
  bool? isSecurityVerified;
  String? subsystem;
  bool? hasEmptyState;

  _ScreenClassVisitor(this.className);

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    if (node.name.lexeme == className) {
      for (final member in node.members) {
        if (member is MethodDeclaration && member.isGetter) {
          final name = member.name.lexeme;
          final body = member.body;

          if (name == 'translationKeys') {
            if (body is ExpressionFunctionBody && body.expression is ListLiteral) {
              translationKeys = (body.expression as ListLiteral).elements
                  .whereType<SimpleStringLiteral>()
                  .map((e) => e.value)
                  .toList();
            }
          } else if (name == 'isTranslationVerified') {
            if (body is ExpressionFunctionBody && body.expression is BooleanLiteral) {
              isTranslationVerified = (body.expression as BooleanLiteral).value;
            }
          } else if (name == 'isMobileVerified') {
            if (body is ExpressionFunctionBody && body.expression is BooleanLiteral) {
              isMobileVerified = (body.expression as BooleanLiteral).value;
            }
          } else if (name == 'isTabletVerified') {
            if (body is ExpressionFunctionBody && body.expression is BooleanLiteral) {
              isTabletVerified = (body.expression as BooleanLiteral).value;
            }
          } else if (name == 'isDesktopVerified') {
            if (body is ExpressionFunctionBody && body.expression is BooleanLiteral) {
              isDesktopVerified = (body.expression as BooleanLiteral).value;
            }
          } else if (name == 'isSecurityVerified') {
            if (body is ExpressionFunctionBody && body.expression is BooleanLiteral) {
              isSecurityVerified = (body.expression as BooleanLiteral).value;
            }
          } else if (name == 'subsystem') {
            if (body is ExpressionFunctionBody && body.expression is SimpleStringLiteral) {
              subsystem = (body.expression as SimpleStringLiteral).value;
            }
          } else if (name == 'hasEmptyState') {
            if (body is ExpressionFunctionBody && body.expression is BooleanLiteral) {
              hasEmptyState = (body.expression as BooleanLiteral).value;
            }
          }
        }
      }
    }
    super.visitClassDeclaration(node);
  }
}
