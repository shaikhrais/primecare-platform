            RoleDataBuilder(
              roleId: '$basename',
              builder: (context, data) {
                return DashboardKpiGrid(kpis: data.kpis, title: '${data.greetingTitle} | Metrics');
              },
            ),
