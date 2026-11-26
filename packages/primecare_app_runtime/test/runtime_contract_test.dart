import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_app_runtime/primecare_app_runtime.dart';

void main() {
  test('locale runtime requires explicit host language binding', () {
    const child = Text('fixture');
    final wrapper = LocaleRebuildWrapper(child: child,
      watchLanguage: (_) => 'en', readLanguage: (_) => 'en');
    expect(wrapper.child, same(child));
  });
}
