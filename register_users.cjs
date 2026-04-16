const apiUrl = 'https://primecare-api-gateway.itpro-mohammed.workers.dev/v1/auth/register';

const definitions = [
    { role: 'ceo', email: 'ceo@primecare.com' },
    { role: 'coo', email: 'coo@primecare.com' },
    { role: 'cfo', email: 'cfo@primecare.com' },
    { role: 'cto', email: 'cto@primecare.com' },
    { role: 'compliance_manager', email: 'compliance_manager@primecare.com' },
    { role: 'head_of_bus_dev', email: 'head_of_bus_dev@primecare.com' },
    { role: 'head_of_marketing', email: 'head_of_marketing@primecare.com' },
    { role: 'training_director', email: 'training_director@primecare.com' },
    { role: 'regional_manager_ontario', email: 'regional_manager_ontario@primecare.com' },
    { role: 'regional_manager_usa', email: 'regional_manager_usa@primecare.com' },
    { role: 'franchise_sales_manager', email: 'franchise_sales_manager@primecare.com' },
    { role: 'partnership_manager', email: 'partnership_manager@primecare.com' },
    { role: 'territory_expansion_manager', email: 'territory_expansion_manager@primecare.com' },
    { role: 'general_manager', email: 'general_manager@primecare.com' },
    { role: 'franchise_owner', email: 'franchise_owner@primecare.com' },
    { role: 'operations_manager', email: 'operations_manager@primecare.com' },
    { role: 'scheduler', email: 'scheduler@primecare.com' },
    { role: 'billing_admin', email: 'billing_admin@primecare.com' },
    { role: 'hr_manager', email: 'hr_manager@primecare.com' },
    { role: 'rn', email: 'rn@primecare.com' },
    { role: 'rpn', email: 'rpn@primecare.com' },
    { role: 'rmt', email: 'rmt@primecare.com' },
    { role: 'psw', email: 'psw@primecare.com' },
    { role: 'physiotherapist', email: 'physiotherapist@primecare.com' },
    { role: 'chiropractor', email: 'chiropractor@primecare.com' },
    { role: 'occupational_therapist', email: 'occupational_therapist@primecare.com' },
    { role: 'speech_pathologist', email: 'speech_pathologist@primecare.com' },
    { role: 'customer_support', email: 'customer_support@primecare.com' },
    { role: 'intake_coordinator', email: 'intake_coordinator@primecare.com' },
    { role: 'quality_assurance', email: 'quality_assurance@primecare.com' },
    { role: 'training_coordinator', email: 'training_coordinator@primecare.com' },
    { role: 'local_marketing', email: 'local_marketing@primecare.com' },
    { role: 'community_outreach', email: 'community_outreach@primecare.com' },
    { role: 'territory_sales', email: 'territory_sales@primecare.com' },
    { role: 'client', email: 'client@primecare.com' },
    { role: 'family_member', email: 'family_member@primecare.com' },
    { role: 'admin', email: 'admin@primecare.com' },
    { role: 'receptionist', email: 'receptionist@primecare.com' }
];

async function seedViaAPI() {
    console.log('🌐 Commencing API Registration Execution...');
    let successCount = 0;
    
    for (const d of definitions) {
        try {
            // First letters capitalized for names
            const fName = d.role.split('_').map(w => w.charAt(0).toUpperCase() + w.slice(1)).join(' ');
            
            const res = await fetch(apiUrl, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({
                    email: d.email,
                    password: 'password', // Universal testing password
                    firstName: fName,
                    lastName: 'PrimeCare',
                    role: d.role
                })
            });

            if (res.status === 200 || res.status === 201) {
                console.log(`[PASS] Created: ${d.email}`);
                successCount++;
            } else {
                const err = await res.text();
                // If the API returns 400 and says "User already exists", that's fine too.
                if (err.includes('already exists') || res.status === 409) {
                     console.log(`[PASS] Exists: ${d.email}`);
                     successCount++;
                } else {
                     console.log(`[FAIL] ${d.email} - HTTP ${res.status}: ${err}`);
                }
            }
        } catch (e) {
            console.error(`[CRASH] ${d.email} - ${e.message}`);
        }
        
        // Add a tiny delay to not overwhelm the edge proxy
        await new Promise(r => setTimeout(r, 100));
    }
    
    console.log(`\n✅ API Seeding Completed. Validated/Created ${successCount} out of ${definitions.length} roles.`);
}

seedViaAPI();
