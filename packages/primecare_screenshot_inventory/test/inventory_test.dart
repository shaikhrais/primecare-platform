import 'dart:io';
import 'package:drift/drift.dart';
import 'package:primecare_screenshot_inventory/primecare_screenshot_inventory.dart';
import 'package:test/test.dart';

// No database connection is created; any unexpected call fails the fixture.
class NoDatabase implements QueryExecutor {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  test('missing screenshot directory leaves local files and DB untouched', () async {
    final previous = Directory.current;
    final fixture = await Directory.systemTemp.createTemp('primecare_inventory_');
    try {
      Directory.current = fixture;
      await ScreenshotInventoryService(NoDatabase()).scanAndUpdate();
      expect(fixture.listSync(), isEmpty);
    } finally {
      Directory.current = previous;
      await fixture.delete(recursive: true);
    }
  });
}
