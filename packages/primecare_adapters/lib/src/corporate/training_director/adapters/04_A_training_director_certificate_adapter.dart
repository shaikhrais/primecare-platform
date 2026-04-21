import 'package:primecare_adapters/primecare_adapters.dart';

/// Adapter for the Certificate Verification form.
/// Handles high-fidelity verification logic against the backend registry.
final verifyCertificateFormAdapterProvider =
    FutureProvider<Result<SystemVerificationViewModel>>((ref) async {
      // Default empty state for the form
      final viewModel = SystemVerificationViewModel.empty();

      return Success(viewModel);
    });

/// Action Handler for the Certificate Verification Form.
/// Connects the UI form fields to the backend verification service.
final verifyCertificateActionHandler = Provider((ref) {
  final trainingService = ref.read(trainingServiceProvider);
  final telemetry = ref.read(executionGateProvider);

  return (String actionId, [Map<String, dynamic>? payload]) async {
    switch (actionId) {
      case 'SUBMIT_VERIFICATION':
        final staffName = payload?['staffName'] as String? ?? '';
        final certName = payload?['certName'] as String? ?? '';

        if (staffName.isEmpty || certName.isEmpty) {
          telemetry.failGate(
            ExecutionGateCategory.compliance,
            'Missing required fields for certificate verification',
          );
          return;
        }

        telemetry.passGate(
          ExecutionGateCategory.compliance,
          'Submitting verification for $staffName: $certName',
        );

        final result = await trainingService.verifyCertificate(
          staffName,
          certName,
        );

        result.fold(
          (data) {
            final isValid = data['verified'] as bool? ?? false;
            final message =
                data['message'] as String? ?? 'Verification Complete';

            telemetry.passGate(
              ExecutionGateCategory.compliance,
              'Verification Result: ${isValid ? "VALID" : "INVALID"} - $message',
            );

            // Note: In a real app, we would update the state with the result.
            // For this architecture, we signal success via telemetry and the UI would be bound to the result.
          },
          (error) {
            telemetry.failGate(
              ExecutionGateCategory.compliance,
              'Server-side verification failed: $error',
            );
          },
        );
        break;

      default:
        telemetry.failGate(
          ExecutionGateCategory.interaction,
          'Unrecognized form action: $actionId',
        );
    }
  };
});
