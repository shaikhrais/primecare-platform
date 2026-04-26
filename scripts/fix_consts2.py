import os

ADAPTERS_DIR = r"c:\Users\Admin2\Documents\GitHub\primecare-platform\packages\primecare_adapters\lib"

def remove_consts():
    for root, _, files in os.walk(ADAPTERS_DIR):
        for file in files:
            if file.endswith('.dart'):
                path = os.path.join(root, file)
                with open(path, 'r', encoding='utf-8') as f:
                    content = f.read()

                content = content.replace('const KpiMetric(', 'KpiMetric(')
                content = content.replace('const DashboardActivity(', 'DashboardActivity(')
                content = content.replace('const AnalyticsChart(', 'AnalyticsChart(')
                content = content.replace('const DashboardInsight(', 'DashboardInsight(')
                content = content.replace('const ChartDataPoint(', 'ChartDataPoint(')
                
                with open(path, 'w', encoding='utf-8') as f:
                    f.write(content)

remove_consts()
