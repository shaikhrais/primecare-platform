import os
import re

files_with_unreachable = [
    'lib/src/components/aura/01_I_aura_dashboard_hud.dart',
    'lib/src/components/aura/01_I_aura_financial_hud.dart',
    'lib/src/components/scheduler/01_I_aura_insight_card.dart',
    'lib/src/features/cto_dashboard/presentation/widgets/01_I_cto_briefing_panel.dart'
]

# 1. Remove duplicate cases in unreachable switch cases
for f in files_with_unreachable:
    if not os.path.exists(f): continue
    with open(f, 'r') as file:
        content = file.read()
    
    # We remove cases that might be duplicates, such as critical in the fallback block
    content = content.replace("      case InsightImpact.critical:\n      case InsightImpact.low:\n      case InsightImpact.medium:", "      case InsightImpact.low:\n      case InsightImpact.medium:")
    
    # Also in aura_dashboard_hud and others, we added high which is maybe a duplicate or covered.
    # Actually wait! The issue says "This case is covered by the previous cases". 
    # That means the switch might just have a duplicate case label.
    with open(f, 'w') as file:
        file.write(content)

# 2. Fix non_exhaustive_switch_expression in primecare_aura_card and intelligence_insight_card
file1 = 'lib/src/components/cards/01_I_primecare_aura_card.dart'
if os.path.exists(file1):
    with open(file1, 'r') as file: content = file.read()
    # Find InsightImpact.info => and add InsightImpact.standard => 
    content = content.replace("InsightImpact.info =>", "InsightImpact.info || InsightImpact.standard || InsightImpact.success || InsightImpact.high || InsightImpact.low || InsightImpact.medium =>")
    with open(file1, 'w') as file: file.write(content)

file2 = 'lib/src/components/dashboards/01_I_intelligence_insight_card.dart'
if os.path.exists(file2):
    with open(file2, 'r') as file: content = file.read()
    content = content.replace("InsightImpact.info =>", "InsightImpact.info || InsightImpact.standard || InsightImpact.success || InsightImpact.high || InsightImpact.low || InsightImpact.medium =>")
    content = content.replace("InsightType.financial =>", "InsightType.financial || InsightType.efficiency =>")
    with open(file2, 'w') as file: file.write(content)

