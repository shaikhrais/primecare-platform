/// Public extension points; legacy imports remain supported by compatibility exports.
library;

export 'communications/communication_core.dart';
export 'communications/dio_communication_transport.dart';
export 'communications/registered_communication_bindings.dart';

export 'src/domain/models/base_entity.dart';
export 'src/domain/models/base_response_envelope.dart';
export 'src/infrastructure/repositories/base_api_repository.dart';
export 'src/application/services/base_business_service.dart';
export 'src/security/policies/base_permission_policy.dart';
export 'src/security/policies/route_permission_policy.dart';
