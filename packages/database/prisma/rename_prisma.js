// Governance - Category: service | Purpose: Database data model, schema migrations, and client persistence interfaces.
const fs = require('fs');
const path = require('path');

const schemaDir = path.join(__dirname, 'schema');
const files = fs.readdirSync(schemaDir).filter(f => f.endsWith('.prisma'));

console.log(`Scanning ${files.length} Prisma files...`);

let replacements = {
    'PswProfile': 'ProviderProfile',
    'pswProfile': 'providerProfile',
    'pswId': 'providerId',
    'assignedPswId': 'assignedProviderId',
    'PswDocument': 'ProviderDocument',
    'PswAvailability': 'ProviderAvailability',
    'psw_profiles': 'provider_profiles',
    '@map("psw_id")': '@map("provider_id")',
    'psw_documents': 'provider_documents',
    'psw_availability': 'provider_availability',
    'pswVitals': 'providerVitals',
    'PswVitalSign': 'ProviderVitalSign',
    'psw_vital_signs': 'provider_vital_signs',
    'shiftCheckIns': 'shiftCheckIns',
    'PswShiftLog': 'ProviderShiftLog',
    'psw_shift_logs': 'provider_shift_logs',
    'pswTo': 'providerTo',
    'PswTo': 'ProviderTo',
    'psw': 'provider'
};

let filesUpdated = 0;

files.forEach(file => {
    const filePath = path.join(schemaDir, file);
    let original = fs.readFileSync(filePath, 'utf8');
    let content = original;

    // Ordered replacements
    content = content.replace(/PswProfile/g, 'ProviderProfile');
    content = content.replace(/pswProfile/g, 'providerProfile');
    content = content.replace(/assignedPswId/g, 'assignedProviderId');
    content = content.replace(/pswId/g, 'providerId');
    content = content.replace(/PswDocument/g, 'ProviderDocument');
    content = content.replace(/PswAvailability/g, 'ProviderAvailability');
    content = content.replace(/psw_profiles/g, 'provider_profiles');
    content = content.replace(/psw_documents/g, 'provider_documents');
    content = content.replace(/psw_availability/g, 'provider_availability');
    content = content.replace(/psw_id/g, 'provider_id');
    content = content.replace(/pswVitals/g, 'providerVitals');
    content = content.replace(/PswVitalSign/g, 'ProviderVitalSign');
    content = content.replace(/PswShiftLog/g, 'ProviderShiftLog');
    content = content.replace(/psw_shift_logs/g, 'provider_shift_logs');
    content = content.replace(/PswTo/g, 'ProviderTo');
    
    // Add the ProviderType enum to 02_care.prisma if we find the ProviderProfile map
    if (content.includes('model ProviderProfile') && !content.includes('providerType')) {
        content = content.replace(
            /(model ProviderProfile\s*{[\s\S]*?)(isApproved)/, 
            '$1providerType String @default("PSW") @map("provider_type")\n  $2'
        );
    }

    if (content !== original) {
        fs.writeFileSync(filePath, content, 'utf8');
        filesUpdated++;
    }
});

console.log(`Updated ${filesUpdated} files with Unified Provider terms.`);
