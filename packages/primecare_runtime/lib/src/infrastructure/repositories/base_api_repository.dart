// Host retains the concrete authenticated API transport.
import 'package:primecare_api_repository/base_api_repository.dart';
import '../../network/api_client.dart';

abstract class BaseApiRepository extends BaseApiRepositoryBase<ApiClient, ApiResponse> {
  BaseApiRepository(ApiClient client) : super(client,
    get: client.get, post: client.post, put: client.put, patch: client.patch, delete: client.delete);
}

/// Default transport repository used by application services.
class ApiRepository extends BaseApiRepository {
  ApiRepository(super.client);
}
