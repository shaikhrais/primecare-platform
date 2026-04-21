// Layer: 05_REGISTRY_GOVERNANCE
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../primecare_adapters.dart';
import '05_G_primecare_form_enum.dart';

/// Central provider that resolves the appropriate hydrated adapter for a given PrimeCareForm.
/// This allows the UI to simply request a form type and receive the bound data.
final primecareFormProvider = Provider.family<FutureProvider<Result<PrimeCareDashboardViewModel>>, PrimeCareForm>((ref, form) {
  switch (form) {
    case PrimeCareForm.ceoDashboard:
      return ceoDashboardAdapterProvider;
    case PrimeCareForm.cfoDashboard:
      return cfoDashboardAdapterProvider;
    case PrimeCareForm.complianceManagerDashboard:
      return complianceManagerDashboardAdapterProvider;
    case PrimeCareForm.financeDirectorDashboard:
      return financeDirectorDashboardAdapterProvider;
    case PrimeCareForm.ctoDashboard:
      return ctoDashboardAdapterProvider;
    case PrimeCareForm.trainingDirectorDashboard:
      return trainingDirectorDashboardAdapterProvider;
    // ... add more as they are migrated to the decoupled adapter package
    default:
      throw UnimplementedError('No adapter found for $form');
  }
});
