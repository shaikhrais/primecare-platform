import os
import re

# Define the root path
root_path = r"c:\Users\Admin2\Documents\GitHub\primecare-platform\packages\factory_system\primecare_ui\lib\src\features"

# Mapping of loose text to LocaleKeys
replacements = {
    # Command Centers
    r"Text\('Training Command Center', style: theme.typography.h2\)": "Text(LocaleKeys.command_center_labels_training_center.tr(), style: theme.typography.h2)",
    r"Text\('Regional Curriculum Compliance', style: theme.typography.h4\)": "Text(LocaleKeys.command_center_labels_curriculum_compliance.tr(), style: theme.typography.h4)",
    r"Text\('Training Hub Command Center', style: theme.typography.h2\)": "Text(LocaleKeys.command_center_labels_training_hub_center.tr(), style: theme.typography.h2)",
    r"Text\('Volunteer Command Center', style: theme.typography.h2\)": "Text(LocaleKeys.command_center_labels_volunteer_center.tr(), style: theme.typography.h2)",
    r"Text\('Business Dev Command Center', style: theme.typography.h2\)": "Text(LocaleKeys.command_center_labels_business_dev_center.tr(), style: theme.typography.h2)",
    r"Text\('Clinical Command Center', style: theme.typography.h2\)": "Text(LocaleKeys.command_center_labels_clinical_center.tr(), style: theme.typography.h2)",
    r"Text\('Corporate Command Center', style: theme.typography.h2\)": "Text(LocaleKeys.command_center_labels_corporate_center.tr(), style: theme.typography.h2)",
    r"Text\('Franchise Command Center', style: theme.typography.h2\)": "Text(LocaleKeys.command_center_labels_franchise_center.tr(), style: theme.typography.h2)",
    r"Text\('Marketing Command Center', style: theme.typography.h2\)": "Text(LocaleKeys.command_center_labels_marketing_center.tr(), style: theme.typography.h2)",
    r"Text\('Operational Command Center', style: theme.typography.h2\)": "Text(LocaleKeys.command_center_labels_operational_center.tr(), style: theme.typography.h2)",
    r"Text\('Support Command Center', style: theme.typography.h2\)": "Text(LocaleKeys.command_center_labels_support_center.tr(), style: theme.typography.h2)",
    
    # Common Dashboard Labels
    r"Text\('Aura Intelligence', style: theme.typography.h4\)": "Text(LocaleKeys.dashboards_common_labels_aura_intelligence.tr(), style: theme.typography.h4)",
    r"Text\('Operational Volume', style: theme.typography.h4\)": "Text(LocaleKeys.dashboards_common_labels_operational_volume.tr(), style: theme.typography.h4)",
    r"const Center\(child: Text\('Operational Insights Unified'\)\)": "Center(child: Text(LocaleKeys.dashboards_common_labels_operational_insights.tr()))",
    
    # Regional Manager Widgets
    r"Text\(\s*'Regional Performance Matrix',\s*style: theme.typography.h3,\s*\)": "Text(LocaleKeys.regional_manager_labels_performance_matrix.tr(), style: theme.typography.h3)",
    r"Text\(\s*'Site-to-site comparative operational metrics',\s*style: theme.typography.labelMedium,\s*\)": "Text(LocaleKeys.regional_manager_labels_comparative_metrics.tr(), style: theme.typography.labelMedium)",
    r"Text\('Territory Health Scorecard', style: theme.typography.h3\)": "Text(LocaleKeys.regional_manager_labels_health_scorecard.tr(), style: theme.typography.h3)",
    r"Text\(\s*'Operational health indices across regional territories',\s*style: theme.typography.labelMedium,\s*\)": "Text(LocaleKeys.regional_manager_labels_health_indices.tr(), style: theme.typography.labelMedium)",
}

def fix_files():
    for root, dirs, files in os.walk(root_path):
        for file in files:
            if file.endswith(".dart"):
                path = os.path.join(root, file)
                with open(path, "r", encoding="utf-8") as f:
                    content = f.read()
                
                original_content = content
                for pattern, replacement in replacements.items():
                    content = re.sub(pattern, replacement, content)
                
                if content != original_content:
                    print(f"Fixed loose text in: {path}")
                    with open(path, "w", encoding="utf-8") as f:
                        f.write(content)

if __name__ == "__main__":
    fix_files()
