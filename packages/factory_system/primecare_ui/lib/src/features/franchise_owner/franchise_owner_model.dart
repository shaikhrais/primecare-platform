class FranchiseOwnerViewModel {
  final String region;
  final double monthlyRevenue;
  final int activeStaff;

  const FranchiseOwnerViewModel({
    required this.region,
    required this.monthlyRevenue,
    required this.activeStaff,
  });

  factory FranchiseOwnerViewModel.initial() {
    return const FranchiseOwnerViewModel(
      region: 'North York',
      monthlyRevenue: 125000.0,
      activeStaff: 42,
    );
  }
}
