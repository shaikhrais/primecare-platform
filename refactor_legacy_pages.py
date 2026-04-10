import os
import re

files = [
    r"packages\flutter_ui\lib\src\screens\offices\marketing\territory_sales_manager_dashboard_screen.dart",
    r"packages\flutter_ui\lib\src\screens\offices\marketing\local_marketing_manager_dashboard_screen.dart",
    r"packages\flutter_ui\lib\src\screens\offices\marketing\head_of_marketing_dashboard_screen.dart",
    r"packages\flutter_ui\lib\src\screens\offices\marketing\community_outreach_dashboard_screen.dart",
    r"packages\flutter_ui\lib\src\screens\offices\franchise\billing_admin_dashboard_screen.dart",
    r"packages\flutter_ui\lib\src\screens\offices\franchise\operations_manager_dashboard_screen.dart",
    r"packages\flutter_ui\lib\src\screens\offices\franchise\scheduler_dashboard_screen.dart",
    r"packages\flutter_ui\lib\src\screens\offices\franchise\hr_hiring_dashboard_screen.dart",
    r"packages\flutter_ui\lib\src\screens\offices\franchise\franchise_owner_dashboard_screen.dart",
    r"packages\flutter_ui\lib\src\screens\offices\corporate\coo_compliance_view.dart"
]

pattern = r'''DashboardView\s*\(\s*header:\s*DashboardHeader\s*\(\s*title:\s*([^,]+),\s*subtitle:\s*([^,]+),\s*\),\s*kpiCards:\s*metrics\.kpis\.map\(\s*\(kpi\)\s*=>\s*PlatformKpiCard\s*\(\s*title:\s*kpi\.label,\s*value:\s*kpi\.value,\s*trend:\s*kpi\.trend,\s*\)\s*\)\.toList\(\),\s*recentActivity:\s*metrics\.recentActivity\.map\(\s*\(log\)\s*=>\s*ActivityLogItem\s*\(\s*title:\s*log\.title,\s*timestamp:\s*log\.timestamp\.toString\(\),\s*\)\s*\)\.toList\(\),\s*\)'''

replacement = r'''PageTemplate(
          title: \1,
          subtitle: \2,
          kpiCards: metrics.kpis.map((kpi) => 
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(kpi.label, style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.grey.shade600)),
                    const SizedBox(height: 8),
                    Text(kpi.value, style: Theme.of(context).textTheme.headlineMedium),
                    if (kpi.trend != null) ...[
                      const SizedBox(height: 8),
                      Text(kpi.trend!, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.blueGrey)),
                    ]
                  ],
                ),
              ),
            )
          ).toList(),
          children: [
            if (metrics.recentActivity.isNotEmpty) ...[
              Text('Recent Activity', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              ...metrics.recentActivity.map((log) => 
                ListTile(
                  title: Text(log.title),
                  subtitle: Text(log.timestamp.toString()),
                )
              ).toList(),
            ]
          ],
        )'''

for fpath in files:
    if os.path.exists(fpath):
        with open(fpath, 'r', encoding='utf-8') as f:
            content = f.read()
        
        # We need to make sure the regex matches even if there are slight formatting variations
        # Let's try direct AST-like replacement or just regex.
        new_content, count = re.subn(pattern, replacement, content, flags=re.MULTILINE | re.DOTALL)
        
        if count > 0:
            with open(fpath, 'w', encoding='utf-8') as f:
                f.write(new_content)
            print(f"Updated {fpath}")
        else:
            print(f"Warning: No match found in {fpath}")
    else:
        print(f"Error: {fpath} does not exist.")
