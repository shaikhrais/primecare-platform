// Layer: 01_INFRASTRUCTURE
import 'package:flutter_core/flutter_core.dart';

/// Helper provider for generic dashboard adapters.
final genericDashboardAdapterProvider =
    Provider.family<DynamicScreenAdapter, PrimeCareForm>((ref, form) {
      return DynamicScreenAdapter(ref, form);
    });

/// Adapter for dynamically binding forms to view models.
class DynamicScreenAdapter {
  final Ref ref;
  final PrimeCareForm form;

  DynamicScreenAdapter(this.ref, this.form);

  /// Watches data associated with the form.
  AsyncValue<Result<PrimeCareDashboardViewModel>> watchData() {
    // In a real scenario, this would use a resolver to find the right provider.
    // For now, we bind to a mock result.
    return AsyncValue.data(
      Success(
        PrimeCareDashboardViewModel(
          metrics: DashboardMetrics.empty(),
          insights: [],
          timeline: [],
          trends: [],
          lastUpdated: DateTime.now(),
        ),
      ),
    );
  }
}

/// Provider for form-specific adapters.
final primecareFormProvider =
    Provider.family<DynamicScreenAdapter, PrimeCareForm>((ref, form) {
      switch (form) {
        case PrimeCareForm.patientIntake:
          return ref.watch(genericDashboardAdapterProvider(form));
        case PrimeCareForm.staffOnboarding:
          return ref.watch(genericDashboardAdapterProvider(form));
        case PrimeCareForm.billingSubmission:
          return ref.watch(genericDashboardAdapterProvider(form));
        case PrimeCareForm.incidentReport:
          return ref.watch(genericDashboardAdapterProvider(form));
        case PrimeCareForm.carePlan:
          return ref.watch(genericDashboardAdapterProvider(form));
        case PrimeCareForm.schedulerEntry:
          return ref.watch(genericDashboardAdapterProvider(form));
        case PrimeCareForm.ceoDashboard:
          return ref.watch(genericDashboardAdapterProvider(form));
        case PrimeCareForm.pswDashboard:
          return ref.watch(genericDashboardAdapterProvider(form));
      }
    });
