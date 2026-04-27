// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/aws_sign_in_tab_view_model.dart';
import '../dtos/aws_sign_in_tab_dto.dart';

class AwsSignInTabMapper {
  static AwsSignInTabViewModel fromDto(AwsSignInTabDto dto) {
    return AwsSignInTabViewModel(
      title: dto.raw['title']?.toString() ?? 'awsSignInTab',
      metadata: dto.raw,
    );
  }
}
