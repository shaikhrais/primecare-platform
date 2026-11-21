import 'package:test/test.dart';
import 'package:primecare_class_management/registry.dart';
import '../bin/scan.dart' show scanSource;

void main() {
  test(
    'master manager rejects cycles, unknown parents and ambiguous scopes',
    () {
      expect(
        () => MasterClassManager([
          const ClassManagerDeclaration('root', null, 'Root'),
          const ClassManagerDeclaration('a', 'b', 'A'),
          const ClassManagerDeclaration('b', 'a', 'B'),
        ], []),
        throwsFormatException,
      );
      expect(
        () => MasterClassManager([
          const ClassManagerDeclaration('root', null, 'Root'),
          const ClassManagerDeclaration('a', 'missing', 'A'),
        ], []),
        throwsFormatException,
      );
      expect(
        () => MasterClassManager(
          [const ClassManagerDeclaration('root', null, 'Root')],
          [
            (prefix: 'packages/', manager: 'root'),
            (prefix: 'packages/', manager: 'root'),
          ],
        ),
        throwsFormatException,
      );
    },
  );
  test(
    'longest declared path selects owner and missing scope stays unassigned',
    () {
      final master = MasterClassManager(
        [
          const ClassManagerDeclaration('root', null, 'Root'),
          const ClassManagerDeclaration('ui', 'root', 'UI'),
        ],
        [
          (prefix: 'packages/', manager: 'root'),
          (prefix: 'packages/ui/', manager: 'ui'),
        ],
      );
      expect(master.managerFor('packages/ui/lib/a.dart'), 'ui');
      expect(master.managerFor('unknown/a.dart'), isNull);
    },
  );
  test('AST distinguishes real classes from comments and strings', () {
    final result = scanSource(
      "// class Fake {}\nconst text='class AlsoFake {}';\n/// Real source purpose.\nabstract class Actual extends Parent<String> {}\nclass _Private {}\nmixin Feature {}\nenum Choice {a,b}",
      'packages/ui/lib/a.dart',
      'ui',
    );
    final rows = (result['classes'] as List).cast<Map<String, dynamic>>();
    expect(rows.map((row) => row['name']), [
      'Actual',
      '_Private',
      'Feature',
      'Choice',
    ]);
    expect(rows.first['baseName'], 'Parent<String>');
    expect(rows.first['abstract'], true);
    expect(rows[1]['private'], true);
    expect(rows.first['databaseStatus'], 'unknown');
    expect(rows.first['descriptionStatus'], 'needs_review');
    expect(rows.first['sourceDescription'], contains('Real source purpose'));
  });
  test(
    'IDs distinguish same name in different libraries and survive line changes',
    () {
      final a =
          scanSource('class Item {}', 'a.dart', 'ui')['classes']
              as List<Map<String, Object?>>;
      final b =
          scanSource('\nclass Item {}', 'a.dart', 'ui')['classes']
              as List<Map<String, Object?>>;
      final c =
          scanSource('class Item {}', 'b.dart', 'ui')['classes']
              as List<Map<String, Object?>>;
      expect(a.first['id'], b.first['id']);
      expect(a.first['id'], isNot(c.first['id']));
      expect(a.first['bodySha256'], b.first['bodySha256']);
    },
  );
  test(
    'syntax errors are explicit and never become a complete successful scan',
    () {
      final result = scanSource('class Broken {', 'bad.dart', 'ui');
      expect(result['diagnostics'], isNotEmpty);
      expect(
        (result['classes'] as List<Map<String, Object?>>).first['parseValid'],
        false,
      );
    },
  );
  test('master base index rejects duplicate registration', () {
    final registry = MasterBaseClassManager();
    const base = BaseClassDeclaration(
      'base',
      'Object',
      null,
      'root',
      'external_declared',
    );
    registry.declare(base);
    expect(() => registry.declarations.clear(), throwsUnsupportedError);
    expect(() => registry.declare(base), throwsFormatException);
  });
}
