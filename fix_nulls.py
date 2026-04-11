import glob, os

files = [
    r'packages\flutter_ui\lib\src\screens\offices\franchise\billing_admin_dashboard.dart',
    r'packages\flutter_ui\lib\src\screens\offices\franchise\billing_admin_dashboard\sections\billing_admin_kpi_section.dart',
    r'packages\flutter_ui\lib\src\screens\offices\franchise\franchise_owner_dashboard\sections\franchise_owner_kpi_section.dart',
    r'packages\flutter_ui\lib\src\screens\offices\franchise\hr_hiring_dashboard.dart',
    r'packages\flutter_ui\lib\src\screens\offices\franchise\hr_hiring_dashboard\sections\hr_hiring_kpi_section.dart',
    r'packages\flutter_ui\lib\src\screens\offices\franchise\operations_manager_dashboard.dart',
    r'packages\flutter_ui\lib\src\screens\stitch_generated\franchise_sales_manager_dashboard_screen_stitch.dart',
    r'packages\flutter_ui\lib\src\screens\stitch_generated\territory_expansion_manager_dashboard_screen_stitch.dart',
    r'packages\flutter_ui\lib\src\screens\stitch_generated\territory_sales_manager_dashboard_screen_stitch.dart'
]

for path in files:
    if not os.path.exists(path):
        continue
    with open(path, 'r') as f:
        c = f.read()

    # billing_admin_dashboard.dart
    c = c.replace('billing_admin_view_model.dart', 'billing_admin_dashboard_view_model.dart')
    c = c.replace('BillingAdminViewModel', 'BillingAdminDashboardViewModel')
    c = c.replace("package:flutter_core/flutter_core.dart';", "package:flutter_core/flutter_core.dart' hide billingAdminDashboardAdapterProvider;")
    c = c.replace("package:flutter_core/flutter_core.dart';", "package:flutter_core/flutter_core.dart' hide hrHiringDashboardAdapterProvider;") 
    c = c.replace("package:flutter_core/flutter_core.dart';", "package:flutter_core/flutter_core.dart' hide operationsManagerDashboardAdapterProvider;")

    # franchise_owner_kpi_section.dart
    c = c.replace('kpi.label', 'kpi.title')

    # All dashboards
    c = c.replace('metric.title,', "metric.title ?? '',")
    c = c.replace('metric.value,', "metric.value ?? '',")
    c = c.replace('metric.trend,', "metric.trend ?? '',")
    c = c.replace('metric.title)', "metric.title ?? '')")
    c = c.replace('metric.status)', "metric.status ?? '')")

    # All kpi sections
    c = c.replace('kpi.title,', "kpi.title ?? '',")
    c = c.replace('kpi.value,', "kpi.value ?? '',")
    c = c.replace('kpi.trend,', "kpi.trend ?? '',")
    c = c.replace('kpi.title)', "kpi.title ?? '')")
    c = c.replace('kpi.status)', "kpi.status ?? '')")

    # Activities
    c = c.replace('act.title,', "act.title ?? '',")
    c = c.replace('act.subtitle,', "act.subtitle ?? '',")
    c = c.replace('act.timestamp,', "act.timestamp ?? '',")

    with open(path, 'w') as f:
        f.write(c)

print('Fixed.')
