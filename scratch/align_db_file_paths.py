import sqlite3
import re

DB_PATH = r"c:\Users\Admin2\Documents\GitHub\primecare-platform\.agents\governance\governance.db"

# Master list of roles based on route paths and roles table synonyms
ROLE_SYNONYMS = {
    'rmt': 'rmt',
    'cfo': 'cfo',
    'ceo': 'ceo',
    'ciso': 'ciso',
    'coo': 'coo',
    'cto': 'cto',
    'psw': 'psw',
    'hsw': 'hsw',
    'rn': 'rn',
    'rpn': 'rpn',
    'lpn': 'lpn',
    'np': 'np',
    'physician': 'physician',
    'cns': 'cns',
    'pediatric': 'pediatric',
    'therapist': 'therapist',
    'chiropractor': 'chiropractor',
    'physio': 'physio',
    'physiotherapist': 'physio',
    'social_worker': 'social_worker',
    'social-worker': 'social_worker',
    'clinical_director': 'clinical_director',
    'clinical-director': 'clinical_director',
    'intake': 'intake',
    'intake_coordinator': 'intake',
    'intake-coordinator': 'intake',
    'scheduler': 'scheduler',
    'scheduler_coordinator': 'scheduler',
    'scheduler-coordinator': 'scheduler',
    'billing_admin': 'billing_admin',
    'billing-admin': 'billing_admin',
    'hr_hiring': 'hr_hiring',
    'hr-hiring': 'hr_hiring',
    'hr_manager': 'hr_hiring',
    'hr-manager': 'hr_hiring',
    'hr_director': 'hr_director',
    'hr-director': 'hr_director',
    'general_manager': 'gm',
    'general-manager': 'gm',
    'gm': 'gm',
    'operations_manager': 'ops_manager',
    'operations-manager': 'ops_manager',
    'ops_manager': 'ops_manager',
    'ops-manager': 'ops_manager',
    'franchise_owner': 'owner',
    'franchise-owner': 'owner',
    'owner': 'owner',
    'shareholder': 'shareholder',
    'legal': 'legal',
    'compliance': 'compliance',
    'compliance_manager': 'compliance',
    'compliance-manager': 'compliance',
    'quality_assurance': 'qa_specialist',
    'quality-assurance': 'qa_specialist',
    'qa_specialist': 'qa_specialist',
    'qa-specialist': 'qa_specialist',
    'qa': 'qa_specialist',
    'family': 'family',
    'family_member': 'family',
    'family-member': 'family',
    'patient': 'patient',
    'client': 'patient',
    'portal': 'portal',
    'guest': 'guest',
    'employee': 'employee',
    'volunteer': 'volunteer',
    'volunteer_coordinator': 'volunteer_coordinator',
    'volunteer-coordinator': 'volunteer_coordinator',
    'scrum_master': 'scrum_master',
    'scrum-master': 'scrum_master',
    'training_coordinator': 'training_coordinator',
    'training-coordinator': 'training_coordinator',
    'training_director': 'training_director',
    'training-director': 'training_director',
    'training': 'training',
    'training-hub': 'training',
    'dynamic': 'dynamic',
    'infrastructure': 'infrastructure',
    'system_verification': 'system_verification',
    'system-verification': 'system_verification',
    'vip_manager': 'vip_manager',
    'vip-manager': 'vip_manager',
    'premium_concierge': 'premium_concierge',
    'premium-concierge': 'premium_concierge',
    'regional_bdm': 'regional_bdm',
    'regional-bdm': 'regional_bdm',
    'regional_manager': 'regional_manager_usa',
    'regional-manager': 'regional_manager_usa',
    'regional_manager_usa': 'regional_manager_usa',
    'regional-manager-usa': 'regional_manager_usa',
    'regional_manager_ontario': 'regional_manager_usa',
    'regional-manager-ontario': 'regional_manager_usa',
    'partnership_manager': 'partnership',
    'partnership-manager': 'partnership',
    'partnership': 'partnership',
    'territory_expansion_manager': 'territory_expansion',
    'territory-expansion-manager': 'territory_expansion',
    'territory_expansion': 'territory_expansion',
    'territory-expansion': 'territory_expansion',
    'territory_sales_manager': 'territory_sales',
    'territory-sales-manager': 'territory_sales',
    'territory_sales': 'territory_sales',
    'territory-sales': 'territory_sales',
    'local_marketing_manager': 'local_marketing',
    'local-marketing-manager': 'local_marketing',
    'local_marketing': 'local_marketing',
    'local-marketing': 'local_marketing',
    'community_outreach': 'community_outreach',
    'community-outreach': 'community_outreach',
    'head_of_bus_dev': 'bus_dev',
    'head-of-bus-dev': 'bus_dev',
    'bus_dev': 'bus_dev',
    'bus-dev': 'bus_dev',
    'head_of_marketing': 'marketing',
    'head-of-marketing': 'marketing',
    'marketing_manager': 'marketing',
    'marketing-manager': 'marketing',
    'marketing': 'marketing',
    'cx_director': 'cx_director',
    'cx-director': 'cx_director',
    'finance_director': 'finance_director',
    'finance-director': 'finance_director',
    'it_admin': 'infrastructure',
    'it-admin': 'infrastructure',
    'admin': 'admin',
    'rn_field_supervisor': 'rn_field_supervisor',
    'rn-field-supervisor': 'rn_field_supervisor',
    'caregiver': 'caregiver',
}

ROLE_NAMES = {
    'chiropractor': 'Chiropractor',
    'physio': 'Physiotherapist',
    'rmt': 'Registered Massage Therapist (RMT)',
    'social_worker': 'Social Worker',
    'therapist': 'Therapist',
    'clinical_director': 'Clinical Director',
    'intake': 'Intake Coordinator',
    'rn': 'Registered Nurse (RN)',
    'physician': 'Physician',
    'cns': 'Clinical Nurse Specialist',
    'pediatric': 'Pediatric Specialist',
    'caregiver': 'Caregiver',
    'guest': 'Guest',
    'portal': 'Portal User',
    'patient': 'Patient',
    'dynamic': 'Dynamic Screen Viewer',
    'infrastructure': 'Infrastructure Auditor',
    'system_verification': 'System Verification Officer',
    'training': 'Training Candidate',
    'ceo': 'Chief Executive Officer (CEO)',
    'cfo': 'Chief Financial Officer (CFO)',
    'ciso': 'Chief Information Security Officer (CISO)',
    'coo': 'Chief Operating Officer (COO)',
    'cto': 'Chief Technology Officer (CTO)',
    'cx_director': 'CX Director',
    'finance_director': 'Finance Director',
    'hr_director': 'HR Director',
    'legal': 'Legal Counsel',
    'owner': 'Franchise Owner',
    'shareholder': 'Shareholder',
    'training_director': 'Training Director',
    'community_outreach': 'Community Outreach Lead',
    'compliance': 'Compliance Manager',
    'franchise_sales': 'Franchise Sales Manager',
    'gm': 'General Manager',
    'governance': 'Governance Officer',
    'bus_dev': 'Head of Business Development',
    'marketing': 'Head of Marketing',
    'local_marketing': 'Local Marketing Manager',
    'ops_manager': 'Operations Manager',
    'partnership': 'Partnership Manager',
    'regional_bdm': 'Regional BDM',
    'regional_manager_usa': 'Regional Manager USA',
    'scrum_master': 'Scrum Master',
    'hr_hiring': 'Talent Acquisition Manager',
    'territory_expansion': 'Territory Expansion Manager',
    'territory_sales': 'Territory Sales Manager',
    'volunteer_coordinator': 'Volunteer Coordinator',
    'premium_concierge': 'Premium Concierge Care Coordinator',
    'vip_manager': 'VIP Client Manager',
    'psw': 'Personal Support Worker (PSW)',
    'hsw': 'Home Support Worker',
    'rn_field_supervisor': 'Registered Nurse (RN) Field Supervisor',
    'np': 'Nurse Practitioner (NP)',
    'rpn': 'Registered Practical Nurse (RPN)',
    'lpn': 'Licensed Practical Nurse (LPN)',
    'employee': 'Employee',
    'volunteer': 'Volunteer',
    'admin': 'Administrative Assistant',
    'scheduler': 'Shift Supervisor',
    'customer_support': 'Customer Support',
    'training_coordinator': 'Training Coordinator',
    'qa_specialist': 'QA Specialist',
    'family': 'Family Member',
    'billing_admin': 'Billing Administrator',
}

def extract_role_details(route, screen_name):
    # Try offices pattern first
    m = re.search(r'/offices/([^/]+)/roles/([^/]+)', route)
    if m:
        category = m.group(1)
        rkey = m.group(2).lower()
        role_key = ROLE_SYNONYMS.get(rkey, rkey)
        return role_key, ROLE_NAMES.get(role_key, role_key.replace('_', ' ').title()), category

    # Try roles pattern: /roles/([^/]+)
    m2 = re.search(r'/roles/([^/]+)', route)
    if m2:
        rkey = m2.group(1).lower()
        role_key = ROLE_SYNONYMS.get(rkey, rkey)
        # Category can be inferred from context or path
        category = 'corporate' if role_key in ['cfo', 'ceo', 'coo', 'cto', 'ciso'] else 'common'
        return role_key, ROLE_NAMES.get(role_key, role_key.replace('_', ' ').title()), category

    # Try matching segments from route path
    # replace hyphens and slashes with spaces to tokenize
    tokens = re.split(r'[/_-]', route.lower())
    # Sort synonyms keys by length descending to match longer tokens first
    for syn_key in sorted(ROLE_SYNONYMS.keys(), key=len, reverse=True):
        syn_tokens = re.split(r'[_]', syn_key)
        # Check if syn_tokens is a sublist of tokens
        # E.g. syn_tokens = ['quality', 'assurance'] in tokens = ['staff', 'quality', 'assurance', 'dashboard']
        for i in range(len(tokens) - len(syn_tokens) + 1):
            if tokens[i:i+len(syn_tokens)] == syn_tokens:
                role_key = ROLE_SYNONYMS[syn_key]
                # Infer category from first segment
                category = tokens[1] if len(tokens) > 1 else 'common'
                return role_key, ROLE_NAMES.get(role_key, role_key.replace('_', ' ').title()), category

    # Check screen name as fallback
    # Convert camel case to tokens
    screen_tokens = re.findall(r'[A-Z]?[a-z]+|[A-Z]+(?=[A-Z][a-z]|\b)', screen_name)
    screen_tokens = [t.lower() for t in screen_tokens]
    for syn_key in sorted(ROLE_SYNONYMS.keys(), key=len, reverse=True):
        syn_tokens = re.split(r'[_]', syn_key)
        for i in range(len(screen_tokens) - len(syn_tokens) + 1):
            if screen_tokens[i:i+len(syn_tokens)] == syn_tokens:
                role_key = ROLE_SYNONYMS[syn_key]
                category = 'common'
                return role_key, ROLE_NAMES.get(role_key, role_key.replace('_', ' ').title()), category

    # Catch all: if it is proposals, generated, etc. and contains telehealth/research/public_health
    # We can assign to a special domain category
    for domain in ['public_health', 'research', 'telehealth', 'pharmacy', 'analytics', 'marketing', 'admin']:
        domain_tokens = domain.split('_')
        for i in range(len(tokens) - len(domain_tokens) + 1):
            if tokens[i:i+len(domain_tokens)] == domain_tokens:
                # E.g. public_health -> category = 'public_health', role_key = 'public_health_officer'
                role_key = f"{domain}_officer" if domain in ['public_health', 'compliance'] else (f"{domain}er" if domain == 'research' else f"{domain}_provider")
                role_name = f"{domain.replace('_', ' ').title()} Coordinator"
                return role_key, role_name, domain

    return None, None, None

def main():
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    c = conn.cursor()
    c.execute("SELECT id, route_path, screen_name FROM screens")
    screens = c.fetchall()
    
    matched_count = 0
    unmatched_count = 0
    
    role_screens = {}
    
    for s in screens:
        route = s['route_path']
        name = s['screen_name']
        
        role_key, role_name, category = extract_role_details(route or '', name or '')
        if role_key:
            matched_count += 1
            if role_key not in role_screens:
                role_screens[role_key] = []
            role_screens[role_key].append(s)
        else:
            unmatched_count += 1
            print(f"UNMATCHED: ID: {s['id']} | Route: {route} | Name: {name}")
            
    print(f"\nEnhanced Matcher Results:")
    print(f"Total Screens: {len(screens)}")
    print(f"Matched Screens: {matched_count}")
    print(f"Unmatched Screens: {unmatched_count}")
    print(f"Total Distinct Roles: {len(role_screens)}")
    
    conn.close()

if __name__ == "__main__":
    main()
