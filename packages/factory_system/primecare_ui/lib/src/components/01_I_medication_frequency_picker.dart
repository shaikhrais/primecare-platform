import 'package:primecare_ui/primecare_ui.dart';
// Layer: 01_INFRASTRUCTURE

class MedicationFrequencyPicker extends StatelessWidget {
  MedicationFrequencyPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: [
        ChoiceChip(
          label: Text(LocaleKeys.dashboards_common_labels_prn.tr()),
          selected: true,
          selectedColor: Theme.of(context).primaryColorLight,
        ),
        ChoiceChip(
          label: Text(LocaleKeys.dashboards_common_labels_daily.tr()),
          selected: false,
        ),
        ChoiceChip(
          label: Text(LocaleKeys.dashboards_common_labels_bid.tr()),
          selected: false,
        ),
        ChoiceChip(
          label: Text(LocaleKeys.dashboards_common_labels_tid.tr()),
          selected: false,
        ),
      ],
    );
  }
}
