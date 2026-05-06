
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/flutter_core.dart';

void main() {
  test('Audit Form Provider Parity', () async {
    final projectRoot = 'c:\\Users\\Admin2\\Documents\\GitHub\\primecare-platform';
    
    final enumPath = p.join(
      projectRoot, 
      'packages/flutter_core/lib/models/platform_types.dart'
    );
    final providerPath = p.join(
      projectRoot,
      'packages/flutter_core/lib/src/registry/dynamic_adapter_resolver.dart'
    );

    PrimeLogger.info('Auditing Form Provider Parity...');
    PrimeLogger.info('Enum Path: $enumPath');
    PrimeLogger.info('Provider Path: $providerPath');

    expect(File(enumPath).existsSync(), true, reason: 'Enum file missing');
    expect(File(providerPath).existsSync(), true, reason: 'Provider file missing');

    final enumContent = File(enumPath).readAsStringSync();
    final providerContent = File(providerPath).readAsStringSync();

    final enumResult = parseString(content: enumContent);
    final providerResult = parseString(content: providerContent);

    final enumValues = <String>{};
    final visitor = _EnumVisitor((name) => enumValues.add(name));
    enumResult.unit.accept(visitor);

    final providerCases = <String>{};
    final providerVisitor = _SwitchCaseVisitor((name) => providerCases.add(name));
    providerResult.unit.accept(providerVisitor);

    PrimeLogger.info('Found ${enumValues.length} enum values.');
    PrimeLogger.info('Found ${providerCases.length} switch cases.');

    final missing = <String>[];
    for (final value in enumValues) {
      if (!providerCases.contains(value)) {
        missing.add(value);
      }
    }

    if (missing.isEmpty) {
      PrimeLogger.info('SUCCESS: All enum values have a corresponding switch case in the provider.');
    } else {
      PrimeLogger.warning('FAILURE: Missing ${missing.length} mappings:');
      for (final m in missing) {
        PrimeLogger.warning(' - $m');
      }
      fail('Missing ${missing.length} mappings');
    }
  });
}

class _EnumVisitor extends RecursiveAstVisitor<void> {
  final void Function(String) onValue;
  _EnumVisitor(this.onValue);

  @override
  void visitEnumDeclaration(EnumDeclaration node) {
    if (node.name.lexeme == 'PrimeCareForm') {
      for (final constant in node.constants) {
        onValue(constant.name.lexeme);
      }
    }
    super.visitEnumDeclaration(node);
  }
}

class _SwitchCaseVisitor extends RecursiveAstVisitor<void> {
  final void Function(String) onCase;
  _SwitchCaseVisitor(this.onCase);

  @override
  void visitSwitchCase(SwitchCase node) {
    _handleExpression(node.expression);
    super.visitSwitchCase(node);
  }

  @override
  void visitSwitchPatternCase(SwitchPatternCase node) {
    final pattern = node.guardedPattern.pattern;
    if (pattern is ConstantPattern) {
      _handleExpression(pattern.expression);
    }
    super.visitSwitchPatternCase(node);
  }

  void _handleExpression(Expression expression) {
    if (expression is PrefixedIdentifier) {
      if (expression.prefix.name == 'PrimeCareForm') {
        onCase(expression.identifier.name);
      }
    } else if (expression is Identifier) {
      onCase(expression.name);
    }
  }
}
