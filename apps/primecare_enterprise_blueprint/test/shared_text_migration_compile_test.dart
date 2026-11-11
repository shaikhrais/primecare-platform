// Compile smoke coverage; does not establish runtime screen acceptance.
import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_enterprise_blueprint/main.dart' as app;

void main() {
  test('shared enterprise root text consumer compiles', () {
    expect(<Type>[app.MyApp, app.MyHomePage], hasLength(2));
  });
}
