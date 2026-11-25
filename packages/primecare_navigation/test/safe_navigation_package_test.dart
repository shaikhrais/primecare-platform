import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_navigation/primecare_navigation.dart';
void main() { test('typed route substitutes declared parameters', () { const route = AppRoute('/fixture/:id'); expect(route.withParams({'id': 'sample'}).path, '/fixture/sample'); expect(route.withParams({}).path, route.path); }); }
