import os
import re

ADAPTERS_DIR = r"c:\Users\Admin2\Documents\GitHub\primecare-platform\packages\primecare_adapters\lib"

def remove_consts():
    for root, _, files in os.walk(ADAPTERS_DIR):
        for file in files:
            if file.endswith('.dart'):
                path = os.path.join(root, file)
                with open(path, 'r', encoding='utf-8') as f:
                    content = f.read()

                # Remove const from common models if they now contain .tr()
                content = content.replace('const PrimeCareKpiModel(', 'PrimeCareKpiModel(')
                content = content.replace('const PrimeCareDataPoint(', 'PrimeCareDataPoint(')
                content = content.replace('const DashboardAction(', 'DashboardAction(')
                content = content.replace('const DashboardSection(', 'DashboardSection(')
                content = content.replace('const DashboardGroup(', 'DashboardGroup(')
                content = content.replace('const ActionItem(', 'ActionItem(')
                content = content.replace('const MetricCard(', 'MetricCard(')
                content = content.replace('const QuickAction(', 'QuickAction(')
                content = content.replace('const AlertItem(', 'AlertItem(')
                content = content.replace('const IntelligenceInsight(', 'IntelligenceInsight(')
                content = content.replace('const InsightImpact(', 'InsightImpact(')
                
                # Also remove any "const [" if inside those lists there are .tr()
                # A bit risky but let's just do a regex replace for const [ -> [ if it's right before a model that is no longer const.
                # Or just dart fix handles removing const when it's invalid?
                # dart fix does NOT remove invalid consts. It only adds missing consts.

                with open(path, 'w', encoding='utf-8') as f:
                    f.write(content)

remove_consts()
