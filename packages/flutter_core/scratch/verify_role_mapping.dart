import 'package:flutter_core/flutter_core.dart';

void main() {
  final rpnRoute = '/offices/clinical/roles/rpn/dashboard';
  final qaRoute = '/offices/support/roles/qa/dashboard';
  final qualityAssuranceRoute = '/offices/support/roles/quality_assurance/dashboard';

  print('RPN Route: $rpnRoute -> Role: ${PlatformRole.fromRoute(rpnRoute)}');
  print('QA Route: $qaRoute -> Role: ${PlatformRole.fromRoute(qaRoute)}');
  print('Quality Assurance Route: $qualityAssuranceRoute -> Role: ${PlatformRole.fromRoute(qualityAssuranceRoute)}');
}
