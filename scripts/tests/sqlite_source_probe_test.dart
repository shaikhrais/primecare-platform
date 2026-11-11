// Copied into the owned clinic CI checkout only. Not a normal app test.
import 'package:flutter_test/flutter_test.dart';
import 'package:sqlite3/sqlite3.dart';

void main() {
  test('the pilot native asset executes the verified SQLite release', () {
    final database = sqlite3.openInMemory();
    try {
      final row = database.select(
        'SELECT sqlite_version() AS version, sqlite_source_id() AS source, 1 AS alive',
      ).single;
      expect(row['version'], '3.53.4');
      expect(row['source'],
        '2026-07-24 19:02:57 bf7c7f30031888f4e796e429ab3978879485813aaca6f641c7b33e4e09459bcc');
      expect(row['alive'], 1);
    } finally {
      database.dispose();
    }
  });
}
