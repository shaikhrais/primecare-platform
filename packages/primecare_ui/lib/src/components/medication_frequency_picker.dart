import 'package:flutter/material.dart';

class MedicationFrequencyPicker extends StatelessWidget {
  const MedicationFrequencyPicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: [
        ChoiceChip(
          label: const Text('PRN'),
          selected: true,
          selectedColor: Theme.of(context).primaryColorLight,
        ),
        const ChoiceChip(label: Text('Daily'), selected: false),
        const ChoiceChip(label: Text('BID'), selected: false),
        const ChoiceChip(label: Text('TID'), selected: false),
      ],
    );
  }
}
