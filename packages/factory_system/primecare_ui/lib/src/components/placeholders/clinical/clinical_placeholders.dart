// Layer: 01_INFRASTRUCTURE
import 'package:primecare_ui/src/components/placeholders/base_placeholder.dart';

// Note: Specific clinical placeholders have been moved to clinic_placeholders.dart, intake_placeholders.dart, etc.
// This file can be used for general clinical infrastructure placeholders if needed.

class ClinicalBasePlaceholder extends BasePlaceholder {
  const ClinicalBasePlaceholder({super.key, dynamic data})
    : super(name: 'ClinicalBase', data: data);
}
