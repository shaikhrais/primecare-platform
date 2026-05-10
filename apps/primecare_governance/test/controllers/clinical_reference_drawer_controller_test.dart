import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/flutter_core.dart';

void main() {
  group('ClinicalReferenceDrawerController', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('initial state is empty string', () {
      final state = container.read(clinicalReferenceDrawerControllerProvider);
      expect(state, isEmpty);
    });

    test('setQuery updates state', () {
      final controller = container.read(
        clinicalReferenceDrawerControllerProvider.notifier,
      );

      controller.setQuery('diabetes');

      final state = container.read(clinicalReferenceDrawerControllerProvider);
      expect(state, equals('diabetes'));
    });

    test('clearQuery resets state', () {
      final controller = container.read(
        clinicalReferenceDrawerControllerProvider.notifier,
      );

      controller.setQuery('hypertension');
      controller.clearQuery();

      final state = container.read(clinicalReferenceDrawerControllerProvider);
      expect(state, isEmpty);
    });
  });
}
