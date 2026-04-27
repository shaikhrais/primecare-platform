// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/use_aws_auth_view_model.dart';
import '../dtos/use_aws_auth_dto.dart';

class UseAwsAuthMapper {
  static UseAwsAuthViewModel fromDto(UseAwsAuthDto dto) {
    return UseAwsAuthViewModel(
      title: dto.raw['title']?.toString() ?? 'useAwsAuth',
      metadata: dto.raw,
    );
  }
}
