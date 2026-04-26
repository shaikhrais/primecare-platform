import 'package:primecare_ui/primecare_ui.dart';
// Layer: 01_INFRASTRUCTURE

class TeamMemberAvatarPile extends StatelessWidget {
  TeamMemberAvatarPile({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: Stack(
        children: [
          Positioned(left: 0, child: PrimeAvatar(fallbackInitials: 'JD')),
          Positioned(
            left: 20,
            child: PrimeAvatar(fallbackInitials: 'AS'),
          ),
          Positioned(
            left: 40,
            child: CircleAvatar(
              backgroundColor: PrimeCareColors.slate400,
              child: Text(LocaleKeys.dashboards_common_labels_4.tr()),
            ),
          ),
        ],
      ),
    );
  }
}
