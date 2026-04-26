// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_aws_sign_up_tab_view_model.dart';
import '../dtos/02_M_aws_sign_up_tab_dto.dart';

class AwsSignUpTabMapper {
  static AwsSignUpTabViewModel fromDto(AwsSignUpTabDto dto) {
    return AwsSignUpTabViewModel(
      title: dto.raw['title']?.toString() ?? 'awsSignUpTab',
      metadata: dto.raw,
    );
  }
}
