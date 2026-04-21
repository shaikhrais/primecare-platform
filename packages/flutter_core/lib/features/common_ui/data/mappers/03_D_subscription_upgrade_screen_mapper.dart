// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_subscription_upgrade_screen_view_model.dart';
import '../dtos/02_M_subscription_upgrade_screen_dto.dart';

class SubscriptionUpgradeScreenMapper {
  static SubscriptionUpgradeScreenViewModel fromDto(SubscriptionUpgradeScreenDto dto) {
    return SubscriptionUpgradeScreenViewModel(
      title: dto.raw['title']?.toString() ?? 'subscriptionUpgradeScreen',
      metadata: dto.raw,
    );
  }
}

