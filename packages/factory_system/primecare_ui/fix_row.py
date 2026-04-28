import re

with open('lib/src/shared/src/core/primecare_components.dart', 'r', encoding='utf-8') as f:
    content = f.read()

old_code = """    return IntelligenceInsightCard(
      insight: IntelligenceInsight(
        title: title,
        description: description,
        type: type,
        timestamp: DateTime.now(),
      ),
    );"""

new_code = """    return IntelligenceInsightCard(
      insight: IntelligenceInsight(
        id: 'legacy_row',
        title: PrimeCareLabel(en: title),
        summary: PrimeCareLabel(en: description),
        impact: InsightImpact.info,
        type: InsightType.values.firstWhere((e) => e.name == type, orElse: () => InsightType.info),
      ),
    );"""

content = content.replace(old_code, new_code)

with open('lib/src/shared/src/core/primecare_components.dart', 'w', encoding='utf-8') as f:
    f.write(content)

print("Fixed DashboardInsightRow")
