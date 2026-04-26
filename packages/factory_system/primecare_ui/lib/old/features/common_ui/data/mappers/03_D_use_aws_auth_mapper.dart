// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_use_aws_auth_view_model.dart';
import '../dtos/02_M_use_aws_auth_dto.dart';

class UseAwsAuthMapper {
  static UseAwsAuthViewModel fromDto(UseAwsAuthDto dto) {
    return UseAwsAuthViewModel(
      title: dto.raw['title']?.toString() ?? 'useAwsAuth',
      metadata: dto.raw,
    );
  }
}
