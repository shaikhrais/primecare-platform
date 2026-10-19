import 'dart:convert';
import 'package:server_core/server_core.dart';
import 'package:test/test.dart';

class Controller extends BaseController {}

void main() {
  test('shared response formatting retains nested JSON and content type', () async {
    final response = Controller().success([{'id': 12, 'name': 'original'}]);
    expect(response.statusCode, 200);
    expect(response.headers['content-type'], 'application/json');
    expect(jsonDecode(await response.readAsString()), [{'id': 12, 'name': 'original'}]);
  });
  test('shared errors preserve status and legacy wire envelope', () async {
    final controller = Controller();
    final denied = controller.error('denied', statusCode: 403);
    expect(denied.statusCode, 403);
    expect(jsonDecode(await denied.readAsString()), {'error': 'denied', 'status': 'failed'});
    final absent = controller.notFound('App');
    expect(absent.statusCode, 404);
    expect(jsonDecode(await absent.readAsString()), {'error': 'App not found', 'status': 'failed'});
  });
}
