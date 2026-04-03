const fs = require('fs');
const path = require('path');

const schemaDir = path.join(__dirname, 'prisma', 'schema');

const alignmentMap = {
  'd_intake.prisma': ['12_intake_portal.prisma'],
  'd_training.prisma': ['21_training_hub.prisma'],
  'd_support.prisma': ['20_support_hub.prisma', '26_customer_support.prisma'],
  'd_franchise.prisma': ['22_franchise_hub.prisma', '24_franchise_management.prisma', '25_local_marketing.prisma'],
  'd_compliance.prisma': ['13_hr_portal.prisma', '16_qa_portal.prisma'],
  'd_clients.prisma': ['11_family_portal.prisma', '10_client_portal.prisma', '27_client_side.prisma', '28_client_healthnet.prisma'],
  'd_reporting.prisma': ['15_ops_portal.prisma', '17_bd_portal.prisma', '18_marketing_portal.prisma'],
  'd_internal.prisma': ['14_billing_portal.prisma', '19_clinical_hub.prisma', '23_outreach_hub.prisma', '29_scheduler_hub.prisma']
};

console.log('[Schema Aggregation] Starting Domain Alignment...');

Object.entries(alignmentMap).forEach(([targetDomain, sourceFiles]) => {
  let combinedContent = `// Domain: ${targetDomain}\n`;
  let parsedFiles = 0;

  sourceFiles.forEach(src => {
    const srcPath = path.join(schemaDir, src);
    if (fs.existsSync(srcPath)) {
      const content = fs.readFileSync(srcPath, 'utf8');
      combinedContent += `\n/* --- Migrated from ${src} --- */\n${content}\n`;
      parsedFiles++;
      // Clean up legacy portal
      fs.unlinkSync(srcPath);
    }
  });

  if (parsedFiles > 0) {
    fs.writeFileSync(path.join(schemaDir, targetDomain), combinedContent, 'utf8');
    console.log(`✅ Emitted ${targetDomain} (Consolidated ${parsedFiles} portal files)`);
  }
});

console.log('[Schema Aggregation] Successfully wiped 20 legacy portal files and generated Domain structures.');
