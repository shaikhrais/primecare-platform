import json
import collections

def analyze_intents():
    try:
        with open('.agents/ui_intents.json', 'r') as f:
            intents = json.load(f)
    except Exception as e:
        print(f"Error loading intents: {e}")
        return

    features = collections.defaultdict(list)
    
    for intent in intents:
        name = intent['enumName'] # Fixed key
        
        # Heuristics
        if 'Dashboard' in name:
            prefix = name.split('Dashboard')[0]
            prefix_snake = ''.join(['_' + c.lower() if c.isupper() else c for c in prefix]).lstrip('_')
            features[f"{prefix_snake}_dashboard"].append(name)
        elif 'Form' in name:
            if any(x in name for x in ['Clinical', 'CarePlan', 'Medication', 'Vitals', 'Infection', 'Incident', 'Adl', 'Census']):
                features["clinical_forms"].append(name)
            elif any(x in name for x in ['Expense', 'Payroll', 'Billing', 'Invoice', 'Reconciliation', 'Refunds', 'Revenue', 'Payroll', 'PettyCash']):
                features["financial_forms"].append(name)
            elif any(x in name for x in ['Lead', 'Franchise', 'AdPlacement', 'MarketShare', 'Sale', 'BusDev', 'Marketing']):
                features["crm_forms"].append(name)
            elif any(x in name for x in ['Staff', 'Leave', 'Hr', 'Interview', 'Employee', 'Timesheet', 'Hiring', 'Discipline']):
                features["hr_forms"].append(name)
            else:
                features["common_forms"].append(name)
        elif 'Icon' in name:
            features["icons"].append(name)
        elif 'Layout' in name:
            features["layouts"].append(name)
        elif 'ViewModel' in name:
             features["view_models"].append(name)
        elif 'Adapter' in name:
             features["adapters"].append(name)
        elif 'Mapper' in name:
             features["mappers"].append(name)
        elif 'Dto' in name:
             features["dtos"].append(name)
        else:
            features["miscellaneous"].append(name)

    print(f"Total Intents: {len(intents)}")
    print(f"Proposed Feature Groups: {len(features)}")
    
    # Sort groups by size
    sorted_groups = sorted(features.items(), key=lambda x: len(x[1]), reverse=True)
    
    for group, items in sorted_groups[:20]: # Show top 20
        print(f" - {group}: {len(items)} intents")

if __name__ == "__main__":
    analyze_intents()
