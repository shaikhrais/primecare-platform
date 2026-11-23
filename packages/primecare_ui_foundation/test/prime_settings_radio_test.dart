import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_ui_foundation/primecare_ui_foundation.dart';

void main() {
  testWidgets('radio retains reference height and grows for enlarged wrapped labels', (tester) async {
    String? selected;
    Future<void> mount(double scale, double width, String label) => tester.pumpWidget(MaterialApp(
      home: Scaffold(body: MediaQuery(
        data: MediaQueryData(textScaler: TextScaler.linear(scale)),
        child: Align(alignment: Alignment.topLeft, child: SizedBox(width: width,
          child: RadioGroup<String>(groupValue: 'other', onChanged: (value) => selected = value,
            child: PrimeSettingsRadio<String>(value: 'layout', label: PrimeText(label),
              onSelected: () => selected = 'layout')))),
      )),
    ));
    await mount(1, 300, 'Layout 1 - Vertical');
    expect(tester.getSize(find.byType(PrimeSettingsRadio<String>)).height, 32);
    await mount(2, 180, 'Layout 2 - Horizontal navigation');
    expect(tester.takeException(), isNull);
    final control = tester.getRect(find.byType(PrimeSettingsRadio<String>));
    final label = tester.getRect(find.text('Layout 2 - Horizontal navigation'));
    expect(control.height, greaterThan(32));
    expect(label.left, greaterThanOrEqualTo(control.left));
    expect(label.right, lessThanOrEqualTo(control.right));
    expect(label.bottom, lessThanOrEqualTo(control.bottom));
    await tester.tap(find.text('Layout 2 - Horizontal navigation'));
    expect(selected, 'layout');
  });
}
