import 'package:easy_localization/easy_localization.dart';
import 'package:primecare_adapters/primecare_adapters.dart';

final familyMemberDashboardAdapterProvider =
    Provider<AsyncValue<Result<FamilyMemberDashboardViewModel>>>((ref) {
      return AsyncValue.data(
        Result.success(
          FamilyMemberDashboardViewModel(
            metrics: DashboardMetrics(
              kpis: [
                KpiMetric(
                  title: LocaleKeys
                      .dashboards_familymember_labels_governance_status
                      .tr(),
                  value: 'Operational',
                  trend: '0%',
                  status: 'positive',
                ),
                KpiMetric(
                  title: LocaleKeys
                      .dashboards_familymember_labels_realization_score
                      .tr(),
                  value: '100%',
                  trend: '5%',
                  status: 'positive',
                ),
              ],
              recentActivity: [],
            ),
            insights: const [],
          ),
        ),
      );
    });
